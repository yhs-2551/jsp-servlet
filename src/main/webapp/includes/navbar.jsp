<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

 

<nav class="navbar navbar-expand-lg navbar-light bg-light">
	<div class="container">
		<a class="navbar-brand" href="index.jsp">쿠퐌</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item active"><a class="nav-link"
					href="index.jsp"> </a></li>
				<li class="nav-item"><a class="nav-link" href="cart.jsp">장바구니
						<span class="badge badge-danger">${cart_list.size()}</span>
				</a></li>


				<%
				if (auth != null) {
				%>
				<li class="nav-item"><a class="nav-link" href="orders.jsp">주문목록</a></li>
				<li class="nav-item"><a class="nav-link" href="user-logout">로그아웃</a></li>
				<%
				} else {
				%>
				<li class="nav-item"><a class="nav-link" href="login.jsp">로그인</a></li>
				<%
				}
				%>




			</ul>

		</div>
	</div>
</nav>
