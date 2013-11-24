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
	<title>FlatManager - Owner Registration</title>
	<meta name="description" content="FlatManager - Owner Registration"/>
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

		<div id="registrationFormBlock">
			<h2>${node.properties.formBlockTitle}</h2>
			<div class="span12" >
				<form class="form-horizontal" name="registrationForm" id="registrationForm">
					<fieldset>
						<legend>${node.properties.formBlockSectionBaseDataLegend}</legend>

						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.userNameLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-user"></i></span>
									<input type="text" placeholder="${node.properties.userNameLabel}" name="userName" id="userName"/>
								</div>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.passwordLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-lock"></i></span>
									<input type="password" placeholder="${node.properties.passwordLabel}"  name="password" id="password"/>
								</div>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.passwordConfirmLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-lock"></i></span>
									<input type="password" placeholder="${node.properties.passwordConfirmLabel}"  name="passwordConfirm" id="passwordConfirm"/>
								</div>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.lastNameLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-user-md"></i></span>
									<input type="text" placeholder="${node.properties.lastNameLabel}"  name="lastName" id="lastName">
								</div>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.firstNameLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-user-md"></i></span>
									<input type="text" placeholder="${node.properties.firstNameLabel}"  name="firstName" id="firstName">
								</div>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.phoneLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-phone"></i></span>
									<input type="text" placeholder="${node.properties.phoneLabel}" name="phone" id="phone">
								</div>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.emailLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-envelope"></i></span>
									<input type="text" placeholder="${node.properties.emailLabel}"  name="email" id="email">
								</div>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.emailConfirmLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-envelope"></i></span>
									<input type="text" placeholder="${node.properties.emailConfirmLabel}"  name="emailConfirm" id="emailConfirm">
								</div>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.userTypeLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-wrench"></i></span> 
									<select placeholder="${node.properties.userTypeLabel}" name="userType" id="userType">
										<option value="OWNER">${node.properties.userTypeOwnerLabel}</option>
										<option value="RENTER">${node.properties.userTypeRenterLabel}</option>
									</select>
								</div>
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.flatNumberLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-wrench"></i></span> 
									<select placeholder="${node.properties.flatNumberLabel}" name="flatNumber" id="flatNumber">
<!-- 	SELECT nodes.* FROM [nt:unstructured] as nodes WHERE nodes.[sling:resourceType] = 'flatmanager/flats' -->
										<c:set var="query" value="SELECT nodes.* FROM [nt:base] as nodes WHERE nodes.[sling:resourceType] = 'flatmanager/flats'"/>
										<c:forEach var="n" items="${node.SQL2Query[query]}" >
											<c:forEach var="num" step="1" begin="1" end="${n.properties.numberOfFlats.long}" >
												<option>${num}</option>
											</c:forEach>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.flatOwnerLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-wrench"></i></span> 
									<select placeholder="${node.properties.flatOwnerLabel}" name="flatOwner" id="flatOwner">
										<c:set var="query" value="SELECT nodes.* FROM [nt:base] as nodes WHERE nodes.[sling:resourceType] = 'flatmanager/flatowner'"/>
										<c:forEach var="n" items="${node.SQL2Query[query]}" >
												<option>${n.properties.flatowner}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label" for="inputIcon"><img id="captchaImage" src="/session/captcha.png"/></label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-magic"></i></span>
									<input class="input-xlarge" type="text" placeholder="${node.properties.captchaLabel}"  name="captchaCode" id="captchaCode" data-placement="right" data-content="${node.properties.captchaDescription}" rel="popover" data-original-title="${node.properties.captchaTitle}"/>
								</div>
							</div>
						</div>
					</fieldset>

					<div class="control-group">
						<label class="control-label"></label>
							<div class="controls">
								<button id="formSubmit" type="submit" class="btn btn-primary" >${node.properties.formSubmitButtonLabel}</button>
							</div>
					</div>


					
				</form>
			</div>
		</div>
	</div>

<jsp:directive.include file="../javascript-jquery.jsp" />
<jsp:directive.include file="../javascript-bootstrap.jsp" />

<fmt:message bundle="${resourceBundle}" key="communicationError" var="communicationError"/>

<script type="text/javascript">
$(document).ready(function(){
	$('#captchaImage').click(function(e) {
		$("#captchaImage").attr("src", "/session/captcha.png");
	});

	// Custom validator.
	jQuery.validator.addMethod("username",function(value,element) {
		return this.optional(element) || /^[a-zA-Z0-9._-]{6,16}$/i.test(value); 
	},"${node.properties.userNameValidationError}");
	

	var registrationValidator = $('#registrationForm').validate({
		focusInvalid: false,
		invalidHandler: function(form, validator) {
			if (!validator.numberOfInvalids())
				return;
			$('html, body').animate({
				scrollTop: $(validator.errorList[0].element).offset().top-100
			}, 500);
		},
		rules: {
			userName: {
				required: true,
				username: true
			},
			password: {
				minlength: 6,
				required: true
			},
			passwordConfirm: {
				minlength: 6,
				required: true,
				equalTo: "#password"
			},
			email: {
				required: true,
				email: true
			},
			emailConfirm: {
				required: true,
				email: true,
				equalTo: "#email"
			},
			firstName: {
				minlength: 2,
				required: true
			},
			lastName: {
				minlength: 2,
				required: true
			},			
			captchaCode: {
				minlength: 6,
				required: true
			},
		},
		highlight: function(label) {
			$(label).closest('.control-group').addClass('error');
		},
		success: function(label) {
			label.text('OK!').addClass('valid').closest('.control-group').addClass('success');
		}
	});
	
	
	$("#formSubmit").click(function(event) { 
		event.preventDefault();
		// Revalidate form and if valid submit it
		if ($("#registrationForm").valid()) {
		
			var frm = $('#registrationForm');
			$.ajax({
				type: "POST",
				data: frm.serialize(),			
				url: "/webservices/flatManagerRegistrationService/register.json?locale=${locale}",
				success: function (res) {
					// Server validation error
					if (res.ok === false) {
						// Marking fields as invalid and 
						var globalErrors = [];
						jQuery.each(res.errors, function() {
							if (this.field != null) {
								$("#"+this.field).closest('.control-group').addClass('error');
								var errObj = {};
								errObj[this.field] = this.message;
								registrationValidator.showErrors(errObj);
							}
							globalErrors.push(this.message);
						});
						$("#errorBlock").show();
						$("#errorMessages").empty();
						jQuery.each(globalErrors, function() {
							$("#errorMessages").append('<li>'+this+'</li>'); 
						});
						
						// Replace Captcha
						$("#captchaImage").attr("src", "/session/captcha.png");

						// Scroll on top
						$('html, body').animate({
							scrollTop: $('html, body').offset().top-100
						}, 500);
						
						
					// Registration is OK. 
					} else {
						bootbox.dialog("${node.properties.infoBlockMessage}", [{
						    "label" : "Ok",
						    "class" : "btn-success"
						}]);
						
						/*
						,
						    "callback": function() {
								window.location.replace("/login");
						    }
						*/

						// Show info block

//						$("#infoBlock").show();
//						$("#errorBlock").hide();
//						$("#registrationFormBlock").hide();

//						// Scroll on top
//						$('html, body').animate({
//							scrollTop: $('html, body').offset().top-100
//						}, 500);
						
					}
				},
				error: function(jqXHR, textStatus, errorThrown){
					bootbox.alert("${communicationError}" + textStatus, errorThrown);
				}
			});
		}
	});
}); // end document.ready
</script>
</body>
</html>

