<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" ng-app="registrationApp">
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

	<div class="container" ng-controller="registrationCtrl">
		<div id="errorBlock" class="clearfix alert alert-error ng-hide" ng-hide="!isError">
			<div>
				<h4>${node.properties.error}</h4>
				<ul id="errorMessages">
					<li ng-repeat="error in errors">{{error.message}}</li>
				</ul>
			</div>
		</div>

		<div id="infoBlock" class="clearfix alert alert-primary ng-hide" ng-hide="!isOk"">
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
									<input required ng-minlength=6 ng-minlength=32 type="text" ng-model="registration.userName" placeholder="${node.properties.userNameLabel}" name="userName" id="userName"/>
								</div>
								<div ng-show="registrationForm.userName.$dirty && registrationForm.userName.$invalid">
									<small class="label label-warning" ng-show="registrationForm.userName.$error.required">${node.properties.userNameValidationError}</small>
									<small class="label label-warning" ng-show="registrationForm.userName.$error.minlength">${node.properties.userNameValidationError}</small>
									<small class="label label-warning" ng-show="registrationForm.userName.$error.maxlength">${node.properties.userNameValidationError}</small>
								</div>
								
							</div>
						</div>

						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.passwordLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-lock"></i></span>
									<input required ng-minlength=6 ng-minlength=32 type="password" ng-model="registration.password" placeholder="${node.properties.passwordLabel}"  name="password" id="password"/>
								</div>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.passwordConfirmLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-lock"></i></span>
									<input required ng-minlength=6 ng-minlength=32 type="password" ng-model="registration.passwordConfirm" placeholder="${node.properties.passwordConfirmLabel}"  name="passwordConfirm" id="passwordConfirm"/>
								</div>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.lastNameLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-user-md"></i></span>
									<input required type="text" ng-model="registration.lastName" placeholder="${node.properties.lastNameLabel}"  name="lastName" id="lastName">
								</div>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.firstNameLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-user-md"></i></span>
									<input required type="text" ng-model="registration.firstName" placeholder="${node.properties.firstNameLabel}"  name="firstName" id="firstName">
								</div>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.phoneLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-phone"></i></span>
									<input required type="text" ng-model="registration.phone" placeholder="${node.properties.phoneLabel}" name="phone" id="phone">
								</div>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.emailLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-envelope"></i></span>
									<input required type="email" ng-model="registration.email" placeholder="${node.properties.emailLabel}"  name="email" id="email">
								</div>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.emailConfirmLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-envelope"></i></span>
									<input required type="email" ng-model="registration.emailConfirm" placeholder="${node.properties.emailConfirmLabel}"  name="emailConfirm" id="emailConfirm">
								</div>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label" for="inputIcon">${node.properties.userTypeLabel}</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-wrench"></i></span> 
									<select required ng-model="registration.userType" placeholder="${node.properties.userTypeLabel}" name="userType" id="userType">
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
									<select required ng-model="registration.flatNumber" placeholder="${node.properties.flatNumberLabel}" name="flatNumber" id="flatNumber">
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
									<select required ng-model="registration.flatOwner" placeholder="${node.properties.flatOwnerLabel}" name="flatOwner" id="flatOwner">
										<c:set var="query" value="SELECT nodes.* FROM [nt:base] as nodes WHERE nodes.[sling:resourceType] = 'flatmanager/flatowner'"/>
										<c:forEach var="n" items="${node.SQL2Query[query]}" >
												<option>${n.properties.flatowner}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label" for="inputIcon">
							<img ng-click="refreshCaptchaImage($event.target)" id="captchaImage" ng-src="{{captchaImage}}"/></label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-magic"></i></span>
									<input  required class="input-xlarge" ng-model="registration.captchaCode" type="text" placeholder="${node.properties.captchaLabel}"  name="captchaCode" id="captchaCode" data-placement="right" data-content="${node.properties.captchaDescription}" rel="popover" data-original-title="${node.properties.captchaTitle}"/>
								</div>
							</div>
						</div>
					</fieldset>

					<div class="control-group">
						<label class="control-label"></label>
							<div class="controls">
								<button id="formSubmit" ng-click="register()" ng-disabled="registrationForm.$invalid" class="btn btn-primary" >${node.properties.formSubmitButtonLabel}</button>
							</div>
					</div>
				</form>
			</div>
		</div>
	</div>

<jsp:directive.include file="../javascript-jquery.jsp" />
<jsp:directive.include file="../javascript-angular.jsp" />
<jsp:directive.include file="../javascript-bootstrap.jsp" />
<script type="text/javascript" src="${node.path}.js">>
</script>
</body>
</html>

