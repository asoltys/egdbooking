<cfquery name="dock_bookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Bookings.*, Vessels.Name, Docks.*, FirstName, LastName, Users.FirstName + ' ' + Users.LastName AS AgentName
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VNID = Vessels.VNID INNER JOIN
		Docks ON Bookings.BRID = Docks.BRID INNER JOIN
		Users ON Bookings.UID = Users.UID
	WHERE Vessels.CID = <cfqueryparam value="#session.CID#" cfsqltype="cf_sql_integer" /> 
  AND Bookings.Deleted = '0' 
  AND Vessels.Deleted = 0 
  AND endDate >= <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_date" />
	ORDER BY startDate, enddate
</cfquery>

<cfquery name="nlw_bookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Bookings.*, Vessels.Name, Jetties.*, FirstName, LastName, Users.FirstName + ' ' + Users.LastName AS AgentName
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VNID = Vessels.VNID INNER JOIN
		Jetties ON Bookings.BRID = Jetties.BRID INNER JOIN
		Users ON Bookings.UID = Users.UID
	WHERE Vessels.CID = <cfqueryparam value="#session.CID#" cfsqltype="cf_sql_integer" /> 
  AND Jetties.NorthJetty = '1' 
  AND Bookings.Deleted = '0' 
  AND Vessels.Deleted = 0 
  AND endDate >= <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_date" />
	ORDER BY startDate, enddate
</cfquery>

<cfquery name="sj_bookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Bookings.*, Vessels.Name, Jetties.*, FirstName, LastName, Users.FirstName + ' ' + Users.LastName AS AgentName
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VNID = Vessels.VNID INNER JOIN
		Jetties ON Bookings.BRID = Jetties.BRID INNER JOIN
		Users ON Bookings.UID = Users.UID 
    AND Jetties.SouthJetty = '1' 
    AND Bookings.Deleted = '0' 
    AND Vessels.Deleted = 0 
    AND endDate >= <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_date" />
	WHERE Vessels.CID = <cfqueryparam value="#session.CID#" cfsqltype="cf_sql_integer" />
	ORDER BY startDate, enddate
</cfquery>

<cfquery name="dock_counts" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 
    SUM(CASE Docks.Status WHEN 'P' THEN 1 WHEN 'PT' THEN 1 WHEN 'PC' THEN 1 ELSE 0 END) as pending,
    SUM(CASE Docks.Status WHEN 'T' THEN 1 ELSE 0 END) as tentative,
    SUM(CASE Docks.Status WHEN 'C' THEN 1 ELSE 0 END) as confirmed,
    SUM(CASE Docks.Status WHEN 'PX' THEN 1 ELSE 0 END) as cancelled
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VNID = Vessels.VNID INNER JOIN
		Docks ON Bookings.BRID = Docks.BRID INNER JOIN
		Users ON Bookings.UID = Users.UID
	WHERE Vessels.CID = <cfqueryparam value="#session.CID#" cfsqltype="cf_sql_integer" /> 
  AND Bookings.Deleted = '0' 
  AND Vessels.Deleted = 0 
  AND endDate >= <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_date" /> 
</cfquery>

<cfquery name="nlw_counts" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 
    SUM(CASE Jetties.Status WHEN 'P' THEN 1 WHEN 'PT' THEN 1 WHEN 'PC' THEN 1 ELSE 0 END) as pending,
    SUM(CASE Jetties.Status WHEN 'T' THEN 1 ELSE 0 END) as tentative,
    SUM(CASE Jetties.Status WHEN 'C' THEN 1 ELSE 0 END) as confirmed,
    SUM(CASE Jetties.Status WHEN 'PX' THEN 1 ELSE 0 END) as cancelled
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VNID = Vessels.VNID INNER JOIN
		Jetties ON Bookings.BRID = Jetties.BRID INNER JOIN
		Users ON Bookings.UID = Users.UID
	WHERE Vessels.CID = <cfqueryparam value="#session.CID#" cfsqltype="cf_sql_integer" /> 
  AND Jetties.NorthJetty = '1' 
  AND Bookings.Deleted = '0' 
  AND Vessels.Deleted = 0 
  AND endDate >= <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_date" /> 
</cfquery>

<cfquery name="sj_counts" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT
    SUM(CASE Jetties.Status WHEN 'P' THEN 1 WHEN 'PT' THEN 1 WHEN 'PC' THEN 1 ELSE 0 END) as pending,
    SUM(CASE Jetties.Status WHEN 'T' THEN 1 ELSE 0 END) as tentative,
    SUM(CASE Jetties.Status WHEN 'C' THEN 1 ELSE 0 END) as confirmed,
    SUM(CASE Jetties.Status WHEN 'PX' THEN 1 ELSE 0 END) as cancelled
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VNID = Vessels.VNID INNER JOIN
		Jetties ON Bookings.BRID = Jetties.BRID INNER JOIN
		Users ON Bookings.UID = Users.UID 
    AND Jetties.SouthJetty = '1' 
    AND Bookings.Deleted = '0' 
    AND Vessels.Deleted = 0 
    AND endDate >= <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_date" /> 
	WHERE Vessels.CID = <cfqueryparam value="#session.CID#" cfsqltype="cf_sql_integer" />
</cfquery>
