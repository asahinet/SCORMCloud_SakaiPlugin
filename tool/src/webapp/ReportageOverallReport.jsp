<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.springframework.web.context.WebApplicationContext" %>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@ page import="com.rusticisoftware.scormcloud.tool.ScormCloudToolBean" %>
<%@ page import="com.rusticisoftware.scormcloud.model.ScormCloudPackage" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%
    // Get the backing bean from the spring context
    WebApplicationContext context = 
        WebApplicationContextUtils.getWebApplicationContext(application);
    ScormCloudToolBean bean = (ScormCloudToolBean)context.getBean("scormCloudToolBean");
    
    bean.doPageChecks(request, response);
    
    pageContext.setAttribute("bean", bean);
    pageContext.setAttribute("isConfigured", bean.isPluginConfigured());
    pageContext.setAttribute("canConfigure", bean.canConfigurePlugin());
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<script src="/library/js/headscripts.js" language="JavaScript" type="text/javascript"></script>
<link media="all" href="/library/skin/tool_base.css" rel="stylesheet" type="text/css"/>
<link media="all" href="/library/skin/default/tool.css" rel="stylesheet" type="text/css"/>
<link media="all" href="css/ScormCloud.css" rel="stylesheet" type="text/css"/>

<script language="Javascript" type="text/javascript" src="http://dev.cloud.scorm.com/Reportage/scripts/reportage.combined.js"></script>
<link media="all" rel="stylesheet" type="text/css" href="css/reportage.combined.sakai.css"></link>
<!-- <link media="all" rel="stylesheet" type="text/css" href="http://dev.cloud.scorm.com/Reportage/css/reportage.combined.css"></link> -->

<script language="Javascript" type="text/javascript">
	$(document).ready( function() {
		loadScript('${summaryUrl}');
		loadScript('${learnerDetailsUrl}');
		loadScript('${courseDetailsUrl}');
	});
</script>

<title>SCORM Cloud Reportage Report</title>
</head>
<body onload="<%= request.getAttribute("sakai.html.body.onload") %>">
<div class="portletBody">

	<div class="navIntraTool">
	    <a href="controller?action=viewPackages">List Resources</a>
	    <a href="controller?action=viewRegistrations">Search Registrations</a>
	    <c:if test="${canConfigure}">
		    <a href="controller?action=viewCloudConfiguration">Configure Plugin</a>
		    <c:choose>
			    <c:when test="${isConfigured}">
			    	<a href="controller?action=viewUsage">View Usage</a>
			    </c:when><c:otherwise>
			    	<a href="controller?action=viewSignup">Sign Up</a>
			    </c:otherwise>
		    </c:choose>
	    </c:if>
	</div>
	
	<h3 class="insColor insBak insBorder">SCORM Cloud Reportage Reports</h3>
	
	<c:if test="${fn:length(bean.messages) > 0}">
	    <div class="alertMessage">
	        <ul style="margin:0px;">
	        <c:forEach var="msg" items="${bean.messages}">
	            <li>${msg}</li>
	        </c:forEach>
	        </ul>
	    </div>
	    <% bean.messages.clear(); %>
	</c:if>
	
	
	<div class="instruction">
		Shown below are some reports showing aggregate information about 
		all of your learner registrations that have been launched via SCORM Cloud.
		To access the Reportage application directly, please 
		<a target="_blank" href="controller?action=launchReportage">click here</a>.
	</div>
	
	<div class="group_summary_report_wrapper">
		<div style="height:20px"></div>
	
		<div id="reportageSummary" class="reportage_summary gray_text">Loading...</div>
	
		<div style="height:20px"></div>
		
		<table class="group_report_details_table">
			<tr>
				<td class="group_report_details_holder">
					<div id="reportageLearnerDetails" class="reportage_details gray_text">Loading...</div>
				</td>
				<td><div style="width:20px"></div></td>
				<td class="group_report_details_holder">
					<div id="reportageCourseDetails" class="reportage_details gray_text">Loading...</div>
				</td>
			</tr>
		</table>
	</div>

</div>
</body>
</html>
