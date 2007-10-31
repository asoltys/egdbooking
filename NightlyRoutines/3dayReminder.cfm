<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
	<head>
		<title>3 day reminder</title>
	</head>
	<!--- This routine e-mails out a reminder message to anyone who has a confirmed booking ending 3 days from today.
		  This is run as a nightly routine.
	--->
	
	<body>
		<!--- Get all dock bookings with an end date 3 days from today --->
		<CFQUERY datasource="#DSN#" username="#dbuser#" password="#dbpassword#" name="GetDockBookings">
			SELECT Bookings.VesselID, Bookings.UserID, Vessels.Name,Users.Email
			FROM Bookings, Docks, Vessels, Users
			WHERE Docks.BookingID=Bookings.BookingID
			AND Bookings.VesselID=Vessels.VesselID
			AND Users.UserID=Bookings.UserID
			AND Docks.Status='C'
			AND Bookings.EndDate>=#CreateODBCDate(DateAdd("d",3,now()))# 
			AND Bookings.EndDate < #CreateODBCDate(DateAdd("d",4,now()))#
			AND Bookings.Deleted=0
		</CFQUERY>
		
		<CFDUMP var="#GetDockBookings#">
		<CFLOOP query="GetDockBookings">
				<!--- And, finally, e-mail the registrant --->
				<!--- Production only <CFMAIL from="egdbooking@pwgsc.gc.ca" subject="EGD Booking expiry" type="html" to="#GetDockBookings.email#" --->
				<CFMAIL from="egdbooking@pwgsc.gc.ca" subject="EGD Booking expiration reminder" type="html" to="dirk.sieber@pwgsc.gc.ca"> 
	 				Hello,<br />
					<br />
					Your booking for the #GetDockBookings.Name# will be expiring in 3 days.<br />
					Please respond to EGD Bookings as to whether or not additional time is required.	<br />
				</CFMAIL> 
		</CFLOOP> 
		
		<!--- Get all jetty bookings with an end date 3 days from today --->
		<CFQUERY datasource="#DSN#" username="#dbuser#" password="#dbpassword#" name="GetJettyBookings">
			SELECT Bookings.VesselID, Bookings.UserID, Vessels.Name,Users.Email
			FROM Bookings, Jetties, Vessels, Users
			WHERE Jetties.BookingID=Bookings.BookingID
			AND Bookings.VesselID=Vessels.VesselID
			AND Users.UserID=Bookings.UserID
			AND Jetties.Status='C'
			AND Bookings.EndDate>=#CreateODBCDate(DateAdd("d",3,now()))# 
			AND Bookings.EndDate < #CreateODBCDate(DateAdd("d",4,now()))#
			AND Bookings.Deleted=0
		</CFQUERY>
		
		<CFDUMP var="#GetJettyBookings#">
		<CFLOOP query="GetJettyBookings">
				<!--- And, finally, e-mail the registrant --->
				<!--- Production only <CFMAIL from="egdbooking@pwgsc.gc.ca" subject="EGD Booking expiry" type="html" to="#GetJettyBookings.email#" --->
				<CFMAIL from="egdbooking@pwgsc.gc.ca" subject="EGD Booking expiration reminder" type="html" to="dirk.sieber@pwgsc.gc.ca"> 
	 				Hello,<br />
					<br />
					Your booking for the #GetJettyBookings.Name# will be expiring in 3 days.<br />
					Please respond to EGD Bookings as to whether or not additional time is required.	<br />
				</CFMAIL> 
		</CFLOOP> 		
	</body>
</html>

