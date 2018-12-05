/**
 * 
 */
package appie;

import java.util.ArrayList;
import java.util.HashMap;

import ai.talentify.db.utils.DBUtils;

/**
 * @author istar
 *
 */
public class CreateStages {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		String sql = "select * from pipeline";
		 ArrayList<HashMap<String, String>> data = new DBUtils().executeQuery(sql);
		 for (HashMap<String, String> hashMap : data) {
			for (int i = 0; i < 10; i++) {
			craeteStage(i, hashMap.get("id"));
				
			}
		}
	}

	private static void craeteStage(int i, String piplineID) {
		String array[] =  {"Cold Call", "Demo", "POC", "Meeting", "Follow-up", "Cold Call", "Demo", "POC", "Meeting", "Follow-up", "Cold Call", "Demo", "POC", "Meeting", "Follow-up"};
		String sql = "INSERT INTO \"public\".\"pipeline_stage\" ( \"stage_name\", \"created_at\", \"updated_at\", \"pipeline_id\") VALUES ( '"+array[i]+"', 'now()', 'now()', '"+piplineID+"');";
		new DBUtils().insertIntoDB(sql);

		
	}

}
