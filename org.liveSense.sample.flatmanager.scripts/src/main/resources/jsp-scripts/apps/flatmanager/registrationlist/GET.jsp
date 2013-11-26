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

		<c:if test="${Managers}">
			<c:set var="query" value="SELECT * FROM [nt:unstructured] WHERE [sling:resourceType] = 'liveSense/ActivationCode' AND [userType] = 'OWNER' ORDER BY [expire]"/>
		</c:if>

		<c:if test="${Owners}">
			<c:set var="query" value="SELECT * FROM [nt:unstructured] WHERE [sling:resourceType] = 'liveSense/ActivationCode' AND [userType] = 'RENTER' AND [flatNumber] = ${userProps_flatNumber.long} ORDER BY [expire]"/>
		</c:if>

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
						<td>
							<button type="submit" activateSubmitValue="${n.name}", class="btn btn-primary" >${node.properties.activateUserLabel}</button>
						</td>
					</form>
				</tr>	
				<!--  TODO Access rights -->
			</c:forEach>
		</table>

	</div>

<jsp:directive.include file="../javascript-jquery.jsp" />
<jsp:directive.include file="../javascript-bootstrap.jsp" />


<script type="text/javascript">
$(document).ready(function(){

	$("button[activateSubmitValue]").click(function(event) { 
		var button = $(this).data('clicked',$(event.target))
		event.preventDefault();
		$.ajax({
			type: "POST",
			data: {activationCode : button.attr("activateSubmitValue")},			
			url: "/webservices/flatManagerRegistrationService/activate.json?locale=${locale}",
			success: function (res) {
				// Server validation error
				if (res.ok === false) {
					// Marking fields as invalid and 
					var globalErrors = [];
					jQuery.each(res.errors, function() {
						globalErrors.push(this.message);
					});
					$("#errorBlock").show();
					$("#errorMessages").empty();
					jQuery.each(globalErrors, function() {
						$("#errorMessages").append('<li>'+this+'</li>'); 
					});
					
					// Scroll on top
					$('html, body').animate({
						scrollTop: $('html, body').offset().top-100
					}, 500);
					
					
				// Registration is OK. 
				} else {
					bootbox.dialog("${node.properties.infoBlockMessage}", [{
					    "label" : "Ok",
					    "class" : "btn-success",
					    callback: function() {
					    	location.reload();
					    }
					}]);
				}
			},
			error: function(jqXHR, textStatus, errorThrown){
				bootbox.alert("${communicationError}" + textStatus, errorThrown);
			}
		});
	});
});
</script>
</body>
</html>

