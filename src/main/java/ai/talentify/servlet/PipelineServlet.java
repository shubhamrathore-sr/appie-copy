package ai.talentify.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import ai.talentify.services.PipelineService;

/**
 * Servlet implementation class PipelineServlet
 */
@WebServlet(urlPatterns = "/pipeline")
public class PipelineServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PipelineServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String method = request.getParameter("method");
		switch (method) {
		case "CREATE_PIPELINE":
			response.setContentType("application/json");
			PrintWriter out10 = response.getWriter();
			String managerid = request.getParameter("managerId");
			String pipelineName1 = request.getParameter("pipelineName");
			out10.append(new Gson().toJson(new PipelineService().createPipeline(pipelineName1, managerid)));
			out10.flush();
			out10.close();
			break;
		case "DELETE_PIPELINE":

			response.setContentType("application/json");
			PrintWriter out = response.getWriter();
			String pipelineId = request.getParameter("pipelineId");
			out.append(new Gson().toJson(new PipelineService().deletePipeline(pipelineId)));
			out.flush();
			out.close();
			break;
		case "ADD_STAGE":
			response.setContentType("application/json");
			PrintWriter out2 = response.getWriter();
			String pipeline_Id = request.getParameter("pipelineId");
			out2.append(new Gson().toJson(new PipelineService().addStage(pipeline_Id)));
			out2.flush();
			out2.close();
			break;
		case "DELETE_STAGE":
			response.setContentType("application/json");
			PrintWriter out5 = response.getWriter();
			String stage_Id = request.getParameter("stageId");
			out5.append(new Gson().toJson(new PipelineService().removeStage(stage_Id)));
			out5.flush();
			out5.close();
			break;

		case "CHANGE_STAGE_NAME":
			response.setContentType("application/json");
			PrintWriter out7 = response.getWriter();
			String stage_Id2 = request.getParameter("stageId");
			String stage_name = request.getParameter("stageName");
			out7.append(new Gson().toJson(new PipelineService().updateStageName(stage_Id2, stage_name)));
			out7.flush();
			out7.close();
			break;
		case "CHANGE_PIPELINE_NAME":
			response.setContentType("application/json");
			PrintWriter out8 = response.getWriter();
			String pipeline_Id2 = request.getParameter("pipelineId");
			String pipelineName = request.getParameter("pipelineName");
			out8.append(new Gson().toJson(new PipelineService().updatepipelinename(pipeline_Id2, pipelineName)));
			out8.flush();
			out8.close();
			break;

		case "CHANGE_CARD_DESCRIPTION":
			response.setContentType("application/json");
			PrintWriter out9 = response.getWriter();
			String taskId1 = request.getParameter("taskId");
			String description = request.getParameter("description");
			out9.append(new Gson().toJson(new PipelineService().updateTaskDescription(taskId1, description)));
			out9.flush();
			out9.close();
			break;

		case "CHANGE_TASKTYPE":
			response.setContentType("application/json");
			PrintWriter out3 = response.getWriter();
			String taskId = request.getParameter("taskId");
			String taskType = request.getParameter("taskType");
			out3.append(new Gson().toJson(new PipelineService().changeTaskType(taskId, taskType)));
			out3.flush();
			out3.close();
			break;
		case "ADD_TASK":
			response.setContentType("application/json");
			PrintWriter out4 = response.getWriter();
			String stageId = request.getParameter("stageId");
			String task_Type = request.getParameter("taskType");
			out4.append(new Gson().toJson(new PipelineService().addTask(stageId, task_Type)));
			out4.flush();
			out4.close();
			break;
		case "DELETE_TASK":
			response.setContentType("application/json");
			PrintWriter out6 = response.getWriter();
			String task_Id = request.getParameter("taskId");
			out6.append(new Gson().toJson(new PipelineService().removeTask(task_Id)));
			out6.flush();
			out6.close();
			break;
		case "GET_ALL_PIPELINES":
			response.setContentType("application/json");
			PrintWriter out11 = response.getWriter();
			String manager1_id = request.getParameter("managerId");
			out11.append(new Gson().toJson(new PipelineService().getPipelineForManager(manager1_id)));
			out11.flush();
			out11.close();
			break;
		default:
			break;
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
