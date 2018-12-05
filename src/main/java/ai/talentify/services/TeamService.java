/**
 * 
 */
package ai.talentify.services;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import ai.talentify.db.utils.DBUtils;
import ai.talentify.error.messages.TeamMessages;

/**
 * @author istar
 *
 */
public class TeamService {
	private static final Logger logger = LogManager.getLogger(TeamService.class);

	public ArrayList<HashMap<String, String>> getTeams(int managetID) {
		ArrayList<HashMap<String, String>> teamsData = new ArrayList<>();
		String sql = "select * from istar_group where organization_id=(select organizationid from org_user where userid="
				+ managetID + ") and group_type='SALES_TEAM'";
		logger.info(sql);
		DBUtils utils = new DBUtils();
		ArrayList<HashMap<String, String>> teamList = utils.executeQuery(sql);
		for (HashMap<String, String> team : teamList) {
			HashMap<String, String> teamData = new HashMap<>();
			teamData.put("id", team.get("id"));
			teamData.put("name", team.get("name"));
			teamData.put("description", team.get("description"));
			teamsData.add(teamData);
		}
		return teamsData;
	}

	public HashMap<String, String> getTeamDetails(int teamID) {
		String sql = "select * from istar_group where id=" + teamID;
		return new DBUtils().executeQuery(sql).get(0);
	}

	public ArrayList<HashMap<String, String>> getTeamsMeambers(int teamID) {
		String sql = "SELECT istar_user.id, user_profile.\"name\", user_profile.profile_image AS picture,  istar_user.email, istar_user.mobile FROM istar_user, group_user, user_profile WHERE group_user.userid = istar_user.\"id\" AND user_profile.user_id = istar_user. ID AND group_user.qroupid ="
				+ teamID;
		logger.info(sql);
		DBUtils utils = new DBUtils();

		return utils.executeQuery(sql);
	}

	public String removeTeamsMeamber(int user_id, int teamId) {
		String sql = "delete from group_user where qroupid=" + teamId + " and userid=" + user_id;
		new DBUtils().insertIntoDB(sql);
		logger.info(sql);
		// r(Integer.parseInt(user_id),Integer.parseInt(teamId))));
		return TeamMessages.USER_REMOVED;
	}

	public String addTeamMember(int user_id, int teamId) {
		String sql = "INSERT INTO group_user (qroupid, userid) VALUES ('" + teamId + "', '" + user_id + "');";
		new DBUtils().insertIntoDB(sql);
		logger.info(sql);
		return TeamMessages.USER_ADDED;

	}

	public ArrayList<HashMap<String, String>> getOrgMembers(int teamID, int orgID, String pattern) {
		long now = System.currentTimeMillis();
		ArrayList<HashMap<String, String>> teamsMembers = new ArrayList<>();
		String sql = "SELECT distinct istar_user. ID, user_profile.\"name\", istar_user.email, user_profile.profile_image as picture FROM group_user, istar_group, "
				+ "istar_user, user_profile WHERE istar_group. ID = group_user.qroupid AND istar_group.organization_id ="
				+ orgID + " AND group_user.qroupid !=" + teamID
				+ " AND istar_user. ID = group_user.userid and istar_user.id=user_profile.user_id AND ( user_profile. NAME LIKE '%"
				+ pattern + "%' OR istar_user.email " + "LIKE '%" + pattern + "%' )";
		DBUtils utils = new DBUtils();
		logger.info(sql);

		logger.info(System.currentTimeMillis() - now + " Millsecs Taken ");
		return teamsMembers = utils.executeQuery(sql);
	}

	public String updateTeam(String teamId, String teamName, String teamDescrption) {
		String sqlUpdate = "update istar_group set \"name\"='" + teamName + "' , description='" + teamDescrption
				+ "' where id=" + teamId;
		new DBUtils().insertIntoDB(sqlUpdate);
		return TeamMessages.TEAM_UPDATED_SUCCESSFULLY;
	}

	public String createTeam(String teamName, String teamDescrption, String organization_id) {
		String sqlUpdate = "INSERT INTO \"public\".\"istar_group\" (\"created_at\", \"name\", \"updated_at\", \"organization_id\", \"group_code\", \"description\", \"created_year\", \"parent_group_id\", \"group_type\", \"is_historical_group\", \"group_mode_type\", \"start_date\", \"enrolled_students\", \"is_deleted\", \"max_members\") VALUES "
				+ "                                                ('now()', '" + teamName + "', 'now()', '"
				+ organization_id + "', 'NULL', '" + teamDescrption
				+ "', '2018', NULL, 'SALES_TEAM', 'f', 'BOTH', NULL, '0', 'f', NULL) returning id;";
		return new DBUtils().insertIntoDBWithGeneratedKey(sqlUpdate) + "";
	}

	public String getOrganizationFromManager(String managerID) {
		String sql = "select org_user.organizationid as organization_id from org_user where userid=" + managerID;
		logger.info(sql);
		return new DBUtils().executeQuery(sql).get(0).get("organization_id");
	}
}
