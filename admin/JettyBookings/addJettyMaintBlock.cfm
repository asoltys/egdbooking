<cfoutput>

<!---cfinclude template="#RootDir#includes/restore_params.cfm">
<cfinclude template="#RootDir#includes/build_form_struct.cfm"--->

<cfsavecontent variable="js">
	
<meta name=""dcterms.title" content="PWGSC - ESQUIMALT GRAVING DOCK - Add Maintenance Block">
<meta name="keywords" content="" />
<meta name="description" content="" />
<meta name="dcterms.description" content="" />
<meta name="dc.date.published" content="2005-07-25" />
<meta name="dc.date.published" content="2005-07-25" />
<meta name="dc.date.reviewed" content="2005-07-25" />
<meta name="dc.date.modified" content="2005-07-25" />
<meta name="dc.date.created" content="2005-07-25" />
<title>PWGSC - ESQUIMALT GRAVING DOCK - Add Maintenance Block</title>
	<script type="text/javascript">
		/* <![CDATA[ */
		var bookingLength = 0;
		/* ]]> */
	</script>
	<script type="text/javascript" src="#RootDir#scripts/tandemDateFixer.js"></script>
	
</cfsavecontent>
<cfhtmlhead text="#js#">

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
			
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</a> &gt;
			<CFELSE>
				 <a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			<a href="jettyBookingManage.cfm?lang=#lang#">Jetty Management</a> &gt;
			Add Maintenance Block
			
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1 id="wb-cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Add Maintenance Block
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

				<!--- -------------------------------------------------------------------------------------------- --->
				<cfparam name="Variables.BRID" default="">
				<cfparam name="Variables.SouthJetty" default="false">
				<cfparam name="Variables.NorthJetty" default="false">
				<cfparam name="Variables.StartDate" default="#DateAdd('d', 1, PacificNow)#">
				<cfparam name="Variables.EndDate" default="#DateAdd('d', 1, PacificNow)#">

				<cfif IsDefined("Session.Return_Structure")>
					<cfinclude template="#RootDir#includes/getStructure.cfm">
					<cfif Variables.SouthJetty EQ 1>
						<cfset Variables.SouthJetty = true>
					<cfelse>
						<cfset Variables.SouthJetty = false>
					</cfif>
					<cfif Variables.NorthJetty EQ 1>
						<cfset Variables.NorthJetty = true>
					<cfelse>
						<cfset Variables.NorthJetty = false>
					</cfif>
				<!---cfelseif IsDefined("Session.Form_Structure")>
					<cfif isDefined("form.SouthJetty")>
						<cfset Variables.SouthJetty = true>
					<cfelse>
						<cfset Variables.SouthJetty = false>
					</cfif>
					<cfif isDefined("form.NorthhJetty")>
						<cfset Variables.NorthJetty = true>
					<cfelse>
						<cfset Variables.NorthJetty = false>
					</cfif--->
				</cfif>
				<cfif NOT IsDefined("Session.form_Structure")>
					<cfinclude template="#RootDir#includes/build_form_struct.cfm">
					<cfinclude template="#RootDir#includes/restore_params.cfm">
				<cfelse>
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
				<cfform id="AddJettyMaintBlock" action="addJettyMaintBlock_process.cfm?#urltoken#" method="post">
				<input type="hidden" name="BRID" value="#Variables.BRID#" />
				<table style="width:100%;">
        <tr>
          <td id="Start"><label for="startDate">Start Date:<br /><small>#language.dateform#</small></label></td>
          <td headers="Start">
            <input type="text" id="startDate" name="startDate" class="datepicker startDate" value="#DateFormat(Variables.startDate, 'mm/dd/yyyy')#" size="15" maxlength="10" /> 
          </td>
        </tr>
        <tr>
          <td id="End"><label for="endDate">End Date:<br /><small>#language.dateform#</small></label></td>
          <td headers="End">
            <input type="text" id="endDate" name="endDate" class="datepicker endDate" value="#DateFormat(Variables.endDate, 'mm/dd/yyyy')#" size="15" maxlength="10" />
          </td>
        </tr>
				<tr>
					<td colspan="2">Please select the jetty/jetties that you wish to book for maintenance:</td>
				</tr>
				<tr>
					<td id="nj">&nbsp;&nbsp;&nbsp;<label for="northJetty">North Landing Wharf</label></td>
					<td headers="nj"><cfinput type="checkbox" name="NorthJetty" id="northJetty" checked="#Variables.NorthJetty#" /></td>
				</tr>
				<tr>
					<td id="sj">&nbsp;&nbsp;&nbsp;<label for="southJetty">South Jetty</label></td>
					<td headers="sj"><cfinput type="checkbox" name="SouthJetty" id="southJetty" checked="#Variables.SouthJetty#" /></td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="submit" class="textbutton" />
						<input type="button" value="Cancel" class="textbutton" onclick="self.location.href='jettyBookingManage.cfm?#urltoken#';" />
					</td>
				</tr>
				</table>
				</cfform>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">

</cfoutput>
