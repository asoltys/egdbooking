<cfcomponent output="yes">
	<cfset Variables.TowerArray = ArrayNew(1)>
	<cfset Variables.MaintArray = ArrayNew(1)>
	
	<cfset Variables.Orderable = true>
	<cfset DockSize.Length.Section1 = 114.96>
	<cfset DockSize.Length.Section3 = 119.07>
	<cfset DockSize.Length.Section12 = 221.64>
	<cfset DockSize.Length.Section23 = 226.36>
	<cfset DockSize.Length.Section123 = 347.67>

	<cfset DockSize.Width.Section1 = 45.40>
	<cfset DockSize.Width.Section3 = 45.40>
	<cfset DockSize.Width.Section12 = 45.40>
	<cfset DockSize.Width.Section23 = 45.40>
	<cfset DockSize.Width.Section123 = 45.40>
	
	<cffunction name="init" access="public" output="no" returntype="tower">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="addBlock" access="public" output="no" returntype="struct">
		<cfargument name="BookingID" type="numeric" required="yes">
		<cfargument name="startDate" type="date" required="yes">
		<cfargument name="endDate" type="date" required="yes">
		<cfargument name="Length" type="numeric" required="yes">
		<cfargument name="Width" type="numeric" required="yes">

		<cfset Variables.BlockStructure = StructNew()>
		<cfset Variables.BlockStructure.BookingID = arguments.BookingID>
		<cfset Variables.BlockStructure.Length = arguments.Length>
		<cfset Variables.BlockStructure.Width = arguments.Width>
		<cfset Variables.BlockStructure.startDate = CreateODBCDate("#arguments.startDate#")>
		<cfset Variables.BlockStructure.endDate = CreateODBCDate("#arguments.endDate#")>
		<cfset Variables.BlockStructure.Row = "">
		<cfset Variables.BlockStructure.Order = "">
		<cfset Variables.BlockStructure.Section1 = "">
		<cfset Variables.BlockStructure.Section2 = "">
		<cfset Variables.BlockStructure.Section3 = "">

		<cfif ArrayLen(Variables.TowerArray) GT 0>
			<cfset position = addBlock_helper(Variables.BlockStructure)>
			<cfif position GT ArrayLen(Variables.TowerArray)>
				<!--- Append to the end of the Array; the latest starting day --->
				<cfscript>
					if (TowerArray[position-1].row EQ 0)
					{
						Variables.BlockStructure.Row = 0;
						Variables.BlockStructure.Order = 0;
						Variables.BlockStructure.Section1 = 0;
						Variables.BlockStructure.Section2 = 0;
						Variables.BlockStructure.Section3 = 0;
						Variables.Orderable = false;
					}
					else if (DateCompare(Variables.BlockStructure.startDate, TowerArray[position-1].endDate, "d") EQ 1 AND ((TowerArray[position-1].row EQ 1) OR (DateCompare(Variables.BlockStructure.endDate,TowerArray[getRowEnd(TowerArray[position-1].row-1)].endDate,"d") EQ -1 OR DateCompare(Variables.BlockStructure.endDate,TowerArray[getRowEnd(TowerArray[position-1].row-1)].endDate,"d") EQ 0)))
					{
						Variables.BlockStructure.Row = Variables.TowerArray[position-1].Row;
						Variables.BlockStructure.Order = Variables.TowerArray[position-1].Order+1;
						Variables.BlockStructure.Section1 = TowerArray[position-1].Section1;
						Variables.BlockStructure.Section2 = TowerArray[position-1].Section2;
						Variables.BlockStructure.Section3 = TowerArray[position-1].Section3;
					}
					else if (DateCompare(Variables.BlockStructure.endDate, TowerArray[position-1].endDate, "d") EQ -1 OR DateCompare(Variables.BlockStructure.endDate, TowerArray[position-1].endDate, "d") EQ 0)
					{
						Variables.BlockStructure.Row = Variables.TowerArray[position-1].Row + 1;
						Variables.BlockStructure.Order = Variables.TowerArray[position-1].Order;
						temp = increment_Section(TowerArray[position-1].Section1, TowerArray[position-1].Section2, TowerArray[position-1].Section3, Variables.BlockStructure.Width, Variables.BlockStructure.Length);
						Variables.BlockStructure.Section1 = temp.Section1;
						Variables.BlockStructure.Section2 = temp.Section2;
						Variables.BlockStructure.Section3 = temp.Section3;
					}
					else
					{
						Variables.BlockStructure.Row = 0;
						Variables.BlockStructure.Order = 0;
						Variables.BlockStructure.Section1 = 0;
						Variables.BlockStructure.Section2 = 0;
						Variables.BlockStructure.Section3 = 0;
						Variables.Orderable = false;
					}

					ArrayAppend(Variables.TowerArray, Variables.BlockStructure);
				</cfscript>
			<cfelse>
				<!--- Insert at position --->
				<cfscript>
					Variables.BlockStructure.Row = Variables.TowerArray[position].Row;
					Variables.BlockStructure.Order = Variables.TowerArray[position].Order;
					for (j = position; j lte ArrayLen(Variables.TowerArray); j=j+1)
					{
						Variables.TowerArray[j].Row = Variables.TowerArray[j].Row + 1; 
					}					
					
					Variables.BlockStructure.Section1 = Variables.TowerArray[position].Section1;
					Variables.BlockStructure.Section2 = Variables.TowerArray[position].Section2;
					Variables.BlockStructure.Section3 = Variables.TowerArray[position].Section3;
					for (j = position; j lte ArrayLen(Variables.TowerArray); j=j+1)
					{
						if (TowerArray[j].row EQ 0)
						{
							Variables.BlockStructure.Row = 0;
							Variables.BlockStructure.Order = 0;
							Variables.BlockStructure.Section1 = 0;
							Variables.BlockStructure.Section2 = 0;
							Variables.BlockStructure.Section3 = 0;
							Variables.Orderable = false;
						}
						else if (DateCompare(TowerArray[j].startDate, Variables.BlockStructure.endDate, "d") EQ 1 AND getRowEnd(Variables.BlockStructure.row-1) NEQ 0 AND ((Variables.BlockStructure.row EQ 1) OR (DateCompare(TowerArray[j].endDate,TowerArray[getRowEnd(Variables.BlockStructure.row-1)].endDate,"d") EQ -1 OR DateCompare(TowerArray[j].endDate,TowerArray[getRowEnd(Variables.BlockStructure.row-1)].endDate,"d") EQ 0)))
						{
							Variables.TowerArray[j].Order = Variables.TowerArray[j].Order + 1;
						}
						else if (DateCompare(TowerArray[j].endDate, Variables.BlockStructure.endDate, "d") EQ -1 OR DateCompare(TowerArray[j].endDate, Variables.BlockStructure.endDate, "d") EQ 0)
						{
							temp = increment_Section(Variables.BlockStructure.Section1, Variables.BlockStructure.Section2, Variables.BlockStructure.Section3, Variables.TowerArray[j].Width, Variables.TowerArray[j].Length);
							Variables.TowerArray[j].Order = 1;
							Variables.TowerArray[j].Section1 = temp.Section1;
							Variables.TowerArray[j].Section2 = temp.Section2;
							Variables.TowerArray[j].Section3 = temp.Section3;
						}
						else
						{
							Variables.BlockStructure.Row = 0;
							Variables.BlockStructure.Order = 0;
							Variables.TowerArray[j].Section1 = 0;
							Variables.TowerArray[j].Section2 = 0;
							Variables.TowerArray[j].Section3 = 0;
							Variables.Orderable = false;
						}
					}
					ArrayInsertAt(Variables.TowerArray, position, Variables.BlockStructure);
				</cfscript>
			</cfif>
		<cfelse>
			<!--- The very first insert --->
			<cfset Variables.BlockStructure.Row = "1">
			<cfset Variables.BlockStructure.Order = "1">
			<cfif Variables.BlockStructure.Length LTE DockSize.Length.Section3>
				<cfset Variables.BlockStructure.Section1 = 0>
				<cfset Variables.BlockStructure.Section2 = 0>
				<cfset Variables.BlockStructure.Section3 = 1>
				<cfscript>ArrayAppend(Variables.TowerArray, Variables.BlockStructure);</cfscript>
			<cfelseif Variables.BlockStructure.Length LTE DockSize.Length.Section23>
				<cfset Variables.BlockStructure.Section1 = 0>
				<cfset Variables.BlockStructure.Section2 = 1>
				<cfset Variables.BlockStructure.Section3 = 1>
				<cfscript>ArrayAppend(Variables.TowerArray, Variables.BlockStructure);</cfscript>
			<cfelseif Variables.BlockStructure.Length LTE DockSize.Length.Section123>
				<cfset Variables.BlockStructure.Section1 = 1>
				<cfset Variables.BlockStructure.Section2 = 1>
				<cfset Variables.BlockStructure.Section3 = 1>
				<cfscript>ArrayAppend(Variables.TowerArray, Variables.BlockStructure);</cfscript>
			<cfelse>
				<!--- Insert the Booking In, but does not work after this --->
				<cfset Variables.BlockStructure.Section1 = 0>
				<cfset Variables.BlockStructure.Section2 = 0>
				<cfset Variables.BlockStructure.Section3 = 0>
				<cfscript>ArrayAppend(Variables.TowerArray, Variables.BlockStructure);</cfscript>
				<cfset Variables.Orderable = false>
			</cfif>
		</cfif>
		<cfscript>CheckMaintenanceBlocks();</cfscript>
		<!---<cfreturn Variables.Orderable>--->
		<cfreturn Variables.BlockStructure>
	</cffunction>
	
	<cffunction name="addBlock_helper" access="private" output="no" returntype="numeric">
		<cfargument name="BlockStructure" type="struct" required="yes">
		<cfset ArrayLength = ArrayLen(Variables.TowerArray)>
		<cfloop index="count" from="1" to="#ArrayLength#" step="1">
			<cfif DateCompare(Arguments.BlockStructure.StartDate, TowerArray[count].startDate, "d") EQ 0 AND DateCompare(Arguments.BlockStructure.EndDate, TowerArray[count].EndDate, "d") EQ 1>
				<cfreturn count>
			<cfelseif DateCompare(Arguments.BlockStructure.StartDate, TowerArray[count].startDate, "d") EQ -1>
				<cfreturn count>
			</cfif>
		</cfloop>
		<cfreturn ArrayLength+1>
	</cffunction>
	
	<cffunction name="increment_section" access="private" output="no" returntype="struct">
		<cfargument name="Section1" type="numeric" required="yes">
		<cfargument name="Section2" type="numeric" required="yes">
		<cfargument name="Section3" type="numeric" required="yes">
		<cfargument name="Width" type="numeric" required="yes">
		<cfargument name="Length" type="numeric" required="yes">
		<cfset ReturnStruct = StructNew()>
		<cfscript>
			if (Arguments.Section1 EQ 0 AND Arguments.Section2 EQ 0 AND Arguments.Section3 EQ 1)
			{
				if (Arguments.Length LTE DockSize.Length.Section12)
				{
					ReturnStruct.Section1 = 1;
					ReturnStruct.Section2 = 1;
					ReturnStruct.Section3 = 0;
				}
				else
				{
					ReturnStruct.Section1 = 0;
					ReturnStruct.Section2 = 0;
					ReturnStruct.Section3 = 0;
					Variables.Orderable = false;
				}
			}
			else if (Arguments.Section1 EQ 0 AND Arguments.Section2 EQ 1 AND Arguments.Section3 EQ 1)
			{
				if (Arguments.Length LTE DockSize.Length.Section1)
				{
					ReturnStruct.Section1 = 1;
					ReturnStruct.Section2 = 0;
					ReturnStruct.Section3 = 0;
				}
				else
				{
					ReturnStruct.Section1 = 0;
					ReturnStruct.Section2 = 0;
					ReturnStruct.Section3 = 0;
					Variables.Orderable = false;
				}
			}
			else
			{
				ReturnStruct.Section1 = 0;
				ReturnStruct.Section2 = 0;
				ReturnStruct.Section3 = 0;
				Variables.Orderable = false;
			}
		</cfscript>
		<cfreturn ReturnStruct>
	</cffunction>
	
	<cffunction name="addMaint" access="public" output="no" returntype="boolean">
		<cfargument name="BookingID" type="numeric" required="yes">
		<cfargument name="startDate" type="date" required="yes">
		<cfargument name="endDate" type="date" required="yes">
		<cfargument name="Section1" type="boolean" required="yes">
		<cfargument name="Section2" type="boolean" required="yes">
		<cfargument name="Section3" type="boolean" required="yes">

		<cfset Variables.BlockStructure = StructNew()>
		<cfset Variables.BlockStructure.BookingID = arguments.BookingID>
		<cfset Variables.BlockStructure.startDate = CreateODBCDate("#arguments.startDate#")>
		<cfset Variables.BlockStructure.endDate = CreateODBCDate("#arguments.endDate#")>
		<cfset Variables.BlockStructure.Section1 = arguments.Section1>
		<cfset Variables.BlockStructure.Section2 = arguments.Section2>
		<cfset Variables.BlockStructure.Section3 = arguments.Section3>

		<cfscript>
			ArrayAppend(Variables.MaintArray, Variables.BlockStructure);
			CheckMaintenanceBlocks();
		</cfscript>
		
		<cfreturn Orderable>
	</cffunction>
	
	<cffunction name="getTower" access="public" output="no" returntype="Array">
		<cfreturn Variables.TowerArray>
	</cffunction>

	<cffunction name="reorderTower" access="public" output="no" returntype="boolean">
		<cfreturn Orderable>
	</cffunction>
	
	<cffunction name="getRowEnd" access="private" returntype="numeric">
		<cfargument name="row" type="numeric" required="yes">
		<cfset tcount = 1>
		<cfset tposition = "0">
		<cfset maxFound = "0">
		<cfloop condition="tcount LTE ArrayLen(Variables.TowerArray)">
			<cfif Variables.TowerArray[tcount].row EQ Arguments.Row AND Variables.TowerArray[tcount].order GT maxFound>
				<cfset maxFound = Variables.TowerArray[tcount].order>
				<cfset tposition = tcount>
			</cfif>
			<cfset tcount = tcount + 1>
		</cfloop>
		<cfreturn tposition>
	</cffunction>
	
	<cffunction name="checkMaintenanceBlocks" access="private" returntype="boolean">
		<cfloop index="k" from="1" to="#ArrayLen(TowerArray)#" step="1">
			<cfloop index="l" from="1" to="#ArrayLen(MaintArray)#" step="1">
				<cfif MaintArray[l].Section1 EQ 1 AND TowerArray[k].Section1 EQ 1 OR MaintArray[l].Section2 EQ 1 AND TowerArray[k].Section2 EQ 1 OR MaintArray[l].Section3 EQ 1 AND TowerArray[k].Section3 EQ 1>
					<cfif 	(MaintArray[l].StartDate LTE TowerArray[k].StartDate AND TowerArray[k].StartDate LTE MaintArray[l].EndDate)
						OR	(MaintArray[l].StartDate LTE TowerArray[k].EndDate AND TowerArray[k].EndDate LTE MaintArray[l].EndDate)
						OR	(MaintArray[l].StartDate GTE TowerArray[k].StartDate AND TowerArray[k].EndDate GTE MaintArray[l].EndDate)>
						<cfscript>
							Variables.TowerArray[k].Section1 = 0;
							Variables.TowerArray[k].Section2 = 0;
							Variables.TowerArray[k].Section3 = 0;
							Variables.Orderable = false;
						</cfscript>
					</cfif>
				</cfif>
			</cfloop>
			<!--- find conflicts --->
		</cfloop>
		<cfreturn Orderable>
	</cffunction>

</cfcomponent>