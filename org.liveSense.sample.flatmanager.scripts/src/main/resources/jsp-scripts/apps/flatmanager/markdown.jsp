<%@page import="org.apache.sling.api.scripting.SlingScriptHelper"%>
<%@page import="javax.jcr.Node"%>
<%@page import="org.liveSense.service.markdown.MarkdownService"%>
<%@page import="org.liveSense.service.markdown.MarkdownWrapper"%>

<%
{
	Node currentNode = (Node)pageContext.getAttribute("currentNode");
	SlingScriptHelper sling = (SlingScriptHelper)pageContext.getAttribute("slingScriptHelper");

	pageContext.setAttribute("markdown", new MarkdownWrapper(sling.getService(MarkdownService.class)));
}
%>