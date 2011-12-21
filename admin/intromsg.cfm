<cfhtmlhead text="
<meta name=""dc.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Administrative Functions"" />
<meta name=""keywords"" content="""" />
<meta name=""description"" content="""" />
<meta name=""dc.date.published"" content=""2005-07-25"" />
<meta name=""dc.date.published"" content=""2005-07-25"" />
<meta name=""dc.date.reviewed"" content=""2005-07-25"" />

<title>PWGSC - ESQUIMALT GRAVING DOCK - Administrative Functions</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<!---clear form structure--->
<cfif IsDefined("Session.Form_Structure")>
	<cfset StructDelete(Session, "Form_Structure")>
</cfif>

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm"> &gt; 
			Administrative Functions
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
						<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
						Administrative Functions
						<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
						</a></h1>

				<cfform action="intromsgaction.cfm" method="post">
				  <cffile action="read" file="#FileDir#intromsg.txt" variable="intromsg">
				  <cfif #Trim(intromsg)# EQ "">
					Please enter a message for users when they first log in. To disable this block on log in, keep the text field blank and click 'Update'
					<cfelse>
					Please update the message for users when they first log in. To disable this block on log in, keep the text field blank and click 'Update'
				  </cfif>
				  <br />
				  <br />
				  <TEXTAREA name="datatowrite" cols="40" rows="5"><cfif #intromsg# is not ""><cfoutput>#intromsg#</cfoutput></cfif>
				</TEXTAREA>
				  <br />
				  <input id="submit" type="submit" value="Update" />
				</cfform>
			</div>	
			<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">

