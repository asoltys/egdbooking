<cfset Variables.Errors = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<cfif (NOT isNumeric(#Form.BookFeeFee#) AND #trim(Form.BookFeeFee)# NEQ "")
 OR (NOT isNumeric(#Form.FullDrainFee#) AND #trim(Form.FullDrainFee)# NEQ "")
 OR (NOT isNumeric(#Form.VesselDockageFee#) AND #trim(Form.VesselDockageFee)# NEQ "")
 OR (NOT isNumeric(#Form.CargoDockageFee#) AND #trim(Form.CargoDockageFee)# NEQ "")
 OR (NOT isNumeric(#Form.WorkVesselBerthNorthFee#) AND #trim(Form.WorkVesselBerthNorthFee)# NEQ "")
 OR (NOT isNumeric(#Form.NonworkVesselBerthNorthFee#) AND #trim(Form.NonworkVesselBerthNorthFee)# NEQ "")
 OR (NOT isNumeric(#Form.VesselBerthSouthFee#) AND #trim(Form.VesselBerthSouthFee)# NEQ "")
 OR (NOT isNumeric(#Form.CargoStoreFee#) AND #trim(Form.CargoStoreFee)# NEQ "")
 OR (NOT isNumeric(#Form.TopWharfageFee#) AND #trim(Form.TopWharfageFee)# NEQ "")
 OR (NOT isNumeric(#Form.CraneLightHookFee#) AND #trim(Form.CraneLightHookFee)# NEQ "")
 OR (NOT isNumeric(#Form.CraneMedHookFee#) AND #trim(Form.CraneMedHookFee)# NEQ "")
 OR (NOT isNumeric(#Form.CraneBigHookFee#) AND #trim(Form.CraneBigHookFee)# NEQ "")
 OR (NOT isNumeric(#Form.CraneHysterFee#) AND #trim(Form.CraneHysterFee)# NEQ "")
 OR (NOT isNumeric(#Form.CraneGroveFee#) AND #trim(Form.CraneGroveFee)# NEQ "")
 OR (NOT isNumeric(#Form.ForkliftFee#) AND #trim(Form.ForkliftFee)# NEQ "")
 OR (NOT isNumeric(#Form.CompressPrimaryFee#) AND #trim(Form.CompressPrimaryFee)# NEQ "")
 OR (NOT isNumeric(#Form.CompressSecondaryFee#) AND #trim(Form.CompressSecondaryFee)# NEQ "")
 OR (NOT isNumeric(#Form.CompressPortableFee#) AND #trim(Form.CompressPortableFee)# NEQ "")
 OR (NOT isNumeric(#Form.TugFee#) AND #trim(Form.TugFee)# NEQ "")
 OR (NOT isNumeric(#Form.FreshH2OFee#) AND #trim(Form.FreshH2OFee)# NEQ "")
 OR (NOT isNumeric(#Form.ElectricFee#) AND #trim(Form.ElectricFee)# NEQ "")
 OR (NOT isNumeric(#Form.TieUpFee#) AND #trim(Form.TieUpFee)# NEQ "")
 OR (NOT isNumeric(#Form.CommissionaireFee#) AND #trim(Form.CommissionaireFee)# NEQ "")
 OR (NOT isNumeric(#Form.OvertimeLabourFee#) AND #trim(Form.OvertimeLabourFee)# NEQ "")
 OR (NOT isNumeric(#Form.LightsStandardFee#) AND #trim(Form.LightsStandardFee)# NEQ "")
 OR (NOT isNumeric(#Form.LightsCaissonFee#) AND #trim(Form.LightsCaissonFee)# NEQ "")>
	<cfoutput>#ArrayAppend(Variables.Errors, "Fees cannot be set to non-numeric values.")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif (NOT isDefined("Form.BookFeeFlex") AND #trim(Form.BookFeeFee)# EQ "")
 OR (NOT isDefined("Form.FullDrainFlex") AND #trim(Form.FullDrainFee)# EQ "")
 OR (NOT isDefined("Form.VesselDockageFlex") AND #trim(Form.VesselDockageFee)# EQ "")
 OR (NOT isDefined("Form.CargoDockageFlex") AND #trim(Form.CargoDockageFee)# EQ "")
 OR (NOT isDefined("Form.WorkVesselBerthNorthFlex") AND #trim(Form.WorkVesselBerthNorthFee)# EQ "")
 OR (NOT isDefined("Form.NonworkVesselBerthNorthFlex") AND #trim(Form.NonworkVesselBerthNorthFee)# EQ "")
 OR (NOT isDefined("Form.VesselBerthSouthFlex") AND #trim(Form.VesselBerthSouthFee)# EQ "")
 OR (NOT isDefined("Form.CargoStoreFlex") AND #trim(Form.CargoStoreFee)# EQ "")
 OR (NOT isDefined("Form.TopWharfageFlex") AND #trim(Form.TopWharfageFee)# EQ "")
 OR (NOT isDefined("Form.CraneLightHookFlex") AND #trim(Form.CraneLightHookFee)# EQ "")
 OR (NOT isDefined("Form.CraneMedHookFlex") AND #trim(Form.CraneMedHookFee)# EQ "")
 OR (NOT isDefined("Form.CraneBigHookFlex") AND #trim(Form.CraneBigHookFee)# EQ "")
 OR (NOT isDefined("Form.CraneHysterFlex") AND #trim(Form.CraneHysterFee)# EQ "")
 OR (NOT isDefined("Form.CraneGroveFlex") AND #trim(Form.CraneGroveFee)# EQ "")
 OR (NOT isDefined("Form.ForkliftFlex") AND #trim(Form.ForkliftFee)# EQ "")
 OR (NOT isDefined("Form.CompressPrimaryFlex") AND #trim(Form.CompressPrimaryFee)# EQ "")
 OR (NOT isDefined("Form.CompressSecondaryFlex") AND #trim(Form.CompressSecondaryFee)# EQ "")
 OR (NOT isDefined("Form.CompressPortableFlex") AND #trim(Form.CompressPortableFee)# EQ "")
 OR (NOT isDefined("Form.TugFlex") AND #trim(Form.TugFee)# EQ "")
 OR (NOT isDefined("Form.FreshH2OFlex") AND #trim(Form.FreshH2OFee)# EQ "")
 OR (NOT isDefined("Form.ElectricFlex") AND #trim(Form.ElectricFee)# EQ "")
 OR (NOT isDefined("Form.TieUpFlex") AND #trim(Form.TieUpFee)# EQ "")
 OR (NOT isDefined("Form.CommissionaireFlex") AND #trim(Form.CommissionaireFee)# EQ "")
 OR (NOT isDefined("Form.OvertimeLabourFlex") AND #trim(Form.OvertimeLabourFee)# EQ "")
 OR (NOT isDefined("Form.LightsStandardFlex") AND #trim(Form.LightsStandardFee)# EQ "")
 OR (NOT isDefined("Form.LightsCaissonFlex") AND #trim(Form.LightsCaissonFee)# EQ "")>
	<cfoutput>#ArrayAppend(Variables.Errors, "If a price is fixed, a fee must be specified.")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif Proceed_OK EQ "No">
	<cfinclude template="#RootDir#includes/build_return_struct.cfm">
	<cfset Session.Return_Structure.Errors = Variables.Errors>
	<cflocation url="updateFees.cfm?lang=#lang#" addtoken="no">
</cfif>


<cftransaction>
	<cfquery name="updateBookFee" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	TariffFees
		SET		<cfif isDefined("Form.BookFeeFlex") AND Form.BookFeeFlex EQ "on">
					Fee = 'prices vary', 
					Flex = 1
				<cfelse>
					Fee = <cfqueryparam value="#Form.BookFeeFee#" cfsqltype="cf_sql_varchar" />, 
					Flex = 0
				</cfif>
		WHERE	Abbreviation = 'BookFee'
	</cfquery>
	<cfquery name="updateFullDrainFee" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	TariffFees
		SET		<cfif isDefined("Form.FullDrainFlex") AND Form.FullDrainFlex EQ "on">
					Fee = 'prices vary', 
					Flex = 1
				<cfelse>
					Fee = <cfqueryparam value="#Form.FullDrainFee#" cfsqltype="cf_sql_varchar" />, 
					Flex = 0
				</cfif>
		WHERE	Abbreviation = 'FullDrainFee'
	</cfquery>
	<cfquery name="updateVesselDockageFee" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	TariffFees
		SET		<cfif isDefined("Form.VesselDockageFlex") AND Form.VesselDockageFlex EQ "on">
					Fee = 'prices vary', 
					Flex = 1
				<cfelse>
					Fee = <cfqueryparam value="#Form.VesselDockageFee#" cfsqltype="cf_sql_varchar" />, 
					Flex = 0
				</cfif>
		WHERE	Abbreviation = 'VesselDockage'
	</cfquery>
	<cfquery name="updateCargoDockageFee" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	TariffFees
		SET		<cfif isDefined("Form.CargoDockageFlex") AND Form.CargoDockageFlex EQ "on">
					Fee = 'prices vary', 
					Flex = 1
				<cfelse>
					Fee = <cfqueryparam value="#Form.CargoDockageFee#" cfsqltype="cf_sql_varchar" />, 
					Flex = 0
				</cfif>
		WHERE	Abbreviation = 'CargoDockage'
	</cfquery>
	<cfquery name="updateWorkVesselBerthNorthFee" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	TariffFees
		SET		<cfif isDefined("Form.WorkVesselBerthNorthFlex") AND Form.WorkVesselBerthNorthFlex EQ "on">
					Fee = 'prices vary', 
					Flex = 1
				<cfelse>
					Fee = <cfqueryparam value="#Form.WorkVesselBerthNorthFee#" cfsqltype="cf_sql_varchar" />, 
					Flex = 0
				</cfif>
		WHERE	Abbreviation = 'WorkVesselBerthNorth'
	</cfquery>
	<cfquery name="updateNonworkVesselBerthNorthFee" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	TariffFees
		SET		<cfif isDefined("Form.NonworkVesselBerthNorthFlex") AND Form.NonworkVesselBerthNorthFlex EQ "on">
					Fee = 'prices vary', 
					Flex = 1
				<cfelse>
					Fee = <cfqueryparam value="#Form.NonworkVesselBerthNorthFee#" cfsqltype="cf_sql_varchar" />, 
					Flex = 0
				</cfif>
		WHERE	Abbreviation = 'NonworkVesselBerthNorth'
	</cfquery>
	<cfquery name="updateVesselBerthSouthFee" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	TariffFees
		SET		<cfif isDefined("Form.VesselBerthSouthFlex") AND Form.VesselBerthSouthFlex EQ "on">
					Fee = 'prices vary', 
					Flex = 1
				<cfelse>
					Fee = <cfqueryparam value="#Form.VesselBerthSouthFee#" cfsqltype="cf_sql_varchar" />, 
					Flex = 0
				</cfif>
		WHERE	Abbreviation = 'VesselBerthSouth'
	</cfquery>
	<cfquery name="updateCargoStoreFee" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	TariffFees
		SET		<cfif isDefined("Form.CargoStoreFlex") AND Form.CargoStoreFlex EQ "on">
					Fee = 'prices vary', 
					Flex = 1
				<cfelse>
					Fee = <cfqueryparam value="#Form.CargoStoreFee#" cfsqltype="cf_sql_varchar" />, 
					Flex = 0
				</cfif>
		WHERE	Abbreviation = 'CargoStore'
	</cfquery>
	<cfquery name="updateTopWharfageFee" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	TariffFees
		SET		<cfif isDefined("Form.TopWharfageFlex") AND Form.TopWharfageFlex EQ "on">
					Fee = 'prices vary', 
					Flex = 1
				<cfelse>
					Fee = <cfqueryparam value="#Form.TopWharfageFee#" cfsqltype="cf_sql_varchar" />, 
					Flex = 0
				</cfif>
		WHERE	Abbreviation = 'TopWharfage'
	</cfquery>
	<cfquery name="updateCraneLightHookFee" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	TariffFees
		SET		<cfif isDefined("Form.CraneLightHookFlex") AND Form.CraneLightHookFlex EQ "on">
					Fee = 'prices vary', 
					Flex = 1
				<cfelse>
					Fee = <cfqueryparam value="#Form.CraneLightHookFee#" cfsqltype="cf_sql_varchar" />, 
					Flex = 0
				</cfif>
		WHERE	Abbreviation = 'CraneLightHook'
	</cfquery>
	<cfquery name="updateCraneMedHookFee" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	TariffFees
		SET		<cfif isDefined("Form.CraneMedHookFlex") AND Form.CraneMedHookFlex EQ "on">
					Fee = 'prices vary', 
					Flex = 1
				<cfelse>
					Fee = <cfqueryparam value="#Form.CraneMedHookFee#" cfsqltype="cf_sql_varchar" />, 
					Flex = 0
				</cfif>
		WHERE	Abbreviation = 'CraneMedHook'
	</cfquery>
	<cfquery name="updateCraneBigHookFee" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	TariffFees
		SET		<cfif isDefined("Form.CraneBigHookFlex") AND Form.CraneBigHookFlex EQ "on">
					Fee = 'prices vary', 
					Flex = 1
				<cfelse>
					Fee = <cfqueryparam value="#Form.CraneBigHookFee#" cfsqltype="cf_sql_varchar" />, 
					Flex = 0
				</cfif>
		WHERE	Abbreviation = 'CraneBigHook'
	</cfquery>
	<cfquery name="updateCraneHysterFee" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	TariffFees
		SET		<cfif isDefined("Form.CraneHysterFlex") AND Form.CraneHysterFlex EQ "on">
					Fee = 'prices vary', 
					Flex = 1
				<cfelse>
					Fee = <cfqueryparam value="#Form.CraneHysterFee#" cfsqltype="cf_sql_varchar" />, 
					Flex = 0
				</cfif>
		WHERE	Abbreviation = 'CraneHyster'
	</cfquery>
	<cfquery name="updateCraneGroveFee" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	TariffFees
		SET		<cfif isDefined("Form.CraneGroveFlex") AND Form.CraneGroveFlex EQ "on">
					Fee = 'prices vary', 
					Flex = 1
				<cfelse>
					Fee = <cfqueryparam value="#Form.CraneGroveFee#" cfsqltype="cf_sql_varchar" />, 
					Flex = 0
				</cfif>
		WHERE	Abbreviation = 'CraneGrove'
	</cfquery>
	<cfquery name="updateForkliftFee" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	TariffFees
		SET		<cfif isDefined("Form.ForkliftFlex") AND Form.ForkliftFlex EQ "on">
					Fee = 'prices vary', 
					Flex = 1
				<cfelse>
					Fee = <cfqueryparam value="#Form.ForkliftFee#" cfsqltype="cf_sql_varchar" />, 
					Flex = 0
				</cfif>
		WHERE	Abbreviation = 'Forklift'
	</cfquery>
	<cfquery name="updateCompressPrimaryFee" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	TariffFees
		SET		<cfif isDefined("Form.CompressPrimaryFlex") AND Form.CompressPrimaryFlex EQ "on">
					Fee = 'prices vary', 
					Flex = 1
				<cfelse>
					Fee = <cfqueryparam value="#Form.CompressPrimaryFee#" cfsqltype="cf_sql_varchar" />, 
					Flex = 0
				</cfif>
		WHERE	Abbreviation = 'CompressPrimary'
	</cfquery>
	<cfquery name="updateCompressSecondaryFee" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	TariffFees
		SET		<cfif isDefined("Form.CompressSecondaryFlex") AND Form.CompressSecondaryFlex EQ "on">
					Fee = 'prices vary', 
					Flex = 1
				<cfelse>
					Fee = <cfqueryparam value="#Form.CompressSecondaryFee#" cfsqltype="cf_sql_varchar" />, 
					Flex = 0
				</cfif>
		WHERE	Abbreviation = 'CompressSecondary'
	</cfquery>
	<cfquery name="updateCompressPortableFee" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	TariffFees
		SET		<cfif isDefined("Form.CompressPortableFlex") AND Form.CompressPortableFlex EQ "on">
					Fee = 'prices vary', 
					Flex = 1
				<cfelse>
					Fee = <cfqueryparam value="#Form.CompressPortableFee#" cfsqltype="cf_sql_varchar" />, 
					Flex = 0
				</cfif>
		WHERE	Abbreviation = 'CompressPortable'
	</cfquery>
	<cfquery name="updateTugFee" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	TariffFees
		SET		<cfif isDefined("Form.TugFlex") AND Form.TugFlex EQ "on">
					Fee = 'prices vary', 
					Flex = 1
				<cfelse>
					Fee = <cfqueryparam value="#Form.TugFee#" cfsqltype="cf_sql_varchar" />, 
					Flex = 0
				</cfif>
		WHERE	Abbreviation = 'Tug'
	</cfquery>
	<cfquery name="updateFreshH2OFee" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	TariffFees
		SET		<cfif isDefined("Form.FreshH2OFlex") AND Form.FreshH2OFlex EQ "on">
					Fee = 'prices vary', 
					Flex = 1
				<cfelse>
					Fee = <cfqueryparam value="#Form.FreshH2OFee#" cfsqltype="cf_sql_varchar" />, 
					Flex = 0
				</cfif>
		WHERE	Abbreviation = 'FreshH2O'
	</cfquery>
	<cfquery name="updateElectricFee" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	TariffFees
		SET		<cfif isDefined("Form.ElectricFlex") AND Form.ElectricFlex EQ "on">
					Fee = 'prices vary', 
					Flex = 1
				<cfelse>
					Fee = <cfqueryparam value="#Form.ElectricFee#" cfsqltype="cf_sql_varchar" />, 
					Flex = 0
				</cfif>
		WHERE	Abbreviation = 'Electric'
	</cfquery> = "#Form.#",
	<cfquery name="updateTieUpFee" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	TariffFees
		SET		<cfif isDefined("Form.TieUpFlex") AND Form.TieUpFlex EQ "on">
					Fee = 'prices vary', 
					Flex = 1
				<cfelse>
					Fee = <cfqueryparam value="#Form.TieUpFee#" cfsqltype="cf_sql_varchar" />, 
					Flex = 0
				</cfif>
		WHERE	Abbreviation = 'TieUp'
	</cfquery>
	<cfquery name="updateCommissionaireFee" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	TariffFees
		SET		<cfif isDefined("Form.CommissionaireFlex") AND Form.CommissionaireFlex EQ "on">
					Fee = 'prices vary', 
					Flex = 1
				<cfelse>
					Fee = <cfqueryparam value="#Form.CommissionaireFee#" cfsqltype="cf_sql_varchar" />, 
					Flex = 0
				</cfif>
		WHERE	Abbreviation = 'Commissionaire'
	</cfquery>
	<cfquery name="updateOvertimeLabourFee" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	TariffFees
		SET		<cfif isDefined("Form.OvertimeLabourFlex") AND Form.OvertimeLabourFlex EQ "on">
					Fee = 'prices vary', 
					Flex = 1
				<cfelse>
					Fee = <cfqueryparam value="#Form.OvertimeLabourFee#" cfsqltype="cf_sql_varchar" />, 
					Flex = 0
				</cfif>
		WHERE	Abbreviation = 'OvertimeLabour'
	</cfquery>
	<cfquery name="updateLightsStandardFee" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	TariffFees
		SET		<cfif isDefined("Form.LightsStandardFlex") AND Form.LightsStandardFlex EQ "on">
					Fee = 'prices vary', 
					Flex = 1
				<cfelse>
					Fee = <cfqueryparam value="#Form.LightsStandardFee#" cfsqltype="cf_sql_varchar" />, 
					Flex = 0
				</cfif>
		WHERE	Abbreviation = 'LightsStandard'
	</cfquery>
	<cfquery name="updateLightsCaissonFee" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	TariffFees
		SET		<cfif isDefined("Form.LightsCaissonFlex") AND Form.LightsCaissonFlex EQ "on">
					Fee = 'prices vary', 
					Flex = 1
				<cfelse>
					Fee = <cfqueryparam value="#Form.LightsCaissonFee#" cfsqltype="cf_sql_varchar" />, 
					Flex = 0
				</cfif>
		WHERE	Abbreviation = 'LightsCaisson'
	</cfquery>
</cftransaction>


<cfset Session.Success.Breadcrumb = "Update Tariff Charges">
<cfset Session.Success.Title = "Update Tariff Charges">
<cfset Session.Success.Message = "Tariff Form has been updated.">
<cfset Session.Success.Back = "Back to Dock Booking Forms">
<cfset Session.Success.Link = "#RootDir#admin/otherForms.cfm?lang=#lang#">
<cflocation addtoken="no" url="#RootDir#comm/succes.cfm?lang=#lang#">
