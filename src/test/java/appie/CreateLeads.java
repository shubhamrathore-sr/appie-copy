/**
 * 
 */
package appie;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import com.github.javafaker.Faker;

import ai.talentify.constants.LeadSourceTypes;
import ai.talentify.constants.LeadStatusTypes;
import ai.talentify.constants.SalesUserRoles;
import ai.talentify.db.utils.DBUtils;

/**
 * @author Vaibhav Verma
 *
 */
public class CreateLeads implements Runnable {
	String userID;
	public CreateLeads(String userID2) {
		userID = userID2;
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {// TODO Auto-generated method stub
		ExecutorService executor = Executors.newFixedThreadPool(100);

		String sql = "select sales_user.id from sales_user, \"role\", user_role where sales_user.id=user_role.user_id and user_role.role_id=role.id and \"role\".\"name\"='"+SalesUserRoles.SALES_ASSOCIATE.name()+"';";
		System.err.println(sql);

		ArrayList<HashMap<String, String>> users = new DBUtils().executeQuery(sql);
		for (HashMap<String, String>user:  users) {
			String userID = user.get("id");
			for (int i = 0; i < 100; i++) {
				executor.execute(new CreateLeads(userID));
				break;
			}
		}
	
	}

	@Override
	public void run() {
		Faker faker = new Faker();

		
		String sql = "INSERT INTO \"public\".\"lead\" (\"owner\", \"actor\", \"lead_source\","
				+ ""
				+ " \"company_name\", \"address\", \"status\", \"created_at\", \"updated_at\") VALUES ('1987752', '"+userID+"',  '"+LeadSourceTypes.ONLINE.name()+"', "
				+ ""
				+ "'"+faker.artist().name()+"', '"+faker.address().fullAddress()+"', '"+LeadStatusTypes.NOT_ASSIGNED.name()+"', 'now()', 'now()');";
		System.err.println(sql);
		new DBUtils().insertIntoDB(sql);
		
	
	}
	

	
	

}
