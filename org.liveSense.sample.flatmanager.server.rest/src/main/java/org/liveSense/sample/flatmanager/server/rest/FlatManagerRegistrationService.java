package org.liveSense.sample.flatmanager.server.rest;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.jcr.Node;
import javax.jcr.PathNotFoundException;
import javax.jcr.RepositoryException;
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
import org.apache.jackrabbit.api.security.user.User;
import org.apache.jackrabbit.value.StringValue;
import org.apache.sling.jcr.api.SlingRepository;
import org.liveSense.core.wrapper.JcrNodeWrapper;
import org.liveSense.sample.flatmanager.i18n.FlatManagerMessages;
import org.liveSense.sample.flatmanager.server.rest.api.FlatManagerError;
import org.liveSense.sample.flatmanager.server.rest.api.FlatManagerResult;
import org.liveSense.sample.flatmanager.server.rest.api.RegistrationRequest;
import org.liveSense.sample.flatmanager.server.rest.api.UserType;
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
public class FlatManagerRegistrationService implements WebServiceMarkerInterface, FlatManagerRegistrationInterface {


	private final Logger log = LoggerFactory.getLogger(FlatManagerRegistrationService.class);

	public static final String FLATMANAGER_REGISTRATION_SERVICE_URL = "/flatManagerRegistrationService";

	public static final String FLATMANAGER_USERHOME = "flatmanager/home";

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


	private Locale getLocale() {
		return languageSelectorService.getLocaleByRequest(servletRequest);
	}

	private FlatManagerMessages getMessages() throws IOException {
		return i18nService.create(FlatManagerMessages.class, getLocale());
	}
	
	private void sendMessage(Session session, String userName, String from, String subject, String message) throws PathNotFoundException, RepositoryException {
		Node userHome = session.getRootNode().getNode(FLATMANAGER_USERHOME+"/"+userName);
		Node messageHome = null;
		if (!userHome.hasNode("messages")) {
			messageHome = userHome.addNode("messages");
		} else {
			messageHome = userHome.getNode("messages");
		}
		Node messageNode = messageHome.addNode(new Long(Calendar.getInstance().getTimeInMillis()).toString());
		messageNode.setProperty("date", Calendar.getInstance());
		messageNode.setProperty("sling:resourceType", "flatmanager/message");
		messageNode.setProperty("from", from);
		messageNode.setProperty("message", message);
		messageNode.setProperty("subject", subject);
		
		// TODO Sending email
	}
	
	/* (non-Javadoc)
	 * @see org.liveSense.sample.flatmanager.server.rest.FlatManagerRegistrationInterface#registerUser(java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, org.liveSense.sample.flatmanager.server.rest.api.UserType, java.lang.Long, java.lang.String, java.lang.String)
	 */
	
