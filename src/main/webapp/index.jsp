

<%@page import="java.text.DecimalFormat"%>
<%@page import="com.yhs.portfolio.model.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.yhs.portfolio.model.Product"%>
<%@page import="java.util.List"%>
<%@page import="com.yhs.portfolio.dao.ProductDao"%>
<%@page import="com.yhs.portfolio.model.User"%>
<%@page import="com.yhs.portfolio.connection.DbConnection"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%
DecimalFormat dcf = new DecimalFormat("#,###");
request.setAttribute("dcf", dcf);
User auth = (User) request.getSession().getAttribute("auth");
if (auth != null) {
	request.setAttribute("auth", auth);
}

ProductDao pd = new ProductDao(DbConnection.getConnection());
List<Product> products = pd.getAllProducts();

List<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
if (cart_list != null) {
	request.setAttribute("cart_list", cart_list);
}
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/includes/header.jsp"%>
<title>쿠퐌!</title>
</head>
<body>
	<%@ include file="/includes/navbar.jsp"%>


	<div class="container">
		<div class="card-header my-3">모든 상품</div>
		<div class="row">


			<%
			if (!products.isEmpty()) {

				for (Product p : products) {
			%>
			<div class="col-md-3 my-3">
				<div class="card w-100" style="width: 18rem;">
					<img class="card-img-top" src="product-images/<%=p.getImage()%>"
						alt="Cart Image">
					<div class="card-body">
						<h5 class="card-title"><%=p.getName()%></h5>
						<h6 class="price">
							가격: <%=dcf.format(p.getPrice())%>원</h6>
						<h6 class="category">
							카테고리:
							<%=p.getCategory()%></h6>
						<div class="mt-3 d-flex justify-content-between">
							<a href="add-to-cart?id=<%=p.getId()%>" class="btn btn-primary btn-sm"> 장바구니 담기 </a> 
							<a href="order-now?quantity=1&id=<%= p.getId() %>" class="btn btn-primary btn-sm"> 바로구매 </a>
						</div>
					</div>
				</div>
			</div>
			<%
			}
			}
			%>

		</div>
	</div>

	<%@ include file="/includes/footer.jsp"%>
</body>
</html>