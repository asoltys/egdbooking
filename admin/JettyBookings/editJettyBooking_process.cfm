<cfif isDefined("form.startDate")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfhtmlhead text="
	<meta name=""dc.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Edit Jetty Booking"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dc.subject"" scheme=""gccore"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Edit Jetty Booking</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<CFPARAM name="url.referrer" default="Booking Management">
<CFIF url.referrer eq "Booking Details">
	<CFSET returnTo = "#RootDir#comm/detail-res-book.cfm">
<CFELSE>
	<CFSET returnTo = "#RootDir#admin/JettyBookings/jettyBookingManage.cfm">
</CFIF>

<cfif isDefined("url.date")>
	<cfset variables.dateValue = "&date=#url.date#">
<cfelse>
	<cfset variables.dateValue = "">
</cfif>

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</a> &gt;
			<CFELSE>
				 <a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			<a href="jettyBookingManage.cfm?lang=#lang#">Jetty Management</a> &gt;
			Edit Booking
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Edit Jetty Booking Information
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

				<!--- Error Validation ------------------------------------------------------------------------------------------------->
				<cfset Errors = ArrayNew(1)>
				<cfset Proceed_OK = "Yes">

				<cfparam name = "Form.StartDate" default="">
				<cfparam name = "Form.EndDate" default="">
				<cfparam name = "Variables.BRID" default="#Form.BRID#">
				<cfparam name = "Variables.StartDate" default = "#Form.StartDate#">
				<cfparam name = "Variables.EndDate" default = "#Form.EndDate#">
				<cfparam name = "Form.VNID" default="">
				<cfparam name = "Form.UID" default="">
				<cfparam name = "Variables.UID" default = "#Form.UID#">

				<cfset Variables.Jetty = Form.Jetty>

				<cfif (NOT IsDefined("Form.BRID") OR Form.BRID eq '') AND (NOT IsDefined("URL.BRID") OR URL.BRID eq '')>
					<cflocation addtoken="no" url="#RootDir#admin/DockBookings/bookingManage.cfm?#urltoken#">
				</cfif>

				<cfif Variables.StartDate EQ "">
					<cfoutput>#ArrayAppend(Errors, "The Start Date has not been entered in.")#</cfoutput>
					<cfset Proceed_OK = "No">
				</cfif>

				<cfset Variables.StartDate = CreateODBCDate(#Variables.StartDate#)>
				<cfset Variables.EndDate = CreateODBCDate(#Variables.EndDate#)>

				<cfif IsDefined("Session.Return_Structure")>
					<cfoutput>#StructDelete(Session, "Return_Structure")#</cfoutput>
				</cfif>

				<cfquery name="getData" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT 	Vessels.VNID, Length, Width, Vessels.Name AS VesselName, Companies.Name AS CompanyName, Jetties.Status
					FROM 	Vessels, Companies, Bookings, Jetties
					WHERE 	Vessels.VNID = Bookings.VNID
					AND		Bookings.BRID = <cfqueryparam value="#FORM.BRID#" cfsqltype="cf_sql_integer" />
					AND		Jetties.BRID = Bookings.BRID
					AND		Companies.CID = Vessels.CID
					AND 	Vessels.Deleted = 0
					AND		Companies.Deleted = 0
				</cfquery>
				<cfquery name="getAgent" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT 	lastname + ', ' + firstname AS UserName
					FROM 	Users
					WHERE 	UID = <cfqueryparam value="#Variables.UID#" cfsqltype="cf_sql_integer" />
				</cfquery>
				<cfset Variables.VNID = getData.VNID>

				<!---Check to see that vessel hasn't already been booked during this time--->
				<cfquery name="checkDblBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT 	Bookings.VNID, Name, StartDate, EndDate
					FROM 	Bookings
								INNER JOIN Vessels ON Vessels.VNID = Bookings.VNID
								INNER JOIN Jetties ON Bookings.BRID = Jetties.BRID
					WHERE 	Bookings.VNID = <cfqueryparam value="#Variables.VNID#" cfsqltype="cf_sql_integer" />
					AND 	Bookings.BRID != <cfqueryparam value="#FORM.BRID#" cfsqltype="cf_sql_integer" />
					AND 	(
								(	Bookings.StartDate <= <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> <= Bookings.EndDate )
							OR 	(	Bookings.StartDate <= <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> <= Bookings.EndDate )
							OR	(	Bookings.StartDate >= <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> >= Bookings.EndDate)
							)
					AND		Bookings.Deleted = 0
					<cfif IsDefined("Form.Jetty") AND form.Jetty EQ "north">
						AND 	Jetties.NorthJetty = 1
					<cfelse>
						AND 	Jetties.SouthJetty = 1
					</cfif>
				</cfquery>

				<cfset Variables.StartDate = DateFormat(Variables.StartDate, 'mm/dd/yyyy')>
				<cfset Variables.EndDate = DateFormat(Variables.EndDate, 'mm/dd/yyyy')>
				<cfset Variables.TheBookingDate = CreateODBCDate(#Form.bookingDate#)>
				<cfset Variables.TheBookingTime = CreateODBCTime(#Form.bookingTime#)>

				<!--- Validate the form data --->
				<cfif Variables.StartDate GT Variables.EndDate>
					<cfoutput>#ArrayAppend(Errors, "The Start Date must be before the End Date.")#</cfoutput>
					<cfset Proceed_OK = "No">
				</cfif>

				<cfif DateDiff("d",Variables.StartDate,Variables.EndDate) LT 0>
					<cfoutput>#ArrayAppend(Errors, "The minimum booking time is 1 day.")#</cfoutput>
					<cfset Proceed_OK = "No">
				</cfif>

				<cfif checkDblBooking.RecordCount GT 0>
					<!---<cfoutput>#ArrayAppend(Errors, "#checkDblBooking.Name# has already been booked from #dateFormat(checkDblBooking.StartDate, 'mm/dd/yyy')# to #dateFormat(checkDblBooking.EndDate, 'mm/dd/yyy')#.")#</cfoutput>--->
					<cfoutput><div style="border: 1px solid ##1F1FC9; border-style:dashed; background: ##F5F5F5; padding:25px;">#checkDblBooking.Name# has already been booked from #dateFormat(checkDblBooking.StartDate, 'mm/dd/yyy')# to #dateFormat(checkDblBooking.EndDate, 'mm/dd/yyy')#.</div></cfoutput>
					<cfset Proceed_OK = "Yes">
				</cfif>

				<cfif getData.Width GTE Variables.MaxWidth OR getData.Length GTE Variables.MaxLength>
					<cfoutput>#ArrayAppend(Errors, "The vessel, #getData.VesselName#, is too large for the drydock.")#</cfoutput>
					<cfset Proceed_OK = "No">
				</cfif>

				<cfif Proceed_OK EQ "No">
					<!--- Save the form data in a session structure so it can be sent back to the form page --->
					<cfset Session.Return_Structure.StartDate = Form.StartDate>
					<cfset Session.Return_Structure.EndDate = Form.EndDate>
					<cfset Session.Return_Structure.TheBookingDate = Variables.TheBookingDate>
					<cfset Session.Return_Structure.TheBookingTime = Variables.TheBookingTime>
					<cfset Session.Return_Structure.BRID = Form.BRID>
					<cfset Session.Return_Structure.VNID = Form.VNID>
					<cfset Session.Return_Structure.UID = Form.UID>
					<cfif Form.Jetty EQ "north">
						<cfset Session.Return_Structure.NorthJetty = 1>
						<cfset Session.Return_Structure.SouthJetty = 0>
					<cfelse>
						<cfset Session.Return_Structure.NorthJetty = 0>
						<cfset Session.Return_Structure.SouthJetty = 1>
					</cfif>

					<cfset Session.Return_Structure.Submitted = Form.Submitted>
					<cfset Session.Return_Structure.Errors = Errors>
					<cfif #Form.submitForm# neq 'overwrite'>
					<cflocation url="editJettyBooking.cfm?#urltoken##variables.dateValue#" addToken="no">
					</cfif>
				</cfif>

				<!---------------------------------------------------------------------------------------------------------------------->

				<p>Please confirm the following information.</p>
				<cfform action="editJettyBooking_action.cfm?#urltoken#&BRID=#form.BRID#&editStart=#form.startDate#&editEnd=#form.endDate#&jetty=#form.jetty#&referrer=#URLEncodedFormat(url.referrer)##variables.dateValue#" method="post" id="bookingreq" preservedata="Yes">
				<cfoutput><input type="hidden" name="BRID" value="#Variables.BRID#" /></cfoutput>
				<div style="font-weight:bold;">Booking:</div>
				<table style="width:100%; padding-left:15px;" align="center" >
					<tr>
						<td id="Vessel" align="left" style="width:20%;">Vessel:</td>
						<td headers="Vessel" style="width:80%;"><cfoutput>#getData.VesselName#</cfoutput></td>
					</tr>
					<tr>
						<td id="Company" align="left">Company:</td>
						<td headers="Company"><cfoutput>#getData.CompanyName#</cfoutput></td>
					</tr>
					<tr>
						<td id="Agent" align="left">Agent:</td>
						<td headers="Agent"><input type="hidden" name="UID" value="<cfoutput>#Variables.UID#</cfoutput>" /><cfoutput>#getAgent.UserName#</cfoutput></td>
					</tr>
					<tr>
						<td id="Start" align="left">Start Date:</td>
						<td headers="Start"><input type="hidden" name="StartDate" value="<cfoutput>#Variables.StartDate#</cfoutput>" /><cfoutput>#DateFormat(Variables.StartDate, 'mmm d, yyyy')#</cfoutput></td>
					</tr>
					<tr>
						<td id="End" align="left">End Date:</td>
						<td headers="End"><input type="hidden" name="EndDate" value="<cfoutput>#Variables.EndDate#</cfoutput>" /><cfoutput>#DateFormat(Variables.EndDate, 'mmm d, yyyy')#</cfoutput></td>
					</tr>
					<tr>
						<td id="bookingDate" align="left">Booking Time:</td>
						<td headers="bookingDate">
							<cfoutput>
								<input type="hidden" name="bookingDate" value="#Variables.TheBookingDate#" />
								<input type="hidden" name="bookingTime" value="#Variables.TheBookingTime#" />
								#DateFormat(Variables.TheBookingDate, 'mmm d, yyyy')# #TimeFormat(Variables.TheBookingTime, 'HH:mm:ss')#
							</cfoutput>
						</td>
					</tr>
					<tr>
						<td id="Length" align="left">Length:</td>
						<td headers="Length"><cfoutput>#getData.Length# m</cfoutput></td>
					</tr>
					<tr>
						<td id="Width" align="left">Width:</td>
						<td headers="Width"><cfoutput>#getData.Width# m</cfoutput></td>
					</tr>
					<tr>
						<td id="Sections" align="left">Sections:</td>
						<td headers="Sections">
							<cfif Variables.Jetty EQ "north">
								North Landing Wharf
							<cfelseif Variables.Jetty EQ "south">
								South Jetty
							</cfif>
						</td>
					</tr>
				</table>

				<br />
				<div style="text-align:center;">
						<input type="submit" value="Confirm" class="textbutton" />
						<cfoutput><input type="button" value="Back" class="textbutton" onclick="self.location.href='editJettyBooking.cfm?#urltoken#&BRID=#form.BRID##variables.dateValue#';" /></cfoutput>
						<cfoutput><input type="button" value="Cancel" class="textbutton" onclick="self.location.href='#returnTo#?#urltoken#&BRID=#form.BRID##variables.dateValue####form.BRID#';" /></cfoutput>
				</div>
				</cfform>

			</div>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
