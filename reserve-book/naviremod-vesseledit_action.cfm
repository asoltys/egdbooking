<cfif IsDefined('form.anonymous')>
	<cfset Form.Anonymous = 1 />
<cfelse>
	<cfset Form.Anonymous = 0  />
</cfif>

<cfif isDefined('form.VNID')>

	<cfquery name="editVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE Vessels
		SET
			name = '#trim(form.name)#',
			length = '#trim(form.length)#',
			width = '#trim(form.width)#',
			blocksetuptime = '#trim(form.blocksetuptime)#',
			blockteardowntime = '#trim(form.blockteardowntime)#',
			LloydsID = '#trim(form.LloydsID)#',
			Tonnage = '#trim(form.tonnage)#',
			Anonymous = '#(Form.Anonymous)#'
		WHERE VNID = #form.VNID#
		AND deleted = 0
	</cfquery>


	<cflock scope="session" throwontimeout="no" timeout="30" type="READONLY">
		<cfquery name="getUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			SELECT	firstname + ' ' + lastname AS UserName, Email
			FROM	Users
			WHERE	UID = #session.UID#
		</cfquery>
	</cflock>

	<cfquery name="getVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	vessels.name AS VesselName, companies.name AS CompanyName
		FROM	Vessels INNER JOIN Companies ON Vessels.CID = Companies.CID
		WHERE	VNID = #form.VNID#
	</cfquery>

	<cfoutput>
		<cfmail to="#Variables.AdminEmail#" from="#getUser.email#" subject="Vessel Edited" type="html">
	<p>#getUser.userName# of #getVessel.companyName# has edited the details for #getVessel.VesselName#.  Please check that the new vessel information is correct.</p>
		</cfmail>
	</cfoutput>

</cfif>

<!--- Clear Form Structure --->
<cfset StructDelete(Session, "Form_Structure")>
<cflocation addtoken="no" url="#RootDir#reserve-book/detail-navire-vessel.cfm?lang=#lang#&VNID=#form.VNID#&CID=#url.CID#">
