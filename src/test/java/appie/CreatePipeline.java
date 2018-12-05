package appie;

import java.util.ArrayList;
import java.util.HashMap;

import com.github.javafaker.Faker;

import ai.talentify.db.utils.DBUtils;

public class CreatePipeline {
	public static void main(String[] args) {
		createPipilines();
	}

	private static void createPipilines() {
		String sql = "select * from organization";
		
		ArrayList<HashMap<String, String>> data  = new DBUtils().executeQuery(sql);
		
		for (HashMap<String, String> hashMap : data) {
			for (int i = 0; i < 10; i++) {
				createPipeline(hashMap.get("id"));
				
			}
		}
	}

	private static void createPipeline(String orgnizationID) {
		Faker faker = new Faker();
		String sql = "INSERT INTO \"public\".\"pipeline\" ( \"pipeline_name\", \"description\", \"created_at\", \"updated_at\", \"organization_id\") VALUES ( '"+faker.ancient().god()+"', '1', 'now()', 'now()', '"+orgnizationID+"');";
		new DBUtils().insertIntoDB(sql);
		
	}
}
