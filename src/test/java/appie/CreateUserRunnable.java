package appie;

import com.github.javafaker.Faker;

import ai.talentify.db.utils.DBUtils;

public class CreateUserRunnable implements Runnable {

	private String teamID;

	public CreateUserRunnable(String teamID) {
		super();
		this.teamID = teamID;
	}

	@Override
	public void run() {
		Faker faker = new Faker();
		String sql = "INSERT INTO sales_user (\"email\", \"mobile\", \"name\", \"picture\", \"created_at\", \"time_zone\", \"currency\", \"updated_at\") VALUES "
				+ " ('"+faker.internet().emailAddress()+"', '"+faker.phoneNumber().cellPhone()+"', '"+faker.gameOfThrones().character()+"', '"+faker.avatar().image()+"', 'now()', 'IST', 'INR', 'now()')  RETURNING \"id\";";
		
		
		int userID = new DBUtils().insertIntoDBWithGeneratedKey(sql);
		
		String sql2 = "INSERT INTO \"public\".\"user_role\" (\"role_id\", \"user_id\") VALUES ('2', '"+userID+"');";
		new DBUtils().insertIntoDB(sql2);

		String sql3 = "INSERT INTO \"public\".\"user_team\" (\"team_id\", \"user_id\") VALUES ('"+teamID+"', '"+userID+"');";
		
		new DBUtils().insertIntoDB(sql3);

	}

}