	@Override
	@POST
	@Path("/register")
	@Consumes(value={MediaType.MULTIPART_FORM_DATA, MediaType.APPLICATION_FORM_URLENCODED, MediaType.APPLICATION_JSON})
	@Produces(value={MediaType.TEXT_XML, MediaType.APPLICATION_JSON, MediaType.TEXT_PLAIN})
	public FlatManagerResult registerUser(RegistrationRequest registration) {


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
			if (StringUtils.isNotEmpty(registration.getUserName())) {
				if (registration.getUserName().matches("^[a-zA-Z0-9-_.]")) {
					errors.add(new FlatManagerError("userName", msg.signup_error_illegalCharacterInUserName()));
				} else if (registration.getUserName().length() < 6) {
					errors.add(new FlatManagerError("userName", msg.signup_error_userNameIsTooShort()));
				}
			} else {
				errors.add(new FlatManagerError("userName", msg.signup_error_userNameIsNull()));
			}


			if (StringUtils.isEmpty(registration.getFirstName()) || StringUtils.isEmpty(registration.getLastName())) {
				errors.add(new FlatManagerError("lastName", msg.signup_error_theFullNameIsNull()));			
			}

			if (StringUtils.isEmpty(registration.getEmail())) {
				errors.add(new FlatManagerError("email", msg.signup_error_emailIsNull()));
			} else {

				//Checks for email addresses starting with
				//inappropriate symbols like dots or @ signs.
				Pattern p = Pattern.compile("^\\.|^\\@");
				Matcher m = p.matcher(registration.getEmail());
				if (m.find()) {
					errors.add(new FlatManagerError("email", msg.signup_error_emailCantStartWithDotOrAt()));
				}

				//Checks for email addresses that start with
				//www. and prints a message if it does.
				p = Pattern.compile("^www\\.");
				m = p.matcher(registration.getEmail());
				if (m.find()) {
					errors.add(new FlatManagerError("email", msg.signup_error_emailCantStartWithWww()));
				}

				p = Pattern.compile("[^A-Za-z0-9\\.\\@_\\-~#]+");
				m = p.matcher(registration.getEmail());
				if (m.find()) {
					errors.add(new FlatManagerError("email", msg.signup_error_emailIllegalCharacter()));
				}
			}
			if (StringUtils.isEmpty(registration.getPassword())) {
				errors.add(new FlatManagerError("password", msg.signup_error_passwordIsNull()));
			} else {
				if (registration.getPassword().length() < 6) {
					errors.add(new FlatManagerError("password", msg.signup_error_passwordIsTooShort()));
				}
			}
			if (StringUtils.isEmpty(registration.getEmail()) || StringUtils.isEmpty(registration.getEmailConfirm()) 
					|| !registration.getEmail().equals(registration.getEmailConfirm())) {
				errors.add(new FlatManagerError("emailConfirm", msg.signup_error_emailConfirmNotMatch()));
			}
			if (StringUtils.isEmpty(registration.getPassword()) || StringUtils.isEmpty(registration.getPassword()) 
					|| !registration.getPassword().equals(registration.getPasswordConfirm())) {
				errors.add(new FlatManagerError("passwordConfirm", msg.signup_error_passwordConfirmNotMatch()));
			}

			if (StringUtils.isEmpty(registration.getCaptchaCode())) {
				errors.add(new FlatManagerError("captchaCode", msg.signup_error_captchaCodeIsEmpty()));
			} else if (!captchaService.validateCaptchaResponse(servletRequest, registration.getCaptchaCode())) {
				errors.add(new FlatManagerError("captchaCode", msg.captcha_code_is_invalid()));				
			}
			
			if (errors.isEmpty()) {
				jcrSession = repsoitory.loginAdministrative(null);

				Map<String, Object> props = new HashMap<String, Object>();
				props.put("title", registration.getTitle());
				props.put("firstName", registration.getFirstName());
				props.put("middleName", registration.getMiddleName());
				props.put("lastName", registration.getLastName());
				props.put("email", registration.getEmail());
				props.put("phone", registration.getPhone());
				props.put("userType", registration.getUserType());				
				props.put("flatOwner", registration.getFlatOwner());
				props.put("flatNumber", registration.getFlatNumber());
				props.put("activationType", registration.getUserType() == null ? null : registration.getUserType().toString()+"REGISTRATION");

				securityManagerService.addUser(jcrSession, registration.getUserName(), registration.getPassword(), props);

				String activationCode = UUID.randomUUID().toString();
				props.put("userName", registration.getUserName());
				activationService.addActivationCode(jcrSession, activationCode, props);

				boolean isOwner = registration.getUserType() == null ? false : registration.getUserType() == UserType.OWNER;
				
				sendMessage(jcrSession, registration.getUserName(), isOwner ? registration.getFlatOwner() : "KOZOS KEPVISELO", "Aktivacio megtortent", "Sikeresen aktivaltuk felhasznalojat");
				
				if (jcrSession != null && jcrSession.isLive() && jcrSession.hasPendingChanges()) {
					jcrSession.save();
				}
			} else {
				return new FlatManagerResult(errors);				
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


	/* (non-Javadoc)
	 * @see org.liveSense.sample.flatmanager.server.rest.FlatManagerRegistrationInterface#activateUser(java.lang.String)
	 */
	@Override
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
			if (activationService.checkActivationCode(jcrSession, activationCode)) {
				JcrNodeWrapper jcrnv = activationService.getActivationFields(jcrSession, activationCode);
				
				User user = securityManagerService.getUserByName(jcrSession, jcrnv.getProperties().get("userName").toString());
				
				if (jcrnv.getProperties().get("userType").toString().equals(UserType.OWNER.toString())) {
					securityManagerService.addPrincipalToGroup(jcrSession, user.getID(), "Owners");
				} else if (jcrnv.getProperties().get("userType").toString().equals(UserType.RENTER.toString())) {
					securityManagerService.addPrincipalToGroup(jcrSession, user.getID(), "Renters");
				}
				for (String key : jcrnv.getProperties().keySet()) {
					if (!key.equalsIgnoreCase("userName") && 
							!key.equalsIgnoreCase("password") &&
							!key.equalsIgnoreCase("activationType")) {
						user.setProperty(key, jcrnv.getProperties().get(key).getProperty().getValue());
					}
				}
				user.setProperty("status", new StringValue("ACTIVE"));
				securityManagerService.createUserHome(jcrSession, user.getID(), "flatmanager");
				activationService.removeActivationCode(jcrSession, activationCode);
				if (jcrSession.isLive() && jcrSession.hasPendingChanges()) {
					jcrSession.save();
				}
			} else {
				errors.add(new FlatManagerError("Error"));
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
