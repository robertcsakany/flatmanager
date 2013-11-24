<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@page import="org.apache.sling.jcr.jackrabbit.accessmanager.PrivilegesInfo"%>
<%@page import="org.liveSense.core.wrapper.JcrNodeWrapper"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page session="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="java.util.Locale "%>
<head>
<title>LibraWeb SAAS dd</title>
<meta name="description" content="Libra SAAS"/>
<jsp:directive.include file="../head-metatags.jsp" />
<jsp:directive.include file="../head-bootstrap.jsp" />
</head>

<jsp:directive.include file="../sling.jsp" />
<jsp:directive.include file="../currentNode.jsp" />
<jsp:directive.include file="../currentLocale.jsp" />

<body>
	<jsp:directive.include file="../navbar.jsp" />
	<div class="container">
		<div id="errorBlock" class="clearfix alert alert-error" style="display: none;">
			<div>
				<h4>${node.properties.errorBlockHeader}</h4>
				<ul id="errorMessages"></ul>
			</div>
		</div>

		<div id="infoBlock" class="clearfix alert alert-primary" style="display: none;">
			<div>
				<h4>${node.properties.infoBlockHeaderValidate}</h4>
				<p id="infoMessage">${node.properties.infoBlockMessageValidate}</p>
			</div>
		</div>

		<div id="changePasswordFormBlock">
			<h2>${node.properties.pageTitleValidate}</h2>
			<div class="span12" >
				<form class="form-horizontal" action="#" method="post" name="changePasswordForm" id="changePasswordForm">
					<fieldset>
						<legend>${node.properties.formBlockHeaderValidate}</legend>
						<p>${node.properties.formBlockMessageValidate}</p>

						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.resetCodeLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-lock"></i></span>
									<input type="text" placeholder="${node.properties.resetCodeLabel}"  name="resetCode" id="resetCode" value="${param.resetCode}"/>
								</div>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.newPasswordLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-lock"></i></span>
									<input type="password" placeholder="${node.properties.newPasswordLabel}"  name="password" id="password"/>
								</div>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.newPasswordConfirmLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-lock"></i></span>
									<input type="password" placeholder="${node.properties.newPasswordConfirmLabel}" name="passwordConfirm" id="passwordConfirm" />
								</div>
							</div>
						</div>
					</fieldset>
					<div class="control-group">
						<label class="control-label"></label>
							<div class="controls">
								<button id="formSubmit" type="submit" class="btn btn-primary" >${node.properties.submitButtonLabelValidation}</button>
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

	var registrationValidator = $('#changePasswordForm').validate({
		focusInvalid: false,
		invalidHandler: function(form, validator) {
			if (!validator.numberOfInvalids())
				return;
			$('html, body').animate({
				scrollTop: $(validator.errorList[0].element).offset().top-100
			}, 500);
		},
		rules: {
			resetCode: {
				required: true,
				minlength: 8,
				maxlength: 8
			},
			password: {
				minlength: 6,
				required: true
			},
			passwordConfirm: {
				minlength: 6,
				required: true,
				equalTo: "#password"
			}
		},
		highlight: function(label) {
			$(label).closest('.control-group').addClass('error');
		},
		success: function(label) {
			label.text('OK!').addClass('valid').closest('.control-group').addClass('success');
		}
	});
	
	$("#formSubmit").click(function() {  
		// Revalidate form and if valid submit it
		if ($("#changePasswordForm").valid()) {
		
			var frm = $('#changePasswordForm');
			$.ajax({
				type: "POST",
				data: frm.serialize(),			
				url: "/webservices/saasRegistrationService/changepassword.json?locale=${locale}",
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
						
						
					// Change password is OK. 
					} else {
						// Show info block
						$("#infoBlock").show();
						$("#errorBlock").hide();
						$("#changePasswordFormBlock").hide();

						// Scroll on top
						$('html, body').animate({
							scrollTop: $('html, body').offset().top-100
						}, 500);
						
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

