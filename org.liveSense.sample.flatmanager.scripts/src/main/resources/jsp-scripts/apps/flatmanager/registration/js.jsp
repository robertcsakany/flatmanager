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
	$scope.registration = {};
	
	$scope.isOk = false;
	$scope.isError = false;
	
	$scope.register=function(){
		Restangular.all('register').post($scope.registration).then(
			function(result) {
				if (result.ok) {
					$scope.isOk = true;
				} else {
					$scope.isError = true;
					$scope.errors = result.errors;
					$location.hash('errorBlock');
				}
			},
			function error(reason) {
				$scope.erorrs = [{"message" : "${communicationError}"}];
			}
		);
	}
}

