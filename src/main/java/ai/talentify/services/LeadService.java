package ai.talentify.services;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import ai.talentify.db.utils.DBUtils;

public class LeadService {

	private static final Logger logger = LogManager.getLogger(LeadService.class);

	public ArrayList<HashMap<String, String>> getInitialLeads(int managerID, String limit, String offset) {
		long now = System.currentTimeMillis();
		String sql = "SELECT LEAD . ID AS leadID, \"lead\".company_name, json_agg (\r\n"
				+ "		json_build_object (\r\n" + "			'personID',\r\n"
				+ "			sales_contact_person.\"id\",\r\n" + "			'personMobile',\r\n"
				+ "			sales_contact_person.phone_number,\r\n" + "			'personEmail',\r\n"
				+ "			sales_contact_person.email,\r\n" + "			'personName',\r\n"
				+ "			sales_contact_person.\"name\"\r\n" + "		)\r\n"
				+ "	) AS sales_contact_persons  FROM LEAD, sales_contact_person WHERE sales_contact_person.lead_id = \"lead\". ID AND \"lead\".\"owner\" = "
				+ managerID + " GROUP BY LEAD . ID ORDER BY LEAD . ID offset " + offset + " limit " + limit + ";";
		logger.error(sql);
		ArrayList<HashMap<String, String>> data = new DBUtils().executeQuery(sql);

		logger.info(System.currentTimeMillis() - now);
		return data;
	}

	public ArrayList<HashMap<String, String>> getSalesContactPersons(int leadID) {
		String sql = "SELECT sales_contact_person.id, sales_contact_person.email, sales_contact_person.person_name, sales_contact_person.mobile, count(task.id) FROM sales_contact_person LEFT JOIN task ON task.sales_contact_id = sales_contact_person. ID WHERE sales_contact_person.lead_id = "
				+ leadID + " GROUP BY sales_contact_person.id order  by count(task.id) desc";
		return new DBUtils().executeQuery(sql);
	}

	public String getLeadDetails(String leadID) {
		String sql = "SELECT task. ID, sales_user.\"name\", pipeline.pipeline_name, sales_user.picture, task.start_date, stage_task.task_name  FROM task, sales_user, pipeline, stage_task WHERE lead_id ="
				+ leadID
				+ " AND sales_user. ID = task.actor AND pipeline. ID = task.pipeline_id and stage_task.id=task.task_type_id";
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

	public ArrayList<HashMap<String, String>> getInitialLeadsAssociate(int associateID, String assLimit,
			String assOffset) {
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
}
