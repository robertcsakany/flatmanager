package org.liveSense.sample.flatmanager.server.rest;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.jcr.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

import org.apache.commons.lang.StringUtils;
import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.ReferencePolicy;
import org.apache.felix.scr.annotations.Service;
import org.apache.sling.jcr.api.SlingRepository;
import org.liveSense.sample.flatmanager.i18n.FlatManagerMessages;
import org.liveSense.sample.flatmanager.server.rest.api.FlatManagerError;
import org.liveSense.sample.flatmanager.server.rest.api.FlatManagerResult;
import org.liveSense.server.i18n.service.I18nService.I18nService;
import org.liveSense.service.captcha.CaptchaService;
import org.liveSense.service.cxf.WebServiceMarkerInterface;
import org.liveSense.service.cxf.WebServiceRegistrationListener;
import org.liveSense.service.languageselector.LanguageSelectorService;
import org.liveSense.service.mail.activation.ActivationService;
import org.liveSense.service.securityManager.SecurityManagerService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


@Component(immediate=true, metatype=true)
@Service(WebServiceMarkerInterface.class)
@Properties(value = { 
		@Property(name = WebServiceRegistrationListener.WS_PATH, value=FlatManagerRegistrationService.FLATMANAGER_REGISTRATION_SERVICE_URL),
		@Property(name = WebServiceRegistrationListener.WS_TYPE, value="jaxrs")
})
@SuppressWarnings({ "serial", "restriction" })
public class FlatManagerRegistrationService implements WebServiceMarkerInterface {
	
	
	private final Logger log = LoggerFactory.getLogger(FlatManagerRegistrationService.class);

	public static final String FLATMANAGER_REGISTRATION_SERVICE_URL = "/flatManagerRegistrationService";

	@Reference(cardinality=ReferenceCardinality.MANDATORY_UNARY, policy=ReferencePolicy.DYNAMIC)
	private CaptchaService captchaService;

	@Reference(cardinality=ReferenceCardinality.MANDATORY_UNARY, policy=ReferencePolicy.DYNAMIC)
	private I18nService i18nService;

	@Reference(cardinality=ReferenceCardinality.MANDATORY_UNARY, policy=ReferencePolicy.DYNAMIC)
	private LanguageSelectorService languageSelectorService;

	@Reference(cardinality=ReferenceCardinality.MANDATORY_UNARY, policy=ReferencePolicy.DYNAMIC)
	private SecurityManagerService securityManagerService;
	
	@Reference(cardinality=ReferenceCardinality.MANDATORY_UNARY, policy=ReferencePolicy.DYNAMIC)
	private ActivationService activationService;

	@Reference
	SlingRepository repsoitory;
	
	@Context private HttpServletRequest servletRequest;
	@Context private HttpServletResponse servletResponse;
	
	/**
	 * Register user
	 * 
	 * Test with CURL:
	 *  curl -X POST -d "userName=admin" http://localhost:8080/webservices/saasRegistrationService/register.json?locale=hu_HU
	 *  returns: {"errors":["A admin felhasználó már létezik"],"ok":false}
	 *  
	 *  curl -X POST -d "userName=admin" http://localhost:8080/webservices/saasRegistrationService/register?locale=hu_HU
	 *  returns: <?xml version="1.0" encoding="UTF-8" standalone="yes"?><saasRegistrationResult><errors><errors>A admin felhasználó már létezik</errors></errors><ok>false</ok></saasRegistrationResult>
	 * 
	 * @param userName
	 * @param fullName
	 * @param email
	 * @param emailConfirm
	 * @param phone
	 * @param password
	 * @param passwordConfirm
	 * @param captchaCode
	 * @return 
	 */


	private Locale getLocale() {
		return languageSelectorService.getLocaleByRequest(servletRequest);
	}
	
	private FlatManagerMessages getMessages() throws IOException {
		return i18nService.create(FlatManagerMessages.class, getLocale());
	}
	
	
	public enum UserType {
		OWNER,
		RENTER
	}

	public enum ActivationType {
		OWNERREGISTRATION,
		RENTERREGISTRATION
	}

