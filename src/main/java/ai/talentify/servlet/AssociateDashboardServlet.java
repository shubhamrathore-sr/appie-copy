package ai.talentify.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import ai.talentify.services.associate.Dashboard;

/**
 * Servlet implementation class AssociateDashboard
 */
@WebServlet(urlPatterns = "/assoc")
public class AssociateDashboardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AssociateDashboardServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		AssociateDashboardServletMethods authenticationServletMethods = AssociateDashboardServletMethods
				.valueOf(request.getParameter("method"));
		PrintWriter out = response.getWriter();
		String taskID = request.getParameter("task_id");
		switch (authenticationServletMethods) {
		case GET_TASK_HISTORY:
			response.setContentType("application/json");
			out.append(new Gson().toJson(new Dashboard().taskHistoryandComments(taskID)));
			out.flush();
			out.close();
			break;
		case GET_FOLLOW_UP_TASK_DETAILS:
			response.setContentType("application/json");
			ArrayList<HashMap<String, String>> followUpTaskDetails = new Dashboard().followUpTaskDetails(taskID);
			massageFollowUpTaskDetails(followUpTaskDetails, out);
			out.flush();
			out.close();
			break;
		case TWILIO_TOKEN:
			response.setContentType("application/json");
			out.append(new Gson().toJson(new Dashboard().fetchTwilio()));
			out.flush();
			out.close();
			break;
		default:
			break;
		}
	}

	private void massageFollowUpTaskDetails(ArrayList<HashMap<String, String>> followUpTaskDetails, PrintWriter out) {
		JsonObject resp = new JsonObject();
		JsonArray productArray = new JsonArray();
		JsonArray reportees = new JsonArray();
		HashMap<String, String> products = new HashMap<>();
		HashMap<String, String> teamMembers = new HashMap<>();
		if (followUpTaskDetails.size() > 0) {
			for (HashMap<String, String> followUpTaskDetail : followUpTaskDetails) {
				products.put(followUpTaskDetail.get("id"), followUpTaskDetail.get("name"));
				teamMembers.put(followUpTaskDetail.get("reportee_id"), followUpTaskDetail.get("reportee_name"));
			}
			String selectedProduct = followUpTaskDetails.get(0).get("selected_product_id");
			for (String product : products.keySet()) {
				JsonObject productObject = new JsonObject();
				productObject.addProperty("id", product);
				productObject.addProperty("name", products.get(product));
				if (selectedProduct.equalsIgnoreCase(product))
					productObject.addProperty("selected", true);
				else
					productObject.addProperty("selected", false);
				productArray.add(productObject);
			}
			for (String teamMember : teamMembers.keySet()) {
				JsonObject reporteeObject = new JsonObject();
				reporteeObject.addProperty("id", teamMember);
				reporteeObject.addProperty("name", teamMembers.get(teamMember));
				reportees.add(reporteeObject);
			}
		} else {
			// TODO
		}
		resp.add("products", productArray);
		resp.add("reportees", reportees);
		out.append(new Gson().toJson(resp));
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

	public enum AssociateDashboardServletMethods {
		GET_TASK_HISTORY, GET_FOLLOW_UP_TASK_DETAILS, TWILIO_TOKEN
	}
}
