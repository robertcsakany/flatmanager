<%@page contentType="text/javascript; charset=UTF-8"%>
<%@page session="false"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="java.util.Locale "%>
<jsp:directive.include file="../sling.jsp" />
<jsp:directive.include file="../currentNode.jsp" />
<jsp:directive.include file="../currentLocale.jsp" />
<jsp:directive.include file="../authentication.jsp" />
<fmt:message bundle="${resourceBundle}" key="communicationError" var="communicationError"/>
var registrationApp=angular.module('registrationApp',['restangular'])
	.config(
			function(RestangularProvider) {
				RestangularProvider.setBaseUrl('/webservices/flatManagerRegistrationService');
			}
	);

function registrationCtrl($scope, $log, $location, Restangular){
	
	// Default variables
	$scope.registration = {};
	$scope.captchaImage = "/session/captcha.png";
	$scope.isOk = false;
	$scope.isError = false;
	
	// Register
	$scope.register=function(){
		Restangular.all('register').post($scope.registration).then(
			function(result) {
				if (result.ok) {
					$scope.isOk = true;
				} else {
					$scope.isError = true;
					$scope.errors = result.errors;
					$location.hash('errorBlock');
					$scope.refreshCaptchaImage();
				}
			},
			function error(reason) {
				$scope.erorrs = [{"message" : "${communicationError}"}];
			}
		);
	}
	
	// Refresh captcha image
	$scope.refreshCaptchaImage=function() {
		$scope.captchaImage = "/session/captcha.png?time=" + new Date();
	}
}

