/**
 * 
 */
package appie;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Random;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import com.github.javafaker.Faker;

import ai.talentify.db.utils.DBUtils;

/**
 * @author istar
 *
 */
public class CreateSalesContactPerson implements Runnable {

	
	String leadID;
	
	
	/* (non-Javadoc)
	 * @see java.lang.Runnable#run()
	 */
	public CreateSalesContactPerson(String leadID) {
		super();
		this.leadID = leadID;
	}

	@Override
	public void run() {
		for (int i = 0; i < new Random().nextInt(5); i++) {
			// TODO Auto-generated method stub
			Faker faker = new Faker();
			String sql = "INSERT INTO \"public\".\"sales_contact_person\" ( \"person_name\", \"email\", \"mobile\", \"lead_id\") VALUES ( '"
					+ faker.gameOfThrones().dragon() + "', '" + faker.internet().emailAddress() + "', '"
					+ faker.phoneNumber().cellPhone() + "', '" + leadID + "');";
			new DBUtils().insertIntoDB(sql);
		}
		
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		ExecutorService executor = Executors.newFixedThreadPool(100);
		String sql ="select id from \"lead\"";
	
		 ArrayList<HashMap<String, String>> data = new DBUtils().executeQuery(sql);
		 for (HashMap<String, String> hashMap : data) {
			executor.execute(new CreateSalesContactPerson(hashMap.get("id")));
		}
		
	}
	


}
