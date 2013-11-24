<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@page import="org.apache.sling.jcr.jackrabbit.accessmanager.PrivilegesInfo"%>
<%@page import="org.liveSense.core.wrapper.JcrNodeWrapper"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page session="false"%>
<%@taglib prefix="sling" uri="http://sling.apache.org/taglibs/sling/1.0"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="java.util.Locale "%>
<head>
	<title>FlatManager - Registration Confirmation</title>
	<meta name="description" content="FlatManager - Registration Confirmation"/>
	<jsp:directive.include file="../head-metatags.jsp" />
	<jsp:directive.include file="../head-bootstrap.jsp" />
</head>

<jsp:directive.include file="../sling.jsp" />
<jsp:directive.include file="../currentNode.jsp" />
<jsp:directive.include file="../currentLocale.jsp" />
<jsp:directive.include file="../authentication.jsp" />

<body>
	<jsp:directive.include file="../navbar.jsp" />

	<div class="container">
		<div id="errorBlock" class="clearfix alert alert-error" style="display: none;">
			<div>
				<h4>${node.properties.error}</h4>
				<ul id="errorMessages"></ul>
			</div>
		</div>

		<div id="infoBlock" class="clearfix alert alert-primary" style="display: none;">
			<div>
				<h4>${node.properties.infoBlockHeader}</h4>
				<p id="infoMessage">${node.properties.infoBlockMessage}</p>
			</div>
		</div>

		<c:set var="query" value="SELECT * FROM [nt:unstructured] WHERE [sling:resourceType] = 'liveSense/ActivationCode' ORDER BY [expire]"/>
		<c:set var="cnt" value="0"/>
		<table class="table">
			<c:forEach var="n" items="${node.SQL2Query[query]}">
				<tr>
					<form>
						<td>${n.properties.userType}</td>
						<td>${n.properties.userName}</td>
						<td>${n.properties.firstName}</td>
						<td>${n.properties.lastName}</td>
						<td>${n.properties.phone}</td>
						<td>${n.properties.email}</td>
						<td>${n.properties.flatOwner}</td>
						<td>${n.properties.flatNumber}</td>
						<td>${n.properties.status}</td>
					</form>
				</tr>	
				<!--  TODO Access rights -->
			</c:forEach>
		</table>

	</div>

<jsp:directive.include file="../javascript-jquery.jsp" />
<jsp:directive.include file="../javascript-bootstrap.jsp" />
</body>
</html>

