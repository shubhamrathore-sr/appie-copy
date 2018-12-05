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

import ai.talentify.services.LeadService;
import ai.talentify.services.associate.Lead;

/**
 * Servlet implementation class LeadServlet
 */
@WebServlet(urlPatterns = "/leads")
public class LeadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LeadServlet() {
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

		case "GET_LEAD_DETAILS":
			String leadID = request.getParameter("leadID");
			// response.setContentType("application/json");
			PrintWriter out4 = response.getWriter();
			// out4.append(new LeadService().getLeadDetails(leadID));
			out4.append(new Lead().getLeadDetailsAssociate(leadID));
			out4.flush();
			out4.close();
			break;

		case "GET_LEADS":
			String managerID = request.getParameter("managerID");
			String offset = request.getParameter("offset");
			String limit = request.getParameter("limit");
			response.setContentType("application/json");
			PrintWriter out = response.getWriter();
			// ArrayList<HashMap<String, String>> data = new
			// LeadService().getInitialLeads(Integer.parseInt(managerID),limit,offset);
			ArrayList<HashMap<String, String>> data = new Lead().getLeadsAssociate(Integer.parseInt(managerID), limit,
					offset);
			out.append(new Gson().toJson(data));
			out.flush();
			out.close();
			break;

		case "GET_SALES_CONTACT_PERSON":
			String lead_id = request.getParameter("lead_id");
			response.setContentType("application/json");
			PrintWriter out2 = response.getWriter();
			ArrayList<HashMap<String, String>> data2 = new LeadService()
					.getSalesContactPersons(Integer.parseInt(lead_id));
			out2.append(new Gson().toJson(data2));
			out2.flush();
			out2.close();
			break;

		case "GET_LEADS_ASSOC":
			String associateID = request.getParameter("associateID");
			String assOffset = request.getParameter("offset");
			String assLimit = request.getParameter("limit");
			response.setContentType("application/json");
			PrintWriter out3 = response.getWriter();
			ArrayList<HashMap<String, String>> data3 = new LeadService()
					.getInitialLeadsAssociate(Integer.parseInt(associateID), assLimit, assOffset);
			out3.append(new Gson().toJson(data3));
			out3.flush();
			out3.close();
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
