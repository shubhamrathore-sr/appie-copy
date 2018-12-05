package ai.talentify.services.associate;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import ai.talentify.db.utils.DBUtils;

public class Lead {

	private static final Logger logger = LogManager.getLogger(Lead.class);

	public ArrayList<HashMap<String, String>> getLeadsManager(int managerID, String limit, String offset) {
		// TODO Auto-generated method stub
		return null;
	}

	public ArrayList<HashMap<String, String>> getLeadsAssociate(int associateID, String assLimit, String assOffset) {

		long now = System.currentTimeMillis();
		String sql = "SELECT LEAD . ID AS leadID, \"lead\".company_name, json_agg (\r\n"
				+ "		json_build_object (\r\n" + "			'personID',\r\n"
				+ "			sales_contact_person.\"id\",\r\n" + "			'personMobile',\r\n"
				+ "			sales_contact_person.phone_number,\r\n" + "			'personEmail',\r\n"
				+ "			sales_contact_person.email,\r\n" + "			'personName',\r\n"
				+ "			sales_contact_person.\"name\"\r\n" + "		)\r\n"
				+ "	) AS sales_contact_persons  FROM LEAD, sales_contact_person WHERE sales_contact_person.lead_id = \"lead\". ID AND \"lead\".\"actor\" = "
				+ associateID + " GROUP BY LEAD . ID ORDER BY LEAD . ID offset " + assOffset + " limit " + assLimit
				+ ";";
	logger.error(sql);
		ArrayList<HashMap<String, String>> data = new DBUtils().executeQuery(sql);
		logger.info(System.currentTimeMillis() - now);
		return data;

	}

	public CharSequence getLeadDetailsAssociate(String leadID) {
		String sql = "SELECT task. ID, user_profile.\"name\", pipeline.\"name\" as pipeline_name, user_profile.profile_image as picture, task.start_date, task.task_type  as task_name FROM task, user_profile, pipeline, sales_task_call WHERE sales_task_call.lead_id = "
				+ leadID
				+ " AND user_profile. user_id = task.actor AND pipeline. ID = sales_task_call.pipeline_id AND sales_task_call.task_id = task.\"id\"";
		logger.info(sql);
		ArrayList<HashMap<String, String>> executeQuery = new DBUtils().executeQuery(sql);
		if (executeQuery.size() == 0) {
			return "<div class='container-3'><button class=\"button\" style=\"width:200px;\">Allocate Now</button></div>";
		} else {
			HashMap<String, String> row = executeQuery.get(0);
			String data = "<div class=\"container-2\"><div style=\"padding: 10px; display: flex;\">\r\n"
					+ "						<div>\r\n"
					+ "							<img style=\"width: 107px; height: 107px;\" src='" + row.get("picture")
					+ "'>" + "						</div>\r\n" + "						<div class=\"detail\">\r\n"
					+ "							<h3 class=\"lead-name\">" + row.get("name") + "</h3>\r\n"
					+ "							<p class=\"pipeline-name\">Pipeline - " + row.get("pipeline_name")
					+ "</p>\r\n" + "							<p class=\"task-name\">Next Task- "
					+ row.get("task_name") + " , " + row.get("start_date") + "</p>\r\n"
					+ "						</div>\r\n" + "					</div></div>";
			return data;

		}
	}

}
