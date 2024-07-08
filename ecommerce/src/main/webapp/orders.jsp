
<%@page import="com.yhs.portfolio.connection.DbConnection"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.yhs.portfolio.model.Cart"%>

<%@page import="com.yhs.portfolio.model.User"%>

<%@page import="com.yhs.portfolio.model.Order"%>

<%@page import="com.yhs.portfolio.dao.OrderDao"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
DecimalFormat dcf = new DecimalFormat("#,###");
request.setAttribute("dcf", dcf);
User auth = (User) request.getSession().getAttribute("auth");

List<Order> orders = null;
if (auth != null) {
	request.setAttribute("auth", auth);
	orders = new OrderDao(DbConnection.getConnection()).userOrders(auth.getId());
} else {
	response.sendRedirect("login.jsp");
}

List<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
if (cart_list != null) {
	request.setAttribute("cart_list", cart_list);
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>주문 목록 페이지</title>

<%@ include file="/includes/header.jsp"%>
</head>
<body>

	<%@include file="/includes/navbar.jsp"%>
	<div class="container">
		<div class="card-header my-3">주문 목록</div>
		<table class="table table-light">
			<thead>
				<tr>
					<th scope="col">날짜</th>
					<th scope="col">상품명</th>
					<th scope="col">카테고리</th>
					<th scope="col">수량</th>
					<th scope="col">가격</th>
					<th scope="col">취소</th>
				</tr>
			</thead>
			<tbody>

				<%
				if (orders != null) {
					for (Order o : orders) {
				%>

				<tr>

					<td><%=o.getDate()%></td>
					<td><%=o.getName()%></td>
					<td><%=o.getCategory()%></td>
					<td><%=o.getQuantity()%></td>
					<td><%=dcf.format(o.getPrice()) + "원"%></td>
					<td><a class="btn btn-sm btn-danger"
						href="cancel-order?id=<%=o.getOrderId()%>">취소</a>
				</tr>

				</tr>
				<%
				}
				}
				%>


			</tbody>
		</table>
	</div>
	<%@include file="/includes/footer.jsp"%>
</body>
</html>