<%@page import="java.util.List"%>
<%@page import="com.yhs.portfolio.model.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.yhs.portfolio.model.User"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
User auth = (User) request.getSession().getAttribute("auth");
if (auth != null) {
	request.setAttribute("auth", auth);
	response.sendRedirect("index.jsp");
}

List<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
if (cart_list != null) {
	request.setAttribute("cart_list", cart_list);
}
%>


<!DOCTYPE html>
<html>
<head>
<%@ include file="/includes/header.jsp"%>
<title>로그인 페이지</title>
</head>
<body>

	<%@ include file="/includes/navbar.jsp"%>
	<div class="container">
		<div class="card w-50 mx-auto my-5">
			<div class="card-header text-center">사용자 이메일 로그인</div>
			<div class="card-body">

				<form action="user-login" method="post">

					<div class="form-group">

						<label>이메일 주소</label> <input type="email"
							class="form-control" name="login-email"
							placeholder="아이디(이메일)" required="required">

					</div>

					<div class="form-group my-3">
						<label>비밀번호</label> <input type="password"
							class="form-control" name="login-password" placeholder="********"
							required="required">

					</div>
					<div class="text-center my-3">
						<button type="submit" class="btn btn-primary">로그인</button>
					</div>


				</form>


			</div>

		</div>

	</div>


	<%@ include file="/includes/footer.jsp"%>

</body>
</html>