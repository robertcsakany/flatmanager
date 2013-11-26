<%@page contentType="text/html; charset=UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="sling" uri="http://sling.apache.org/taglibs/sling/1.0"%>

<fmt:message bundle="${resourceBundle}" key="logout" var="logoutMsg"/>
<fmt:message bundle="${resourceBundle}" key="loggedInAs" var="loggedInAsmsg"/>
<fmt:message bundle="${resourceBundle}" key="login" var="loginMsg"/>
<fmt:message bundle="${resourceBundle}" key="userName" var="userNameMsg"/>
<fmt:message bundle="${resourceBundle}" key="password" var="passwordMsg"/>

<div id="topmenu" class="navbar-gradient navbar navbar-fixed-top">
	<div class="navbar-gradient navbar-inner">
		<div class="container">
			<a class="btn btn-navbar" data-toggle="collapse"
				data-target=".nav-collapse"> <span class="icon-bar"></span> <span
				class="icon-bar"></span> <span class="icon-bar"></span>
			</a>
			
			<a class="brand" style="padding-top: 0px;padding-bottom: 0px;" href="../"><img src="/images/virtua-logo.png"/></a>
			<div class="nav-collapse" id="main-menu">
				<ul class="nav" id="main-menu-left">
					<c:set var="query" value="SELECT * FROM [nt:base] WHERE menu_order IS NOT NULL ORDER BY [menu_order]"/>
					<c:set var="cnt" value="0"/> 
					<c:forEach var="n" items="${node.SQL2Query[query]}">
						<c:set var="cnt" value="${cnt+1}"/> 
						<c:choose>
							<c:when test="${n.name == node.name}">
								<li class="active"><a href="${n.name}.html">${n.properties['caption']}</a></li>
							</c:when>
							<c:otherwise>
								<li><a href="${n.name}.html">${n.properties['caption']}</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</ul>

				<c:if test="${!authenticated}">
				
				<!-- The drop down menu -->
					<ul class="nav pull-right">
						<li><a href="registration"><small>Regisztráció</small></a></li>
						<li class="dropdown"><a class="dropdown-toggle" href="#"
							data-toggle="dropdown"><small>Bejelentkezés</small><strong class="caret"></strong></a>
							<div class="dropdown-menu"
								style="padding: 15px; padding-bottom: 0px;">

								<form class="navbar-form pull-right" id="navbarloginform" name="navbarloginform" method="post"
									action="/j_security_check" enctype="multipart/form-data"
									accept-charset="UTF-8">
									<input type="text" class="span2" placeholder="${userNameMsg}" name="j_username" id="j_username">
									<input type="password" class="span2" placeholder="${passwordMsg}"  name="j_password" id="j_password">
									<input type="submit" value="${loginMsg}" class="btn btn-primary" />
									<input type="hidden" name="_charset_" value="UTF-8" />
									<input type="hidden"name="resource" value="${pageContext.request.requestURI}" />
								</form>

							</div></li>
					</ul>
				</c:if>

				<c:if test="${authenticated}">
					<form class="navbar-form pull-right" id="navbarloginform" name="navbarloginform" method="get"
						action="/system/sling/logout" enctype="multipart/form-data"
						accept-charset="UTF-8">
						<span><small>Felhasználó : ${userName}</small></span>
						<input type="submit" value='${logoutMsg}' class="btn btn-danger btn-mini icon-off" />
						<input type="hidden" name="_charset_" value="UTF-8" />
						<%--<input type="hidden"name="resource" value="${pageContext.request.requestURI}" /> --%>
					</form>
				</c:if>
			</div>
		</div>
	</div>
</div>
