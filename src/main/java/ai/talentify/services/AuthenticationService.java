/**
 * 
 */
package ai.talentify.services;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import ai.talentify.db.utils.DBUtils;
import ai.talentify.error.messages.AuthenticationMessages;
import ai.talentify.exceptions.ServiceReponse;
import ai.talentify.ui.utils.StringUtils;

/**
 * @author Vaibhav Verma
 *
 */
public class AuthenticationService {
	private static final Logger logger = LogManager.getLogger(AuthenticationService.class);

	public ServiceReponse authenticate(String email, String encryptedPassword) {
		Long now = System.currentTimeMillis();
		HashMap<String, Object> userData = new HashMap<>();
		try {
			String sql = "SELECT \"public\".\"role\".role_name as name , \"public\".istar_user.\"password\", \"public\".user_profile.user_id as id, \"public\".istar_user.email, \"public\".user_profile.\"name\" FROM \"public\".istar_user INNER JOIN \"public\".user_role ON \"public\".istar_user.\"id\" = \"public\".user_role.userid INNER JOIN \"public\".\"role\" ON \"public\".\"role\".\"id\" = \"public\".user_role.roleid INNER JOIN \"public\".user_profile ON \"public\".user_profile.user_id = \"public\".istar_user.\"id\" where (istar_user.email ='"+email+"' or istar_user.mobile='"+email+"') and (role_name = 'SALES_MANAGER' or role_name = 'SALES_ASSOCIATE' or role_name = 'OWNER' or role_name = 'IT_ADMIN' or role_name = 'SUPER_ADMIN')";
			encryptedPassword  = StringUtils.getMd5(encryptedPassword);	
			logger.info(sql);
			ArrayList<HashMap<String, String>> data = new DBUtils().executeQuery(sql);
			if (data.size() == 0) {
				return new ServiceReponse(-1, AuthenticationMessages.WRONG_USERNAME);
			} else {
				if (data.get(0).get("password").equalsIgnoreCase(encryptedPassword)) {
					ServiceReponse response = new ServiceReponse(-1, AuthenticationMessages.AUTH_SUCCESSFULL);
					userData.put("userid", data.get(0).get("id"));
					userData.put("role", data.get(0).get("name"));
					response.setData(userData);
					logger.info("Time take for login ->" + (System.currentTimeMillis()-now));
					return response;
				} else {
					return new ServiceReponse(-1, AuthenticationMessages.WRONG_PASSWORD);
				}
			}
		} catch (NullPointerException e) {
			return new ServiceReponse(-1, AuthenticationMessages.NULL_PARAMS_PASSED);

		}
		
	}

	public ServiceReponse changePassword(String email, String nonEncryptedPassword) {
		try {
			String sqlToGetUser = "select id FROM sales_user where email='" + email + "'";
			ArrayList<HashMap<String, String>> data = new DBUtils().executeQuery(sqlToGetUser);
			if (data.size() == 0) {
				return new ServiceReponse(-1, AuthenticationMessages.WRONG_USERNAME);
			} else {
				String sqlUpdateQuery = "update sales_user set \"password\"='" + nonEncryptedPassword + "' where id="
						+ data.get(0).get("id");
				new DBUtils().insertIntoDB(sqlUpdateQuery);

				return new ServiceReponse(0, AuthenticationMessages.PASSWORD_CHANGED_SUCCESSFULLY);

			}
		} catch (NullPointerException e) {
			return new ServiceReponse(-1, AuthenticationMessages.NULL_PARAMS_PASSED);

		}

	}

	public ServiceReponse updateProfileAssociate(int userID, String name, String profilePic, String timezoneID,
			String locationID, String languageID, String currencyID) {
		try {
			String sqlUpdateQuery = "update sales_user set currency='', \"name\"='" + name + "', time_zone='"
					+ timezoneID + "', \"location\"='" + locationID + "', \"language\"='" + languageID + "', picture='"
					+ profilePic + "' where id=" + userID;
			new DBUtils().insertIntoDB(sqlUpdateQuery);
			return new ServiceReponse(0, AuthenticationMessages.PASSWORD_CHANGED_SUCCESSFULLY);

		} catch (NullPointerException e) {
			return new ServiceReponse(-1, AuthenticationMessages.NULL_PARAMS_PASSED);

		}
	}

	public ServiceReponse updateProfileManager(int userID, String name, String profilePic, String timezoneID,
			String locationID, String languageID, String currencyID) {
		try {
			String sqlUpdateQuery = "update sales_user set currency='', \"name\"='" + name + "', time_zone='"
					+ timezoneID + "', \"location\"='" + locationID + "', \"language\"='" + languageID + "', picture='"
					+ profilePic + "' where id=" + userID;
			new DBUtils().insertIntoDB(sqlUpdateQuery);
			return new ServiceReponse(0, AuthenticationMessages.PASSWORD_CHANGED_SUCCESSFULLY);

		} catch (NullPointerException e) {
			return new ServiceReponse(-1, AuthenticationMessages.NULL_PARAMS_PASSED);

		}
	}

	public ArrayList<HashMap<String, String>> getUserData(String userID) {
		String sql = "SELECT \"public\".istar_user.email, \"public\".istar_user.mobile, \"public\".user_profile.\"name\", \"public\".user_profile.profile_image as picture, \"public\".istar_user.\"id\" FROM \"public\".user_profile INNER JOIN \"public\".istar_user ON \"public\".istar_user.\"id\" = \"public\".user_profile.user_id where istar_user.id="+userID;
		return new DBUtils().executeQuery(sql);
	}

}