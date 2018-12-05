package ai.talentify.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.google.gson.Gson;

import ai.talentify.constants.SalesUserRoles;
import ai.talentify.error.messages.AuthenticationMessages;
import ai.talentify.exceptions.ServiceReponse;
import ai.talentify.services.AuthenticationService;
import ai.talentify.services.UserProfileService;

/**
 * Servlet implementation class AuthenticationServlet
 */
@WebServlet("/auth")
public class AuthenticationServlet extends HttpServlet {
	private static final Logger logger = LogManager.getLogger(AuthenticationServlet.class);

	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AuthenticationServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		if (!request.getParameterMap().containsKey("method")) {
			logout(request, response);

			return;
		}
		AuthenticationServletMethods authenticationServletMethods = AuthenticationServletMethods
				.valueOf(request.getParameter("method"));
		switch (authenticationServletMethods) {
		case AUTH:
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			AuthenticationService service = new AuthenticationService();
			ServiceReponse serviceResponse = service.authenticate(email, password);
			logger.info(serviceResponse.getResponseMessage());
			if (!serviceResponse.getResponseMessage().equalsIgnoreCase(AuthenticationMessages.AUTH_SUCCESSFULL)) {
				RequestDispatcher superAdminDispacther = request.getRequestDispatcher("/index.jsp");
				request.setAttribute("MSG", serviceResponse.getResponseMessage());
				superAdminDispacther.forward(request, response);
				return;
			} else {
				SalesUserRoles roles = SalesUserRoles.valueOf(serviceResponse.getData().get("role").toString());

				switch (roles) {
				case IT_ADMIN:
					break;
				case SALES_ASSOCIATE:
					request.getSession().setAttribute("isLoggedIN", true);
					request.getSession().setAttribute("user", (new AuthenticationService()
							.getUserData(serviceResponse.getData().get("userid").toString())).get(0));
					RequestDispatcher dis = request.getRequestDispatcher("/SALES_ASSOCIATE/dashboard.jsp");
					dis.forward(request, response);
					break;

				case SALES_MANAGER:
					request.getSession().setAttribute("isLoggedIN", true);
					request.getSession().setAttribute("user", (new AuthenticationService()
							.getUserData(serviceResponse.getData().get("userid").toString())).get(0));
					RequestDispatcher managerDispacther = request.getRequestDispatcher("/SALES_MANAGER/dashboard.jsp");
					managerDispacther.forward(request, response);
					break;
				case OWNER:
					break;
				case SUPER_ADMIN:

					break;
				default:
					break;
				}
			}
			break;
		case UPDATE_PROFILE:

			response.setContentType("application/json");
			PrintWriter out1 = response.getWriter();
			String managerid = request.getParameter("manager_id");
			String name = request.getParameter("name");
			String timezone = request.getParameter("timezone");
			String location = request.getParameter("location");
			String language = request.getParameter("language");
			String currency = request.getParameter("currency");
			String picture = request.getParameter("picture");
			out1.append(new Gson().toJson(new UserProfileService().updateProfile(managerid, name, timezone, location,
					language, currency, picture)));
			out1.flush();
			out1.close();
			// write update login here
			break;
		case LOGOUT:
			logout(request, response);
			return;
		default:
			break;
		}

	}

	private void logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getSession().removeAttribute("isLoggedIN");
		request.getSession().removeAttribute("user");
		request.getSession().setAttribute("MESSAGE", "You have been logged out successfully!");
		RequestDispatcher dis = request.getRequestDispatcher("/index.jsp");
		dis.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	public enum AuthenticationServletMethods {
		AUTH, UPDATE_PROFILE, LOGOUT
	}

}
