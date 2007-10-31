<cfhtmlhead text="
<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Administrative Functions"">
<meta name=""keywords"" lang=""eng"" content="""">
<meta name=""description"" lang=""eng"" content="""">
<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
<meta name=""dc.date.published"" content=""2005-07-25"">
<meta name=""dc.date.reviewed"" content=""2005-07-25"">
<meta name=""dc.date.modified"" content=""2005-07-25"">
<meta name=""dc.date.created"" content=""2005-07-25"">
<title>PWGSC - ESQUIMALT GRAVING DOCK - Administrative Functions</title>">

<cfinclude template="#RootDir#includes/header-#lang#.cfm">

<!---clear form structure--->
<cfif IsDefined("Session.Form_Structure")>
	<cfset StructDelete(Session, "Form_Structure")>
</cfif>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>PWGSC - ESQUIMALT GRAVING DOCK - Administrative Functions</title>
</head>
<body>


<div class="breadcrumbs">
	<a href="<cfoutput>http://www.pwgsc.gc.ca/text/home-#lang#.html</cfoutput>">PWGSC</a> &gt; 
	Pacific Region &gt; 
	<a href="http://www.pwgsc.gc.ca/pacific/egd/text/index-e.html">Esquimalt Graving Dock</a> &gt; 
	<a href="<cfoutput>#RootDir#text/booking-#lang#.cfm</cfoutput>">Booking</A> &gt;
	Administrative Functions
</div>

<div class="main">
<H1>Administrative Functions</H1>
<cfform action="intromsgaction.cfm" method="POST">
  <cffile action="read" file="#FileDir#text\intromsg.txt" variable="intromsg">
  <cfif #Trim(intromsg)# EQ "">
    Please enter a message for users when they first log in. To disable this block on log in, keep the text field blank and click 'Update'
    <cfelse>
    Please update the message for users when they first log in. To disable this block on log in, keep the text field blank and click 'Update'
  </cfif>
  <br />
  <br />
  <textarea name="datatowrite" cols="40" rows="5"><cfif #intromsg# is not ""><cfoutput>#intromsg#</cfoutput></cfif>
</textarea>
  <br />
  <input id="submit" type="submit" value="Update">
</cfform>
</body>
</html>
