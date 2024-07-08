package com.yhs.portfolio.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import com.yhs.portfolio.connection.DbConnection;
import com.yhs.portfolio.dao.OrderDao;
import com.yhs.portfolio.model.Cart;
import com.yhs.portfolio.model.Order;
import com.yhs.portfolio.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/order-now")
public class OrderNowServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try (PrintWriter out = response.getWriter()) {
			LocalDateTime currentDate = LocalDateTime.now();

			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			String formattedDate = currentDate.format(formatter);

			User auth = (User) request.getSession().getAttribute("auth");

			if (auth != null) {
				String productId = request.getParameter("id");
				int productQuantity = Integer.parseInt(request.getParameter("quantity"));

				if (productQuantity <= 0) {
					productQuantity = 1;
				}

				Order orderModel = new Order();

//				부모 클래스인 Product의 setId 맞나 orderId로 넣어야하는거 같은데 실수하신 거 같은데 근데 확실하지 않으니..
				orderModel.setId(Integer.parseInt(productId));
				orderModel.setuId(auth.getId());
				orderModel.setQuantity(productQuantity);
				orderModel.setDate(formattedDate);

				OrderDao orderDao = new OrderDao(DbConnection.getConnection());
				boolean result = orderDao.insertOrder(orderModel);

				if (result) {

					List<Cart> cart_list = (ArrayList<Cart>) request.getSession().getAttribute("cart-list");

					if (cart_list != null) {
						for (Cart c : cart_list) {
							if (c.getId() == Integer.parseInt(productId)) {
								cart_list.remove(cart_list.indexOf(c));
								break;
							}
						}
					}

					response.sendRedirect("orders.jsp");
				} else {
					out.print("order failed ");
				}

			} else {
				response.sendRedirect("login.jsp");
			}
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