	@POST
	@Path("/register")
	@Consumes(value={MediaType.MULTIPART_FORM_DATA, MediaType.APPLICATION_FORM_URLENCODED})
	@Produces(value={MediaType.TEXT_XML, MediaType.APPLICATION_JSON, MediaType.TEXT_PLAIN})
	public FlatManagerResult registerUser(
			@FormParam("userName") String userName,
			@FormParam("title") String title,
			@FormParam("firstName") String firstName,
			@FormParam("middleName") String middleName,
			@FormParam("lastName") String lastName,
			@FormParam("email") String email,
			@FormParam("emailConfirm") String emailConfirm,
			@FormParam("phone") String phone,
			@FormParam("password") String password,
			@FormParam("passwordConfirm") String passwordConfirm,
			@FormParam("userType") UserType userType,
			@FormParam("flatNumber") String flatNumber,
			@FormParam("flatOwner") String flatOwner,
			@FormParam("captchaCode") String captchaCode) {
		
		
		Session jcrSession = null;

		String captchaId;
		List<FlatManagerError> errors = new ArrayList<FlatManagerError>();

		captchaId = captchaService.extractCaptchaIdFromRequest(servletRequest);

		FlatManagerMessages msg = null;
					
		// FIRST STEP
		// Getting messages by browser's or user's locale
		Locale locale = languageSelectorService.getLocaleByRequest(servletRequest);
		try {
			msg = i18nService.create(FlatManagerMessages.class, locale);
		} catch (IOException e) {
			errors.add(new FlatManagerError("userName", "Internal error"));
			return new FlatManagerResult(errors);
		}
		
		try {
			// SECOND STEP
			// Check form datas form user validation
			if (userName != null && !"".equals(userName)) {
				if (userName.matches("^[a-zA-Z0-9-_.]")) {
					errors.add(new FlatManagerError("userName", msg.signup_error_illegalCharacterInUserName()));
				} else if (userName.length() < 6) {
					errors.add(new FlatManagerError("userName", msg.signup_error_userNameIsTooShort()));
				}
			} else {
				errors.add(new FlatManagerError("userName", msg.signup_error_userNameIsNull()));
			}


			if (StringUtils.isEmpty(firstName) || StringUtils.isEmpty(lastName)) {
				errors.add(new FlatManagerError("lastName", msg.signup_error_theFullNameIsNull()));			
			}

			if (email == null || "".equals(email)) {
				errors.add(new FlatManagerError("email", msg.signup_error_emailIsNull()));
			} else {

				//Checks for email addresses starting with
				//inappropriate symbols like dots or @ signs.
				Pattern p = Pattern.compile("^\\.|^\\@");
				Matcher m = p.matcher(email);
				if (m.find()) {
					errors.add(new FlatManagerError("email", msg.signup_error_emailCantStartWithDotOrAt()));
				}

				//Checks for email addresses that start with
				//www. and prints a message if it does.
				p = Pattern.compile("^www\\.");
				m = p.matcher(email);
				if (m.find()) {
					errors.add(new FlatManagerError("email", msg.signup_error_emailCantStartWithWww()));
				}

				p = Pattern.compile("[^A-Za-z0-9\\.\\@_\\-~#]+");
				m = p.matcher(email);
				if (m.find()) {
					errors.add(new FlatManagerError("email", msg.signup_error_emailIllegalCharacter()));
				}
			}
			if (password == null || "".equals(password)) {
				errors.add(new FlatManagerError("password", msg.signup_error_passwordIsNull()));
			} else {
				if (password.length() < 6) {
					errors.add(new FlatManagerError("password", msg.signup_error_passwordIsTooShort()));
				}
			}
			if (email == null || emailConfirm == null || !email.equals(emailConfirm)) {
				errors.add(new FlatManagerError("emailConfirm", msg.signup_error_emailConfirmNotMatch()));
			}
			if (password == null || passwordConfirm == null || !password.equals(passwordConfirm)) {
				errors.add(new FlatManagerError("passwordConfirm", msg.signup_error_passwordConfirmNotMatch()));
			}

			if (errors.isEmpty()) {
				jcrSession = repsoitory.loginAdministrative(null);
			
				Map<String, Object> props = new HashMap<String, Object>();
				props.put("title", title);
				props.put("firstName", firstName);
				props.put("middleName", middleName);
				props.put("lastName", lastName);
				props.put("email", email);
				props.put("phone", phone);
				props.put("status", "INACTIVE");
				props.put("userType", userType);				
				props.put("flatOwner", flatOwner);
				props.put("flatNumber", flatNumber);
				props.put("activationType", userType == null ? null : userType.toString()+"REGISTRATION");
				
				securityManagerService.addUser(jcrSession, userName, passwordConfirm, props);
				
				String activationCode = UUID.randomUUID().toString();
				props.put("userName", userName);
				activationService.addActivationCode(jcrSession, activationCode, props);
				
				// TODO Internal message to Manager
				
				if (jcrSession != null && jcrSession.isLive() && jcrSession.hasPendingChanges()) {
					jcrSession.save();
				}
			}
		} catch (Throwable e) {
			errors.add(new FlatManagerError(e.getMessage()));
			return new FlatManagerResult(errors);
		} finally {
			if (jcrSession != null && jcrSession.isLive()) {
				jcrSession.logout();
			}
		}
		return new FlatManagerResult();
	}
	
	
	@POST
	@Path("/activate")
	@Consumes(value={MediaType.MULTIPART_FORM_DATA, MediaType.APPLICATION_FORM_URLENCODED})
	@Produces(value={MediaType.TEXT_XML, MediaType.APPLICATION_JSON, MediaType.TEXT_PLAIN})
	public FlatManagerResult activateUser(
				@FormParam("activationCode") String activationCode) {

		Session jcrSession = null;
		List<FlatManagerError> errors = new ArrayList<FlatManagerError>();

		try {
			jcrSession = repsoitory.loginAdministrative(null);
			activationService.checkActivationCode(jcrSession, activationCode);
		
		} catch (Throwable e) {
			errors.add(new FlatManagerError(e.getMessage()));
			return new FlatManagerResult(errors);
		} finally {
			if (jcrSession != null && jcrSession.isLive()) {
				jcrSession.logout();
			}
		}
		return new FlatManagerResult();
	}
	

/*		
	@POST
	@Path("/passwordreset")
	@Consumes(value={MediaType.MULTIPART_FORM_DATA, MediaType.APPLICATION_FORM_URLENCODED})
	@Produces(value={MediaType.TEXT_XML, MediaType.APPLICATION_JSON, MediaType.TEXT_PLAIN})
	public FlatManagerResult sendPasswordReset(
			@FormParam("userName") String userName,
			@FormParam("email") String email) {

		LibraSession libraSession = null;
		List<FlatManagerError> errors = new ArrayList<FlatManagerError>();
		Session jcrSession = null;
		Connection sqlConnection = null;

		try {
			libraSession = saasDataService.getLibraSession(null, servletRequest, null);
			jcrSession = libraSession.getJcrSession();
			sqlConnection = libraSession.getConnection();
			if (jcrSession == null) throw new LibraException(libraSession.getGlobalMessage().connection_error());
			if (sqlConnection == null) throw new LibraException(libraSession.getGlobalMessage().connection_error());

			FlatManagerResult res = saasDataService.sendPasswordReset(libraSession, userName, email);

			if (res.isOk()) {
				if (jcrSession != null && jcrSession.isLive() && jcrSession.hasPendingChanges()) {
					jcrSession.save();
				}
				if (sqlConnection != null) {
					sqlConnection.commit();
				}
			}
			return res;
		} catch (Throwable e) {
			LibraException le =
					ExceptionConverter.toLibraException(e, this.getClass().toString(), libraSession.getGlobalMessage(),
							libraSession.getMessageResourceBundle());

			errors.add(new FlatManagerError(le.getMessage()));
			return new FlatManagerResult(errors);
		} finally {
			if (sqlConnection != null) {
				try {
					sqlConnection.close();
				} catch (Throwable th) {
					log.warn("Could not logout sql", th);
				}
			}
			if (libraSession != null) {
				try {
					libraSession.close();
				} catch (Throwable th) {
					log.warn("Could not logout session", th);
				}
			}
			if (jcrSession != null && jcrSession.isLive()) {
				jcrSession.logout();
			}
		}
	}



	@POST
	@Path("/changepassword")
	@Consumes(value={MediaType.MULTIPART_FORM_DATA, MediaType.APPLICATION_FORM_URLENCODED})
	@Produces(value={MediaType.TEXT_XML, MediaType.APPLICATION_JSON, MediaType.TEXT_PLAIN})
	public FlatManagerResult changePassword (
			@FormParam("resetCode") String resetCode,
			@FormParam("password") String password,
			@FormParam("passwordConfirm") String passwordConfirm) {

		LibraSession libraSession = null;
		List<FlatManagerError> errors = new ArrayList<FlatManagerError>();
		Session jcrSession = null;
		Connection sqlConnection = null;

		try {
			libraSession = saasDataService.getLibraSession(null, servletRequest, null);
			jcrSession = libraSession.getJcrSession();
			sqlConnection = libraSession.getConnection();
			if (jcrSession == null) throw new LibraException(libraSession.getGlobalMessage().connection_error());
			if (sqlConnection == null) throw new LibraException(libraSession.getGlobalMessage().connection_error());
			
			FlatManagerResult res = saasDataService.changePassword(libraSession, resetCode, password, passwordConfirm);
			if (res.isOk()) {
				if (libraSession.getJcrSession() != null && libraSession.getJcrSession().isLive() && libraSession.getJcrSession().hasPendingChanges()) {
					libraSession.getJcrSession().save();
				}
				if (libraSession.getConnection() != null) {
					libraSession.getConnection().commit();
				}
			}
			return res;
		} catch (Throwable e) {
			LibraException le =
					ExceptionConverter.toLibraException(e, this.getClass().toString(), libraSession.getGlobalMessage(),
							libraSession.getMessageResourceBundle());

			errors.add(new FlatManagerError(le.getMessage()));
			return new FlatManagerResult(errors);
		} finally {
			if (sqlConnection != null) {
				try {
					sqlConnection.close();
				} catch (Throwable th) {
					log.warn("Could not logout sql", th);
				}
			}
			if (libraSession != null) {
				try {
					libraSession.close();
				} catch (Throwable th) {
					log.warn("Could not logout session", th);
				}
			}
			if (jcrSession != null && jcrSession.isLive()) {
				jcrSession.logout();
			}
		}
	}
	*/

}
