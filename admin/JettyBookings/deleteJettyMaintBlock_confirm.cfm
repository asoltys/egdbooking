<cfif structKeyExists(URL, 'BRID')>
  <cfset Form.BRID = URL.BRID />
</cfif>

<cfoutput>
<cfif isDefined("form.BRID")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfquery name="getBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Bookings.StartDate, Bookings.EndDate, Jetties.NorthJetty, Jetties.SouthJetty
	FROM 	Bookings INNER JOIN Jetties ON Bookings.BRID = Jetties.BRID
	WHERE	Bookings.BRID = <cfqueryparam value="#Form.BRID#" cfsqltype="cf_sql_integer" />
</cfquery>

<cfif DateCompare(PacificNow, getBooking.startDate, 'd') NEQ 1 OR (DateCompare(PacificNow, getBooking.startDate, 'd') EQ 1 AND DateCompare(PacificNow, getBooking.endDate, 'd') NEQ 1)>
	<cfset variables.actionCap = "Cancel">
	<cfset variables.actionPast = "cancelled">
<cfelse>
	<cfset variables.actionCap = "Delete">
	<cfset variables.actionPast = "deleted">
</cfif>


<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Confirm #variables.actionCap# Maintenance Block"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dcterms.subject"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Confirm #variables.actionCap# Maintenance Block</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfset Variables.BRID = Form.BRID>
<cfset Variables.Start = getBooking.StartDate>
<cfset Variables.End = getBooking.EndDate>
<cfset Variables.NorthJetty = getBooking.NorthJetty>
<cfset Variables.SouthJetty = getBooking.SouthJetty>

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</a> &gt;
			<CFELSE>
				 <a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			<a href="jettyBookingManage.cfm?lang=#lang#">Jetty Management</a> &gt;
			Confirm #variables.actionCap# Maintenance Block
			
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Confirm #variables.actionCap# Maintenance Block
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<cfinclude template="#RootDir#includes/admin_menu.cfm">


				<p>Please confirm the following maintenance block information.</p>
				<cfform action="deleteJettyMaintBlock_action.cfm?#urltoken#" method="post" id="bookingreq" preservedata="Yes">
				<input type="hidden" name="BRID" value="#Variables.BRID#" />

				<table style="width:80%;" align="center">
					<tr><td align="left"><div style="font-weight:bold;">Booking:</div></td></tr>
					<tr>
						<td id="Start" align="left" style="width:25%;">Start Date:</td>
						<td headers="Start"><input type="hidden" name="StartDate" value="#Variables.Start#" />#DateFormat(Variables.Start, 'mmm d, yyyy')#</td>
					</tr>
					<tr>
						<td id="End" align="left">End Date:</td>
						<td headers="End"><input type="hidden" name="EndDate" value="#Variables.End#" />#DateFormat(Variables.End, 'mmm d, yyyy')#</td>
					</tr>
					<tr>
						<td id="Sections" align="left">Sections:</td>
						<td headers="Sections">
							<input type="hidden" name="NorthJetty" value="#Variables.NorthJetty#" />
							<input type="hidden" name="SouthJetty" value="#Variables.SouthJetty#" />
							<cfif Variables.NorthJetty EQ 1>
								North Landing Wharf
							</cfif>
							<cfif Variables.SouthJetty EQ 1>
								<cfif Variables.NorthJetty EQ 1>
									&amp;
								</cfif>
								South Jetty
							</cfif>
						</td>
					</tr>
				</table>

				<br />
				<table style="width:100%;" cellspacing="0" cellpadding="1" border="0">
					<tr>
						<td colspan="2" align="center">
							<input type="submit" value="#variables.actionCap# Maintenance" class="textbutton" />
							<input type="button" value="Back" class="textbutton" onclick="self.location.href='jettyBookingManage.cfm?#urltoken#';" />
						</td>
					</tr>
				</table>

				</cfform>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
</cfoutput>
