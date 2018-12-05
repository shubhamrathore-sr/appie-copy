package ai.talentify.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.google.gson.Gson;

import ai.talentify.db.utils.DBUtils;
import ai.talentify.services.TeamService;

/**
 * Servlet implementation class LeadServlet
 */
@WebServlet(urlPatterns = "/team")
public class TeamServlet extends HttpServlet {
	private static final Logger logger = LogManager.getLogger(TeamServlet.class);
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public TeamServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String method = request.getParameter("method");

		switch (method) {
		case "GET_USER_DETAILS":
			String teamID = request.getParameter("teamID");
			String sqlQuery = "( SELECT user_profile. NAME, istar_user. ID, user_profile.profile_image as picture, COUNT (group_user.userid), NULL AS description, NULL AS team_name FROM istar_group, group_user, istar_user, user_profile WHERE istar_group. ID = group_user.qroupid AND group_user.userid = istar_user. ID AND user_profile.user_id = istar_user. ID AND istar_group. ID = "
					+ teamID
					+ " GROUP BY group_user.userid, user_profile. NAME, user_profile.profile_image, istar_user. ID LIMIT 3 ) UNION ALL SELECT 'TEAM_SUM' user_id, NULL AS ID, NULL AS picture, COUNT (userid), istar_group.description, istar_group. NAME FROM group_user, istar_group WHERE qroupid = "
					+ teamID
					+ " AND group_user.qroupid = istar_group. ID GROUP BY istar_group.description, istar_group. NAME";
			logger.info(sqlQuery);
			PrintWriter out = response.getWriter();
			if (!teamID.equalsIgnoreCase("undefined")) {
				DBUtils utils = new DBUtils();
				ArrayList<HashMap<String, String>> table = utils.executeQuery(sqlQuery);
				response.setContentType("application/json");
				out.append(new Gson().toJson(table));
			}
			out.flush();
			out.close();
			break;
		case "GET_USER_DETAILS_EXPANDED":
			String teamID1 = request.getParameter("teamID");

			PrintWriter out1 = response.getWriter();
			if (!teamID1.equalsIgnoreCase("undefined")) {
				response.setContentType("application/json");
				out1.append(new Gson().toJson(new TeamService().getTeamsMeambers(Integer.parseInt(teamID1))));

			}
			out1.flush();
			out1.close();
			break;

		case "DELETE_USER":
			String user_id = request.getParameter("user_id");
			String teamId = request.getParameter("team_id");
			response.setContentType("application/json");
			PrintWriter out3 = response.getWriter();
			out3.append(new Gson()
					.toJson(new TeamService().removeTeamsMeamber(Integer.parseInt(user_id), Integer.parseInt(teamId))));
			out3.flush();
			out3.close();
			break;

		case "GET_ORGANIZATION_MEMEBERS":
			String orgID = request.getParameter("organization_id");
			String team_id = request.getParameter("team_id");
			String pattern = request.getParameter("pattern");
			response.setContentType("application/json");
			PrintWriter out4 = response.getWriter();
			out4.append(new Gson().toJson(
					new TeamService().getOrgMembers(Integer.parseInt(team_id), Integer.parseInt(orgID), pattern)));
			out4.flush();
			out4.close();
			break;

		case "ADD_TEAM_MEMBER":
			String team_id2 = request.getParameter("team_id");
			String user_id2 = request.getParameter("user_id");
			response.setContentType("application/json");
			PrintWriter out5 = response.getWriter();
			out5.append(new Gson()
					.toJson(new TeamService().addTeamMember(Integer.parseInt(user_id2), Integer.parseInt(team_id2))));
			out5.flush();
			out5.close();
			break;

		case "UDPATE_TEAM":
			response.setContentType("application/json");
			PrintWriter out6 = response.getWriter();
			String teamName = request.getParameter("name");
			String teamDescrption = request.getParameter("description");
			String teamId11 = request.getParameter("team_id");
			out6.append(new Gson().toJson(new TeamService().updateTeam(teamId11, teamName, teamDescrption)));
			out6.flush();
			out6.close();
			break;

		case "CREATE_TEAM":
			response.setContentType("application/json");
			PrintWriter out7 = response.getWriter();
			String createTeamName = request.getParameter("name");
			String createTeamDescrption = request.getParameter("description");
			String organization_id = request.getParameter("organization_id");
			out7.append(new TeamService().createTeam(createTeamName, createTeamDescrption, organization_id));
			out7.flush();
			out7.close();
			break;

		default:
			break;
		}

	}

	/*
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 * response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
