package com.yhs.portfolio.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import com.yhs.portfolio.model.Cart;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/quantity-inc-dec")
public class QuantityIncDecServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()) {
			String action = request.getParameter("action");
			int id = Integer.parseInt(request.getParameter("id"));

			List<Cart> cart_list = (ArrayList<Cart>) request.getSession().getAttribute("cart-list");

			if (action != null && id >= 1) {
				if (action.equals("inc")) {
					for (Cart cartItem : cart_list) {
						if (cartItem.getId() == id) {
							int quantity = cartItem.getQuantity();
							quantity++;
							cartItem.setQuantity(quantity);
							break;
						}
					}
					response.sendRedirect("cart.jsp");
				}

				if (action.equals("dec")) {
					for (Cart cartItem : cart_list) {
						if (cartItem.getId() == id && cartItem.getQuantity() > 1) {
							int quantity = cartItem.getQuantity();
							quantity--;
							cartItem.setQuantity(quantity);
							break;
						}
					}

					response.sendRedirect("cart.jsp");
				}
			}

		}
	}

}
