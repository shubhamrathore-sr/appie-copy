package ai.talentify.services.associate;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.google.gson.JsonObject;
import com.twilio.sdk.CapabilityToken.DomainException;
import com.twilio.sdk.client.TwilioCapability;

import ai.talentify.db.utils.DBUtils;

public class Dashboard {
	private static final Logger logger = LogManager.getLogger(Dashboard.class);

	public List<HashMap<String, String>> getTodaysTasks(int associateId) {
		String sql = "SELECT DISTINCT task. ID AS task_id, LEAD .company_name AS company_name, sales_contact_person.\"name\" AS contact_name, sales_contact_person.phone_number AS contact_number, istar_user.mobile AS agent_mobile, \"lead\". ID AS lead_id, task.task_type, task.created_at FROM task, sales_task_call, LEAD, sales_contact_person, istar_user, task_comment WHERE task. ID = sales_task_call.task_id AND sales_task_call.lead_id = \"lead\". ID AND task.actor = "
				+ associateId
				+ " AND task.status = 'INCOMPLETE' AND sales_task_call.sales_contact_id = sales_contact_person. ID AND istar_user. ID = task.actor ORDER BY task.created_at DESC;";
		logger.info(sql);
		ArrayList<HashMap<String, String>> tasks = new DBUtils().executeQuery(sql);
		return tasks;
	}

	public ArrayList<HashMap<String, String>> taskHistoryandComments(String taskID) {
		String sql = "SELECT task. ID AS this_task, old_sales_call.task_id AS old_call, string_agg (task_comment.\"comment\", ';'), old_sales_task.updated_at FROM task JOIN sales_task_call ON sales_task_call.task_id = task. ID JOIN LEAD ON sales_task_call.lead_id = \"lead\".\"id\" JOIN sales_task_call AS old_sales_call ON old_sales_call.lead_id = LEAD . ID JOIN task AS old_sales_task ON old_sales_task. ID = old_sales_call.task_id JOIN task_comment ON task_comment.task_id = old_sales_call.task_id WHERE task. ID = "
				+ taskID
				+ " AND task. ID != old_sales_call.task_id GROUP BY old_sales_call.task_id, task. ID, old_sales_task.updated_at ORDER BY old_sales_call.task_id DESC";
		logger.info(sql);
		ArrayList<HashMap<String, String>> previousActionComments = new DBUtils().executeQuery(sql);
		return previousActionComments;
	}

	public ArrayList<HashMap<String, String>> followUpTaskDetails(String taskID) {
		String sql = "SELECT product. ID, product.\"name\", reportees.user_id AS reportee_id, user_profile.\"name\" AS reportee_name, lead.product_id as selected_product_id, selected_product.\"name\" as selected_product_name FROM product JOIN org_user ON product.organization_id = org_user.organizationid JOIN task ON task.actor = org_user.userid JOIN user_manager ON user_manager.user_id = task.actor JOIN user_manager AS reportees ON reportees.manager_id = user_manager.manager_id JOIN user_profile ON user_profile.user_id = reportees.user_id JOIN sales_task_call on sales_task_call.task_id = task.\"id\" JOIN lead on lead.\"id\" = sales_task_call.lead_id JOIN product as selected_product on selected_product.id = \"lead\".product_id WHERE task. ID = "
				+ taskID + " AND product.deleted = FALSE;";
		logger.info(sql);
		ArrayList<HashMap<String, String>> followUpTaskDetailsw = new DBUtils().executeQuery(sql);
		return followUpTaskDetailsw;
	}

	public JsonObject fetchTwilio() {
		JsonObject jsonResponseObject = new JsonObject();
		String acctSid = "ACc83a0e3dabf57bc697e79a4276fd6ae8";
		String authToken = "bd8c2df8a0c2f40c2f30f2928388e016";
		String applicationSid = "APb18a11b31b1549c09242d321defdd31f";
		String identity = System.currentTimeMillis() + "-" + System.nanoTime();
		TwilioCapability capability = new TwilioCapability(acctSid, authToken);
		capability.allowClientOutgoing(applicationSid);
		capability.allowClientIncoming(identity);
		String token = null;
		try {
			token = capability.generateToken();
		} catch (DomainException e) {
			e.printStackTrace();
		}
		jsonResponseObject.addProperty("identity", identity);
		jsonResponseObject.addProperty("token", token);
		// TODO Send task to inprogress
		return jsonResponseObject;
	}
}
