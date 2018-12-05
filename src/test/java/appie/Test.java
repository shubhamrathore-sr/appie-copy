/**
 * 
 */
package appie;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.http.impl.io.SocketOutputBuffer;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import ai.talentify.db.utils.DBUtils;
import ai.talentify.services.PipelineService;

/**
 * @author Istar
 *
 */
public class Test {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		/*ArrayList<HashMap<String, String>> pipelineForManager = getPipelineForManager(3);
		for (HashMap<String, String> pipeline : pipelineForManager) {
			Gson gson = new Gson();
			String userJson = gson.toJson(pipeline);
			logger.info(userJson);
			
		}*/
		
		//PipelineService service=new PipelineService();
		//ArrayList<HashMap<String, String>> pipelines=service.getPipelineForManager(3);
		//for (HashMap<String, String> pipeline : pipelines) {
		//	logger.info(pipeline.get("id"));
		//}
	}

	//public static ArrayList<HashMap<String, String>> getPipelineForManager(int managerID) {
	//	String sql = "SELECT pipeline.ID as pipeline_id,pipeline. NAME,pipeline_stage.id as stage_id,pipeline_stage.stage_name,stage_task.id as task_id,stage_task.task_type FROM pipeline,pipeline_stage,stage_task where pipeline.id=pipeline_stage.pipeline_id and pipeline.organization_id =3 and pipeline_stage.id=stage_task.stage_id;";
	//	return new DBUtils().executeQuery(sql);
	//}
	
	//public static  ArrayList<HashMap<String,String>> getPipelines(int managerId){
	//	String sql="select * from pipeline where organization_id=3;";
	//	return new DBUtils().executeQuery(sql);
	//}

}
