package org.liveSense.sample.flatmanager.server.rest;

import org.liveSense.sample.flatmanager.server.rest.api.FlatManagerResult;
import org.liveSense.sample.flatmanager.server.rest.api.UserType;

public interface FlatManagerRegistrationInterface {

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
	FlatManagerResult registerUser(String userName,
			String title, String firstName, String middleName, String lastName,
			String email, String emailConfirm, String phone, String password,
			String passwordConfirm, UserType userType, Long flatNumber,
			String flatOwner, String captchaCode);

	FlatManagerResult activateUser(String activationCode);

}