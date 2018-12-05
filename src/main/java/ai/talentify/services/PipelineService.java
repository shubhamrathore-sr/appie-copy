/**
 * 
 */
package ai.talentify.services;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import ai.talentify.db.utils.DBProperties;
import ai.talentify.db.utils.DBUtils;
import ai.talentify.error.messages.PipelineMessages;

/**
 * @author istar
 *
 */
public class PipelineService {
	private static final Logger logger = LogManager.getLogger(PipelineService.class);
	public ArrayList<HashMap<String, String>> getPipelineForManager(String managerID) {
		String sql =  "SELECT pipeline. ID, pipeline.name, 	COALESCE(json_agg (stage_task_details) FILTER (WHERE stage_task_details.stage_id IS NOT NULL), '[]') as stageDetails FROM pipeline LEFT JOIN pipeline_stage ON pipeline_stage.pipeline_id = pipeline. ID LEFT JOIN ( SELECT pipeline_stage. ID AS stage_id, pipeline_stage.stage_name AS stage_name,COALESCE( json_agg ( json_build_object ( 'task_id', stage_task. ID, 'task_type', stage_task.task_type ) ) FILTER (WHERE stage_task. ID IS NOT NULL), '[]') AS stage_tasks FROM pipeline_stage LEFT JOIN stage_task ON stage_task.stage_id = pipeline_stage. ID WHERE pipeline_stage.deleted = FALSE and stage_task.deleted=FALSE GROUP BY pipeline_stage.id ORDER BY pipeline_stage.id ASC ) AS stage_task_details ON stage_task_details.stage_id = pipeline_stage.id WHERE pipeline.organization_id in(select organizationid from org_user where  userid="+managerID+") and pipeline.is_active=true AND pipeline_stage.deleted = FALSE GROUP BY pipeline. ID ORDER BY pipeline. ID ASC;";
		 return new DBUtils().executeQuery(sql);
	}
	
	//select * from pipeline where organization_id in(select organizationid from org_user where  userid="+managerID+") and is_active=true 
	
	public ArrayList<HashMap<String, String>> getStages(String pieplineID) {
		String sql =  "select * from pipeline_stage where deleted=false AND pipeline_id="+ pieplineID;
		logger.error(sql);
		return new DBUtils().executeQuery(sql);
	}
	
	public ArrayList<HashMap<String, String>> getStageTasks(String stageID) {
		String sql =  "select * from stage_task WHERE deleted=false AND stage_id="+ stageID;
		System.err.println(sql);
		return new DBUtils().executeQuery(sql);
	}
	
	public ArrayList<HashMap<String, String>> getPipelineDetails(String pipelineId){
		String sql="select * from pipeline where id="+pipelineId+";";
		return new DBUtils().executeQuery(sql);
	}
	public String createPipeline(String pipelineName,String managerId) {
		String sql="INSERT INTO pipeline ( created_at, updated_at, name, organization_id, is_active) VALUES ( now(), now(), '"+pipelineName+"' , (select organizationid from org_user where  userid="+managerId+"), 't')  RETURNING id;";
		int newPipelineId=new DBUtils().insertIntoDBWithGeneratedKey(sql);
		return newPipelineId+"";
	}
	public String updatepipelinename(String pipelineId,String pipelineName) {
		String sql="UPDATE pipeline SET name='"+pipelineName+"' WHERE id='"+pipelineId+"';";
		System.err.println(sql);
		new DBUtils().insertIntoDB(sql);
		return PipelineMessages.PIPELINENAME_CHANGED_SUCCESSFULLY;
	}
	public String deletePipeline(String pipelineId) {
		String sql="update pipeline set is_active=false where id="+pipelineId+";";
		System.err.println(sql);
		new DBUtils().executeQuery(sql);
		return PipelineMessages.PIPELINE_DELETED_SUCCESSFULLY;
	}
	public String addStage(String pipelineId) {
		String sql="INSERT INTO pipeline_stage ( pipeline_id,stage_name, created_at, updated_at) VALUES ( '"+pipelineId+"', CONCAT('Stage ', (SELECT \"count\"(*) from pipeline_stage where pipeline_id='"+pipelineId+"')) , 'now()', 'now()');"; 
		System.err.println(sql);
		new DBUtils().insertIntoDB(sql);
		return PipelineMessages.STAGE_ADDED_SUCCESSFULLY;
	}
	public String removeStage(String stageId) {
		String sql="UPDATE pipeline_stage SET deleted='true' WHERE id='"+stageId+"';";
		System.err.println(sql);
		new DBUtils().executeQuery(sql);
		return PipelineMessages.STAGE_DELETED_SUCCESSFULLY;

	}
	public String updateStageName(String stageId,String stageName) {
		String sql="UPDATE pipeline_stage SET stage_name='"+stageName+"' WHERE id='"+stageId+"';";
		System.err.println(sql);
		new DBUtils().insertIntoDB(sql);
		return PipelineMessages.STAGENAME_CHANGED_SUCCESSFULLY;
	}
	public String changeTaskType(String taskId,String taskType) {
		String sql="UPDATE stage_task SET task_type='"+taskType+"' WHERE id='"+taskId+"';";
		System.err.println(sql);
		new DBUtils().executeQuery(sql);
		return PipelineMessages.TASKTYPE_CHANGED_SUCCESSFULLY;
	}
	public String addTask(String stageId,String taskType) {
		String sql="INSERT INTO stage_task (task_type, created_at, updated_at, stage_id) VALUES ('"+taskType+"', 'now()', 'now()', '"+stageId+"');";
		System.err.println(sql);
		new DBUtils().insertIntoDB(sql);
		return PipelineMessages.TASK_ADDED_SUCCESSFULLY;
	}
	public String removeTask(String taskId) {
		String sql="UPDATE stage_task SET deleted='true' WHERE id='"+taskId+"';";
		System.err.println(sql);
		new DBUtils().executeQuery(sql);
		return PipelineMessages.TASK_DELETED_SUCCESSFULLY;
	}
	public String updateTaskDescription(String taskId,String description) {
		String sql="UPDATE stage_task SET description='"+description+"' WHERE id='"+taskId+"';";
		System.err.println(sql);
		new DBUtils().insertIntoDB(sql);
		return PipelineMessages.TASKDESCRIPTION_CHANGED_SUCCESSFULLY;
	}
}
