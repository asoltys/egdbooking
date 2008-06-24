<cfhtmlhead text="
	<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Update Tariff Charges"">
	<meta name=""keywords"" lang=""eng"" content="""">
	<meta name=""description"" lang=""eng"" content="""">
	<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
	<meta name=""dc.date.published"" content=""2005-07-25"">
	<meta name=""dc.date.reviewed"" content=""2005-07-25"">
	<meta name=""dc.date.modified"" content=""2005-07-25"">
	<meta name=""dc.date.created"" content=""2005-07-25"">
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Update Tariff Charges</title>">

<cfquery name="getFees" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	item, serviceE AS service, fee, abbreviation, flex
	FROM	TariffFees
	ORDER BY sequence
</cfquery>

<cfoutput query="getFees">
	<cfset variables.feeName = "variables." & #abbreviation# & "Fee">
	<cfset variables.flexName = "variables." & #abbreviation# & "Flex">
	<cfset "#variables.feeName#" = fee>
	<cfset "#variables.flexName#" = flex>
</cfoutput>

<!-- Start JavaScript Block -->
<script language="JavaScript" type="text/javascript">
	<!--
	function EditSubmit ( selectedform )
	{
	  document.forms[selectedform].submit() ;
	}
	//-->
</script>
<!-- End JavaScript Block -->

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<CFOUTPUT>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<A href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</A> &gt; 
			<CFELSE>
				 <a href="#RootDir#reserve-book/booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			Update Tariff Charges
			</CFOUTPUT>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Update Tariff Charges
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm"><br>
				
				<cfif IsDefined("Session.Return_Structure")>
					<!--- Populate the Variables Structure with the Return Structure.
							Also display any errors returned --->
					<cfinclude template="#RootDir#includes/getStructure.cfm">
				</cfif>
				
				<cfform name="updateFees" action="updateFees_action.cfm?lang=#lang#">
				<table border="0" cellpadding="3" cellspacing="0" summary="This table displays the available services and their current fees, and allows the administrator to edit the fees.">
					<tr>
						<!---th id="checkHeader" class="feesformheader" width="5%">&nbsp;</th--->
						<th id="itemHeader"  width="4%"><strong>Item</strong></th>
						<th id="serviceHeader"><strong>Services and Facilities</strong></th>
						<th id="feeHeader" width="19%"><strong>Fees</strong></th>
					</tr>
					
					<cfoutput query="getFees">
						<cfif item NEQ "" AND item mod 2>
							<cfset rowClass = "highlight">
						<cfelseif item NEQ "">
							<cfset rowClass = "">
						</cfif>
						
						<cfset variables.feeName = "variables." & #abbreviation# & "Fee">
						<cfset variables.flexName = "variables." & #abbreviation# & "Flex">
				
						<tr class="#rowClass#">
							<td id="itemHeader" align="center" valign="top"><strong><label for="#abbreviation#">#item#</label></strong></td>
							<td id="serviceHeader" align="left" valign="top"><label for="#abbreviation#">#service#</label></td>
							<td id="feeHeader" align="right" valign="top">
								<cfif fee NEQ "">
									<cfif EVALUATE(variables.flexName) EQ 0>
										<cfset variables.value = EVALUATE(variables.feeName)>
										<cfset variables.checked = "false">
									<cfelse>
										<cfset variables.value = "">
										<cfset variables.checked = "true">
									</cfif>
									$<cfinput name="#abbreviation#Fee" type="text" value="#variables.value#" size="9" id="#abbreviation#" CLASS="textField">
									<br><cfinput type="Checkbox" name="#abbreviation#Flex" id="#abbreviation#Flex" checked="#variables.checked#"><label for="#abbreviation#Flex">prices vary</label>
								</cfif>				
							</td>
						</tr>
					</cfoutput>
				</table>
				
				<br />
				<div align="right">
					<!--a href="javascript:EditSubmit('serviceSelect');" class="textbutton">Submit</a-->
					<input type="submit" name="submitForm" class="textbutton" value="submit">
					<cfoutput><input type="button" value="Cancel" onClick="self.location.href='otherForms.cfm?lang=#lang#'" class="textbutton"></cfoutput>
				</div>
				</cfform>
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
