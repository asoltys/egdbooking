<!---cfinclude template="#RootDir#includes/restore_params.cfm">
<cfinclude template="#RootDir#includes/build_form_struct.cfm"--->

<cfhtmlhead text="
	<meta name=""dc.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Edit Maintenance Block"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dc.subject"" scheme=""gccore"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Edit Maintenance Block</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<!-- Start JavaScript Block -->
<script type="text/javascript">
/* <![CDATA[ */
function EditSubmit ( selectedform )
	{
	  document.forms[selectedform].submit();
	}
/* ]]> */
</script>
<!-- End JavaScript Block -->
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
			Edit Maintenance Block
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Edit Maintenance Block
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

				<!--- -------------------------------------------------------------------------------------------- --->
				<cfparam name="Variables.BRID" default="">
				<cfparam name="Variables.NorthJetty" default="false">
				<cfparam name="Variables.SouthJetty" default="false">

				<cfif NOT IsDefined("Session.form_Structure")>
					<cfinclude template="#RootDir#includes/build_form_struct.cfm">
					<cfinclude template="#RootDir#includes/restore_params.cfm">
				<cfelse>
					<cfinclude template="#RootDir#includes/restore_params.cfm">
					<cfif isDefined("form.BRID")>
						<cfset Variables.BRID = #form.BRID#>
					</cfif>
				</cfif>

				<cfif IsDefined("Session.Return_Structure")>
					<cfinclude template="#RootDir#includes/getStructure.cfm">
				<cfelseif IsDefined("Form.BRID") AND Form.BRID NEQ "">
					<cfquery name="GetBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
						SELECT	Bookings.StartDate, Bookings.EndDate, Bookings.BRID, Jetties.NorthJetty, Jetties.SouthJetty
						FROM	Bookings, Jetties
						WHERE	Bookings.BRID = Jetties.BRID
						AND		Deleted = '0'
						AND		Status = 'M'
						AND		Bookings.BRID = '#Form.BRID#'
					</cfquery>

					<cfset Variables.StartDate = getBooking.StartDate>
					<cfset Variables.EndDate = getBooking.EndDate>
					<cfset Variables.NorthJetty = getBooking.NorthJetty>
					<cfset Variables.SouthJetty = getBooking.SouthJetty>
					<cfset Variables.BRID = getBooking.BRID>
				<cfelse>
					<cflocation addtoken="no" url="jettyBookingManage.cfm?lang=#lang#">
				</cfif>

				<cfif Variables.NorthJetty EQ 1>
					<cfset Variables.NorthJetty = true>
				<cfelse>
					<cfset Variables.NorthJetty = false>
				</cfif>
				<cfif Variables.SouthJetty EQ 1>
					<cfset Variables.SouthJetty = true>
				<cfelse>
					<cfset Variables.SouthJetty = false>
				</cfif>

				<cfif IsDefined("Session.form_Structure")>
					<cfinclude template="#RootDir#includes/restore_params.cfm">
					<cfif isDefined("form.StartDate")>
						<cfset Variables.StartDate = #form.startDate#>
						<cfset Variables.EndDate = #form.endDate#>
						<cfif isDefined("form.NorthJetty")>
							<cfset Variables.NorthJetty = true>
						<cfelse>
							<cfset Variables.NorthJetty = false>
						</cfif>
						<cfif isDefined("form.SouthJetty")>
							<cfset Variables.SouthJetty = true>
						<cfelse>
							<cfset Variables.SouthJetty = false>
						</cfif>
					</cfif>
				</cfif>
				<!--- -------------------------------------------------------------------------------------------- --->
				<cfform id="EditJettyMaintBlock" action="editJettyMaintBlock_process.cfm?#urltoken#" method="post">
				<cfoutput><input type="hidden" name="BRID" value="#Variables.BRID#" />
				<table style="width:100%;">
				<tr>
					<td id="Start">Start Date:</td>
					<td headers="Start">
						<cfoutput><cfinput type="text" name="startDate" message="Please enter a start date." validate="date" required="yes" class="startDate" value="#DateFormat(startDate, 'mm/dd/yyyy')#" size="15" maxlength="10" /> #language.dateform#</cfoutput>
						<img src="#RootDir#images/calendar.gif" alt="Calendar" class="calendar" width="25px" height="17px" />
					</td>
				</tr>
				<tr>
					<td id="End">End Date:</td>
					<td headers="End">
						<cfoutput><cfinput type="text" name="endDate" message="Please enter an end date." validate="date" required="yes" class="endDate" value="#DateFormat(endDate, 'mm/dd/yyyy')#" size="15" maxlength="10" /> #language.dateform#</cfoutput>
						<img src="#RootDir#images/calendar.gif" alt="Calendar" class="calendar" width="25px" height="17px" />
					</td>
				</tr>
				<tr><td colspan="2">Please select the jetty/jetties that you wish to book for maintenance:</td></tr>
				<tr>
					<td id="nj"><label for="NorthJetty">North Landing Wharf</label></td>
					<td headers="nj"><cfinput type="checkbox" id="NorthJetty" name="NorthJetty" checked="#Variables.NorthJetty#" /></td></tr>
				<tr>
					<td id="sj"><label for="SouthJetty">South Jetty</label></td>
					<td headers="sj"><cfinput type="checkbox" id="SouthJetty" name="SouthJetty" checked="#Variables.SouthJetty#" /></td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" class="textbutton" value="submit" />
						<input type="button" value="Cancel" onclick="self.location.href='jettyBookingManage.cfm?#urltoken#'" class="textbutton" />
					</td>
				</tr>
				</table>
				</cfform>


			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
