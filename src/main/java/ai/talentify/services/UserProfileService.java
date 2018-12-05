package ai.talentify.services;

import java.util.HashMap;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import ai.talentify.db.utils.DBUtils;
import ai.talentify.error.messages.AuthenticationMessages;

public class UserProfileService {
	private static final Logger logger = LogManager.getLogger(UserProfileService.class);

	public HashMap<String, String> getProfile(int userID) {
		String sql = "SELECT user_profile.\"name\", istar_user.email, istar_user.mobile, user_profile.profile_image, sales_manager_profile.timezone, sales_manager_profile.\"location\", sales_manager_profile.currency, sales_manager_profile.\"language\", istar_user.ID FROM sales_manager_profile, user_profile, istar_user WHERE istar_user. ID = sales_manager_profile.user_id AND user_profile.user_id = istar_user. ID and istar_user.ID="
				+ userID;
		logger.info(sql);
		return new DBUtils().executeQuery(sql).get(0);
	}

	public String updateProfile(String managerId, String name, String timezone, String location, String language,
			String currency, String picture) {
		String sql1 = "update user_profile set \"name\"='" + name + "',\"profile_image\"='" + picture
				+ "' where user_id=" + Integer.parseInt(managerId) + ";";
		new DBUtils().insertIntoDB(sql1);

		String sql2 = "update sales_manager_profile set timezone='" + timezone + "',location='" + location
				+ "' ,language='" + language + "',currency='" + currency + "' where user_id="
				+ Integer.parseInt(managerId) + ";";
		new DBUtils().insertIntoDB(sql2);

		return AuthenticationMessages.PROFILE_CHANGED_SUCCESSFULLY;
	}
}
