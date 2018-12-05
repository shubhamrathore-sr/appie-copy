/**
 * 
 */
package ai.talentify.services;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import ai.talentify.db.utils.DBUtils;

/**
 * @author istar
 *
 */
public class ProductService {
	private static final Logger logger = LogManager.getLogger(ProductService.class);

	public ArrayList<HashMap<String, String>> getProducts(int managerID) {
		String sql = "select * from product where organization_id in(select org_user.organizationid from org_user where org_user.userid="
				+ managerID + ") and  deleted=FALSE";
		return new DBUtils().executeQuery(sql);
	}

	public ArrayList<HashMap<String, String>> getProductDocuments(int productID) {
		String sql = "select * from product_asset where product_id=" + productID + "  and is_active='t'";
		logger.info(sql);
		return new DBUtils().executeQuery(sql);
	}

	public ArrayList<HashMap<String, String>> getProductSignals(int productID) {
		String sql = "select id, product_signal.color as signal_color, product_signal.name , product_signal.\"value\" as value  from product_signal where product_id="
				+ productID;
		logger.info(sql);
		return new DBUtils().executeQuery(sql);
	}

	public int deleteProduct(String productID) {
		String sql = "update product set deleted='t' where id=" + productID;
		return new DBUtils().insertIntoDB(sql);

	}

	public HashMap<String, String> getProduct(String productID) {
		String sql = "select * from product where id=" + productID;
		return new DBUtils().executeQuery(sql).get(0);
	}

}
