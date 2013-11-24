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
<title>LibraWeb SAAS</title>
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
<%--
						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.titleLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-user-md"></i></span>
									<input type="text" placeholder="${node.properties.titleLabel}"  name="title" id="title">
								</div>
							</div>
						</div>
						 --%>
						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.lastNameLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-user-md"></i></span>
									<input type="text" placeholder="${node.properties.lastNameLabel}"  name="lastName" id="lastName">
								</div>
							</div>
						</div>
<%--
						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.middleNameLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-user-md"></i></span>
									<input type="text" placeholder="${node.properties.middleNameLabel}"  name="middleName" id="middleName">
								</div>
							</div>
						</div>
--%>
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
							<label class="control-label" for="inputIcon">${node.properties.positionLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-eye-open"></i></span>
									<input type="text" placeholder="${node.properties.positionLabel}"  name="position" id="position">
								</div>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.userIsSignatoryLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<input type="checkbox" placeholder="${node.properties.userIsSignatoryLabel}"  name="userIsSignatory" id="userIsSignatory">
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


					<fieldset>
						<legend>${node.properties.formBlockSectionAddressDataDataLegend}</legend>

						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.companyMainPostalCodeLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-group"></i></span>
									<input type="text" placeholder="${node.properties.companyMainPostalCodeLabel}" name="companyMainPostalCode" id="companyMainPostalCode"/>
								</div>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.companyMainAddressCityLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-group"></i></span>
									<input type="text" placeholder="${node.properties.companyMainAddressCityLabel}" name="companyMainCity" id="companyMainCity"/>
								</div>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.companyMainAddressStreetLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-group"></i></span>
									<input type="text" placeholder="${node.properties.companyMainAddressStreetLabel}" name="companyMainStreet" id="companyMainStreet"/>
								</div>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.companyMainAddressNumberLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-group"></i></span>
									<input type="text" placeholder="${node.properties.companyMainAddressNumberLabel}" name="companyMainNumber" id="companyMainNumber"/>
								</div>
							</div>
						</div>

					</fieldset>

					<fieldset>
						<legend>${node.properties.formBlockSectionCompanyDataLegend}</legend>

						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.companyNameLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-group"></i></span>
									<input class="input-xxlarge" type="text" placeholder="${node.properties.companyNameLabel}" name="companyName" id="companyName"/>
								</div>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.companyShortNameLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-group"></i></span>
									<input type="text" placeholder="${node.properties.companyShortNameLabel}" name="companyShortName" id="companyShortName"/>
								</div>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.companyTaxNumberLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-group"></i></span>
									<input type="text" placeholder="${node.properties.companyTaxNumberLabel}" name="companyTaxNumber" id="companyTaxNumber"/>
								</div>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.companyRegistrationNumberLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-group"></i></span>
									<input type="text" placeholder="${node.properties.companyRegistrationNumberLabel}" name="companyRegistrationNumber" id="companyRegistrationNumber"/>
								</div>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.companyAccountNumberLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-group"></i></span>
									<input type="text" placeholder="${node.properties.companyAccountNumberLabel}" name="companyAccountNumber" id="companyAccountNumber"/>
								</div>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.companyAccountBankLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-group"></i></span>
									<input type="text" placeholder="${node.properties.companyAccountBankLabel}" name="companyAccountBank" id="companyAccountBank"/>
								</div>
							</div>
						</div>
					</fieldset>

					<fieldset>
						<legend>${node.properties.formBlockSectionSignatory1Legend}</legend>
						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.signatory1FullNameLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-user-md"></i></span>
									<input class="input-xxlarge" type="text" placeholder="${node.properties.signatory1FullNameLabel}"  name="signatory1FullName" id="signatory1FullName">
								</div>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.signatory1EmailLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-envelope"></i></span>
									<input type="text" placeholder="${node.properties.signatory1EmailLabel}"  name="signatory1Email" id="signatory1Email">
								</div>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.signatory1PhoneLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-phone"></i></span>
									<input type="text" placeholder="${node.properties.signatory1PhoneLabel}" name="signatory1Phone" id="signatory1Phone">
								</div>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.signatory1PositionLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-eye-open"></i></span>
									<input type="text" placeholder="Pozíció"  name="signatory1Position" id="signatory1Position">
								</div>
							</div>
						</div>
					</fieldset>

					<fieldset>
						<legend>${node.properties.formBlockSectionSignatory2Legend}</legend>
						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.signatory2FullNameLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-user-md"></i></span>
									<input class="input-xxlarge" type="text" placeholder="${node.properties.signatory2FullNameLabel}"  name="signatory2FullName" id="signatory2FullName">
								</div>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.signatory2EmailLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-envelope"></i></span>
									<input type="text" placeholder="${node.properties.signatory2EmailLabel}"  name="signatory2Email" id="signatory2Email">
								</div>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.signatory2PhoneLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-phone"></i></span>
									<input type="text" placeholder="Telefon" name="signatory2Phone" id="signatory2Phone">
								</div>
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.signatory2PositionLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-eye-open"></i></span>
									<input type="text" placeholder="${node.properties.signatory2PositionLabel}"  name="signatory2Position" id="signatory2Position">
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

	// Auto complete
	$('#companyMainPostalCode').typeahead({
		source: function (query, process) {
			return $.get('/search/locations.json', {f:'postalCode', q:'nPostalCode:'+query }, function (data) {
				var newData = [];
				$.each(data.records, function(){
					newData.push(this.name);
				});
				return process(newData);
			});
		}
	});

	// Auto complete
	$('#companyMainCity').typeahead({
		source: function (query, process) {
			return $.get('/search/locations.json', {f:'city', q:'nCity:'+query+" postalCode:"+ $("#companyMainPostalCode").val() }, function (data) {
				var newData = [];
				$.each(data.records, function(){
					newData.push(this.name);
				});
				return process(newData);
			});
		}
	});

	// Auto complete
	$('#companyMainStreet').typeahead({
		source: function (query, process) {
			return $.get('/search/locations.json', {f:'streetFull', q:'nStreetFull:'+query+" postalCode:"+ $("#companyMainPostalCode").val()+" city:"+ $("#companyMainCity").val() }, function (data) {
				var newData = [];
				$.each(data.records, function(){
					newData.push(this.name);
				});
				return process(newData);
			});
		}
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
			signatory1FullName: {
				minlength: 6
			},
			signatory2FullName: {
				minlength: 6
			},
			signatory1Email: {
				email: true,
				requred: false
			},
			signatory2Email: {
				email: true,
				requred: false
			}
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
				url: "/webservices/saasRegistrationService/register.json?locale=${locale}",
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
						    "class" : "btn-success",
						    "callback": function() {
								window.location.replace("/login");
						    }
						}]);

						
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

