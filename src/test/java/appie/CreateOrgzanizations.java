/**
 * 
 */
package appie;

import java.util.ArrayList;
import java.util.HashMap;

import com.github.javafaker.Faker;

import ai.talentify.db.utils.DBUtils;

/**
 * @author Vaibhav Verma
 *
 */
public class CreateOrgzanizations {

	/**
	 * @param args
	 */
	public static void main(String[] args) {

		ArrayList<HashMap<String, String>> table = new DBUtils().executeQuery("select *   from organization");

		for (HashMap<String, String> hashMap : table) {
			String org_id = hashMap.get("id".toString());
			for (int i = 0; i < 100; i++) {
				Faker faker = new Faker();
				String sql = "INSERT INTO team (\"name\", \"description\", \"created_at\", \"updated_at\", \"organization_id\") VALUES ('"
						+ faker.superhero().name() + "', '" + faker.chuckNorris().fact().replace("'", "''")
						+ "', 'now()', 'now()', '" + org_id + "')";
				new DBUtils().insertIntoDB(sql);
			}
		}

	}

}
