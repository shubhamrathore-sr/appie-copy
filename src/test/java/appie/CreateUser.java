/**
 * 
 */
package appie;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import ai.talentify.db.utils.DBUtils;

/**
 * @author Vaibhav Verma
 *
 */
public class CreateUser {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		
		
	ArrayList<HashMap<String, String>> table = new DBUtils().executeQuery("select *  from team");
	ExecutorService executor = Executors.newFixedThreadPool(100);
		for (HashMap<String, String> hashMap : table) {
			String teamID = hashMap.get("id".toString());
			for (int i = 0; i < 100; i++) {
				createUser(teamID);
				executor.execute(new CreateUserRunnable(teamID));
				
			}
		}

	}

	private static void createUser(String teamID) {
		
	}

}
