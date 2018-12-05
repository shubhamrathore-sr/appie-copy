/**
 * 
 */
package ai.talentify.services.tests;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import ai.talentify.error.messages.AuthenticationMessages;
import ai.talentify.exceptions.ServiceReponse;
import ai.talentify.services.AuthenticationService;

/**
 * @author Vaibhav Verma
 *
 */
public class AuthenitciationTestCase {
	private static final Logger logger = LogManager.getLogger(AuthenitciationTestCase.class);

	public static void main(String[] args) {
		// testNullAuth();
		// testWrongUSernameandPasswordAuth();

		// testNullPWChnage();

		testPWChnage();
	}

	private static void testPWChnage() {
		AuthenticationService service = new AuthenticationService();

		{
			ServiceReponse response = service.changePassword("devante.wuckert@yahoo.com", "devante.wuckert@yahoo.com");

			if (response.getResponseMessage().equalsIgnoreCase(AuthenticationMessages.PASSWORD_CHANGED_SUCCESSFULLY)) {
				logger.info("32 TestCase Passed");
			} else {
				logger.info("34 TestCase Failed");
			}

		}
		{
			ServiceReponse response = service.authenticate("devante.wuckert@yahoo.com", "devante.wuckert@yahoo.com");
			if (response.getResponseMessage().equalsIgnoreCase(AuthenticationMessages.AUTH_SUCCESSFULL)) {
				logger.info("41 TestCase Passed");
			} else {
				logger.info("43 TestCase Failed");
			}
		}

		{
			ServiceReponse response = service.changePassword("devante.wuckert@yahoo.com", "test123");

			if (response.getResponseMessage().equalsIgnoreCase(AuthenticationMessages.PASSWORD_CHANGED_SUCCESSFULLY)) {
				logger.info("51 TestCase Passed");
			} else {
				logger.info("53 TestCase Failed");
			}

		}
		{
			ServiceReponse response = service.authenticate("devante.wuckert@yahoo.com", "test123");
			if (response.getResponseMessage().equalsIgnoreCase(AuthenticationMessages.AUTH_SUCCESSFULL)) {
				logger.info("60 TestCase Passed");
			} else {
				logger.info("62 TestCase Failed");
			}
		}

	}

	private static void testNullPWChnage() {
		AuthenticationService service = new AuthenticationService();
		ServiceReponse response = service.changePassword(null, null);
		if (response.getResponseMessage().equalsIgnoreCase(AuthenticationMessages.NULL_PARAMS_PASSED)) {
			logger.info("TestCase Passed");
		} else {
			logger.info("TestCase Failed");
		}
	}

	public static void testNullAuth() {
		AuthenticationService service = new AuthenticationService();
		ServiceReponse response = service.authenticate(null, null);
		if (response.getResponseMessage().equalsIgnoreCase(AuthenticationMessages.NULL_PARAMS_PASSED)) {
			logger.info("TestCase Passed");
		} else {
			logger.info("TestCase Failed");
		}
	}

	public static void testWrongUSernameandPasswordAuth() {
		AuthenticationService service = new AuthenticationService();

		ServiceReponse response = service.authenticate("devante.wuckert@yahoo.com", "devante.wuckert@yahoo.com");
		if (response.getResponseMessage().equalsIgnoreCase(AuthenticationMessages.WRONG_PASSWORD)) {
			logger.info("TestCase Passed");
		} else {
			logger.info("TestCase Failed");
		}

		ServiceReponse response1 = service.authenticate("devante.wuckert@yahoo.com", "test123");
		if (response1.getResponseMessage().equalsIgnoreCase(AuthenticationMessages.AUTH_SUCCESSFULL)) {
			logger.info("TestCase Passed");
		} else {
			logger.info("TestCase Failed");
		}

	}
}
