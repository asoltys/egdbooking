<cfoutput>
server.ColdFusion.ProductLevel = #server.ColdFusion.ProductLevel#<bR>
server.ColdFusion.ProductName = #server.ColdFusion.ProductName#<bR>
server.ColdFusion.ProductVersion = #server.ColdFusion.ProductVersion#<bR>
server.ColdFusion.SupportedLocales = #server.ColdFusion.SupportedLocales#<bR>
server.OS.AdditionalInformation = #server.OS.AdditionalInformation#<bR>
server.OS.BuildNumber = #server.OS.BuildNumber#<bR>
server.OS.Name = #server.OS.Name#<bR>
server.OS.Version = #server.OS.Version#
<br />
#FileDir#
<br />
#RootDir#
<br />
#getCurrentTemplatePath()#
<br />
<cfobject   action="create"   type="java"   class="coldfusion.server.ServiceFactory"   name="factory"> <cfdump var="#factory.getRuntimeService().getMappings()#">
<cfdump var="#Application#" />
</cfoutput>

