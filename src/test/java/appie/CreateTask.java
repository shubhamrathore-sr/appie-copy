/**
 * 
 */
package appie;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Random;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import ai.talentify.db.utils.DBUtils;

/**
 * @author Vaibhav Verma
 *
 */
public class CreateTask implements Runnable {
	private static final Logger logger = LogManager.getLogger(CreateTask.class);

	public static void main(String[] args) {
		String sql = "select * from lead where id in ( select lead.id   from  lead, sales_contact_person where sales_contact_person.lead_id = \"lead\".id  and \"lead\".\"owner\"=1596697 GROUP BY lead.id, \"lead\".company_name )";
		ArrayList<HashMap<String, String>> table = new DBUtils().executeQuery(sql);
		for (HashMap<String, String> hashMap : table) {

			try {
				ArrayList<HashMap<String, String>> peoples = new DBUtils()
						.executeQuery("select * from sales_contact_person where lead_id=" + hashMap.get("id"));

				String leadOwner = hashMap.get("owner");
				String actor = hashMap.get("actor");
				String sql2 = "INSERT INTO \"public\".\"task\" ( \"name\", \"description\", \"owner\", \"actor\", \"status\", \"start_date\", \"end_date\", \"task_type\", \"lead_id\", \"call_duration\", \"score\", "
						+ "\"latitude\", \"longitude\", \"analytics\", \"call_rating\", \"sales_contact_id\", \"pipeline_id\", \"stage_id\", \"voice_quality\", \"talk_ratio\", \"sentiment\", \"task_type_id\", "
						+ "\"special_score\") VALUES ('Sales Call', 'Sales Call', '" + leadOwner + "', '" + actor
						+ "', 'INCOMPLETE', 'now()', 'now()', 'SALES_CALL', '" + hashMap.get("id")
						+ "', NULL, NULL, NULL, NULL," + " NULL, NULL, '"
						+ peoples.get(new Random().nextInt(peoples.size())).get("id")
						+ "', NULL, NULL, NULL, NULL, NULL, NULL, NULL);";
				logger.info(sql2);
				new DBUtils().insertIntoDB(sql2);
			} catch (Exception e) {

			}
		}

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Runnable#run()
	 */
	@Override
	public void run() {
		// TODO Auto-generated method stub

	}

}
