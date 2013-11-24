<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="sling" uri="http://sling.apache.org/taglibs/sling/1.0"%>
<%@page session="false"%>
<%@page contentType="text/html; charset=UTF-8"%>

<html xmlns="http://www.w3.org/1999/xhtml" lang="hu">
<head>
<title>LibraWeb SAAS</title>
<meta name="description" content="Libra SAAS">
<jsp:directive.include file="../head-metatags.jsp" />
<jsp:directive.include file="../head-bootstrap.jsp" />
</head>
<body>
	<jsp:directive.include file="../sling.jsp" />
	<jsp:directive.include file="../authentication.jsp" />
	<jsp:directive.include file="../currentNode.jsp" />
	<jsp:directive.include file="../currentLocale.jsp" />

	<jsp:directive.include file="../navbar.jsp" />
	<jsp:directive.include file="../markdown.jsp" />


	<div class="container">
		<div id="indexContent">${markdown[node.properties['content']]}</div>
	</div>

	<jsp:directive.include file="../javascript-jquery.jsp" />
	<jsp:directive.include file="../javascript-bootstrap.jsp" />
	<jsp:directive.include file="../contentEditor.jsp" />
</body>
</html>