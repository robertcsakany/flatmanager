<%
{
		String prefix = "";
		if (request.getHeader("X-Forwarded-Server") != null && request.getHeader("X-Forwarded-Server").indexOf("vosz-kvbsz.hu") != -1) {
			prefix = "http://www.ajanlom.eu";
			pageContext.setAttribute("googleKey", "ABQIAAAAO45JDkEolgT-Cmnx_2VcoxSjJH7UIWmmcqb8Dis3HP0vUYbOnhSJZ2skp63ncRJqEp06XZ5x5rj19Q");
		} else {
			int defPort = 80;
			if (request.getScheme().equals("https")) defPort = 443;
			
			prefix = request.getScheme()+"://"+request.getServerName(); //+":"+getPort+path+"/";
			if (request.getServerPort() != defPort)
				prefix += ":"+request.getServerPort();
			
			if (request.getServerName().equals("localhost")) {
				pageContext.setAttribute("googleKey", "ABQIAAAARrCK38aboqQKDotehUjrPhTb-vLQlFZmc2N8bgWI8YDPp5FEVBQ-MFjXfKfAvdbsbp3pa0q7fQNDDA");				
			} else if (request.getServerName().equals("ajanlom.eu")) {
				pageContext.setAttribute("googleKey", "ABQIAAAAO45JDkEolgT-Cmnx_2VcoxS34joru7k8lQ8-5hQThAYLXtT5ARTaR1aQfurnrpB2PUCrPWvL-IPq1w");								
			}

		}
		pageContext.setAttribute("prefix", prefix);		
		pageContext.setAttribute("atSignUrl", "<img src=\""+prefix+"/images/at-sign-13x13.png\"/>");
}		
%>
