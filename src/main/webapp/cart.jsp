
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.yhs.portfolio.dao.ProductDao"%>
<%@page import="com.yhs.portfolio.connection.DbConnection"%>
<%@page import="com.yhs.portfolio.model.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.yhs.portfolio.model.User"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%
DecimalFormat dcf = new DecimalFormat("#,###");
request.setAttribute("dcf", dcf);
User auth = (User) request.getSession().getAttribute("auth");
if (auth != null) {
	request.setAttribute("auth", auth);
}

List<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
List<Cart> cartProduct = null;
if (cart_list != null) {
	ProductDao pDao = new ProductDao(DbConnection.getConnection());
	cartProduct = pDao.getCartProducts(cart_list);
	double total = pDao.getTotalCartPrice(cart_list);
	request.setAttribute("cart_list", cart_list);
	request.setAttribute("total", total);
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cart Page</title>
<%@ include file="/includes/header.jsp"%>

<style type="text/css">
.table tbody td {
	vertical-align: middle;
}

.btn-incre, .btn-decre {
	box-shadow: none;
	font-size: 25px;
}
</style>

</head>
<body>
	<%@ include file="/includes/navbar.jsp"%>

	<div class="container">
		<div class="d-flex py-3">
			<h3>주문 예상 금액: ${total > 0 ? dcf.format(total) : 0}원</h3>
			<a href="cart-check-out" class="mx-3 btn btn-primary">구매하기</a>
		</div>

		<table class="table table-light">
			<thead>
				<tr>
					<th scope="col">상품명</th>
					<th scope="col">카테고리</th>
					<th scope="col">가격</th>
					<th scope="col">바로구매</th>
					<th scope="col">취소</th>
				</tr>

			</thead>

			<tbody>
				<%
				if (cart_list != null) {
					for (Cart cartItem : cartProduct) {
				%>
				<tr>
					<td><%=cartItem.getName()%></td>
					<td><%=cartItem.getCategory()%></td>
					<td><%=dcf.format(cartItem.getPrice()) + "원"%></td>
					<td>
						<form action="order-now" method="post" class="form-inline">
							<input type="hidden" name="id" value="<%=cartItem.getId()%>"
								class="form-input">
							<div class="form-group d-flex justify-content-between w-50">
								<a class="btn btn-sm btn-decre"
									href="quantity-inc-dec?action=dec&id=<%=cartItem.getId()%>"><i
									class="fas fa-minus-square"></i></a> <input type="text"
									name="quantity" class="form-control w-50"
									value="<%=cartItem.getQuantity()%>" readonly> <a
									class="btn btn-sm btn-incre"
									href="quantity-inc-dec?action=inc&id=<%=cartItem.getId()%>"><i
									class="fas fa-plus-square"></i></a>
							</div>
							<button type="submit" class="btn btn-primary btn-sm">구매</button>
						</form>
					</td>
					<td><a href="remove-from-cart?id=<%=cartItem.getId()%>"
						class="btn btn-sm btn-danger">삭제</a></td>
				</tr>
				<%
				}
				}
				%>


			</tbody>
		</table>
	</div>

	<%@ include file="/includes/footer.jsp"%>
</body>
</html>