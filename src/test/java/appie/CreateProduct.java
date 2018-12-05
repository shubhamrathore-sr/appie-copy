/**
 * 
 */
package appie;

import java.awt.Color;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Random;

import com.github.javafaker.Faker;

import ai.talentify.db.utils.DBUtils;

/**
 * @author istar
 *
 */
public class CreateProduct {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		//createProducts();
		//createProductAssets();
		createProductSignals();
	}

	private static void createProductSignals() {
		String sqlORG = "select * from product";
		
		DBUtils db =new DBUtils();
		ArrayList<HashMap<String, String>> table=db.executeQuery(sqlORG);
		for(HashMap<String, String> hashmap:table){
			for(int i=0;i<10;i++) {
				Faker f =new Faker();
				Random rand = new Random();

				float r = rand.nextFloat();
				float g = rand.nextFloat();
				float b = rand.nextFloat();
				Color randomColor = new Color(r, g, b);
				
				String sql="INSERT INTO \"public\".\"product_signal\" ( \"name\", \"signal_type\", \"signal_color\", \"value\", \"signal_engine\", \"created_at\", \"updated_at\", \"product_id\") VALUES"
						
						+ " ('"+f.ancient().hero()+f.ancient().hero()+f.ancient().hero()+f.ancient().hero()+f.ancient().hero()+"', 'KEYWORD', '"+generateColor(new Random())+"', '"+f.book().title().replaceAll("'", "''")+"', 'ParagraphMatchWithSynonyms', 'now()', 'now()','"+hashmap.get("id")+"');";
				new DBUtils().insertIntoDB(sql);

			}
		}
		
	}
	private static String generateColor(Random r) {
	    final char [] hex = { '0', '1', '2', '3', '4', '5', '6', '7',
	                          '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };
	    char [] s = new char[7];
	    int     n = r.nextInt(0x1000000);

	    s[0] = '#';
	    for (int i=1;i<7;i++) {
	        s[i] = hex[n & 0xf];
	        n >>= 4;
	    }
	    return new String(s);
	}
	private static void createProductAssets() {
		String sqlORG = "select * from product";
		DBUtils db = new DBUtils();
		ArrayList<HashMap<String, String>> table = db.executeQuery(sqlORG);
		for (HashMap<String, String> hashMap : table) {
			for (int i = 0; i < 10; i++) {
				Faker f = new Faker();
				String sql="INSERT INTO \"public\".\"product_asset\" ( \"asset_name\", \"asset_url\", \"asset_image\", \"product_id\", \"created_at\", \"updated_at\", \"asset_type\") VALUES ( '"+f.file().fileName()+"', '"+f.avatar().image()+"', '"+f.avatar().image()+"', '"+hashMap.get("id")+"', 'now()', 'now()', '"+f.file().extension()+"');";
				new DBUtils().insertIntoDB(sql);

			}
		}
		
	}

	private static void createProducts() {
		String sqlORG = "select * from organization;";

		DBUtils db = new DBUtils();
		ArrayList<HashMap<String, String>> table = db.executeQuery(sqlORG);
		for (HashMap<String, String> hashMap : table) {
			for (int i = 0; i < 10; i++) {
				Faker f = new Faker();
				String sql = "INSERT INTO \"public\".\"product\" (  \"name\", \"image\", \"description\", \"created_at\", \"updated_at\", \"organization_id\")"
						+ " VALUES ('" + f.commerce().productName() + "', '" + f.avatar().image() + "', '"
						+ f.gameOfThrones().dragon() + "', 'now()', 'now()', '"+hashMap.get("id")+"');";
				
				new DBUtils().insertIntoDB(sql);
			}
		}
	}

}
