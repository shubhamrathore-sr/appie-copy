package ai.talentify.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ai.talentify.services.ProductService;
import ai.talentify.servlet.AuthenticationServlet.AuthenticationServletMethods;

/**
 * Servlet implementation class Product
 */
@WebServlet(urlPatterns = "/product")
public class ProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ProductServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		AuthenticationServletMethods authenticationServletMethods = AuthenticationServletMethods
				.valueOf(request.getParameter("method"));
		switch (authenticationServletMethods) {
		case DELETE:
			String productID = request.getParameter("productID");
			ProductService service = new ProductService();
			service.deleteProduct(productID);

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

	public enum AuthenticationServletMethods {
		DELETE
	}

}
