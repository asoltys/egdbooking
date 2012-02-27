<cfmail subject="test" from="pacificweb.services@pwgsc-tpsgc.gc.ca" to="adam.soltys@pwgsc-tpsgc.gc.ca">Test</cfmail>

<cfmail to="adam.soltys@pwgsc.gc.ca" from="egd-cse@pwgsc-tpsgc.gc.ca" subject="Booking Tentative to Confirm Request" type="html">
<p>#getUser.UserName# has requested to confirm the booking for #getBooking.VesselName# from #DateFormat(getBooking.StartDate, 'mmm d, yyyy')# to #DateFormat(getBooking.EndDate, 'mmm d, yyyy')#. This is for #northorsouth# Jetty the Drydock.</p>
	</cfmail>
	
<cfmail to="adam.soltys@pwgsc.gc.ca" from="egd-cse@pwgsc-tpsgc.gc.ca" subject="Booking Confirmation Request - Demande d'annulation de r&eacute;servation: eee" type="html">
<p>Your confirmation request for the booking for #getBooking.VesselName# from #DateFormat(getBooking.StartDate, 'mmm d, yyyy')# to #DateFormat(getBooking.EndDate, 'mmm d, yyyy')# is now pending.  EGD administration has been notified of your request.  You will receive a follow-up email responding to your request shortly.  Until such time, your booking is considered to be going ahead as currently scheduled.</p>
<p>&nbsp;</p>
<p>Votre demande d'annulation de la r&eacute;servation pour le #getBooking.VesselName# du #DateFormat(getBooking.StartDate, 'mmm d, yyyy')# au #DateFormat(getBooking.EndDate, 'mmm d, yyyy')# est en cours de traitement. L'administration de la CSE a &eacute;t&eacute; avis&eacute;e de votre demande. Vous recevrez sous peu un courriel de suivi en r&eacute;ponse &agrave; votre demande. D'ici l&agrave;, votre place est consid&eacute;r&eacute;e comme r&eacute;serv&eacute;e pour les dates indiqu&eacute;es.</p>
</cfmail>
