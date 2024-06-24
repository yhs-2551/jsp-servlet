package com.yhs.portfolio.servlet;

import java.io.IOException;
import java.io.PrintWriter;
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

/**
 * Servlet implementation class CartCheckOutServlet
 */

@WebServlet("/cart-check-out")
public class CartCheckOutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try (PrintWriter out = response.getWriter()) {
			LocalDateTime currentDate = LocalDateTime.now();

			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			String formattedDate = currentDate.format(formatter);
			List<Cart> cart_list = (ArrayList<Cart>) request.getSession().getAttribute("cart-list");
			User auth = (User) request.getSession().getAttribute("auth");

			if (cart_list != null && auth != null) {

				for (Cart c : cart_list) {
					Order order = new Order();
					order.setId(c.getId());
					order.setuId(auth.getId());
					order.setQuantity(c.getQuantity());
					order.setDate(formattedDate);

					OrderDao oDao = new OrderDao(DbConnection.getConnection());
					boolean result = oDao.insertOrder(order);

					if (!result) {
						break;
					}
				}

				cart_list.clear();
				response.sendRedirect("orders.jsp");

			} else {
				if (auth == null) {
					response.sendRedirect("login.jsp");
				}

				if (cart_list == null) {
					response.sendRedirect("cart.jsp");
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
