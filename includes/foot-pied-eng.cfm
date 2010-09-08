		<!-- FOOTER BEGINS | DEBUT DU PIED DE LA PAGE -->
		<div class="footer">
			<div class="footerline"></div>
			<div class="foot1">
				<!-- DATE MODIFIED BEGINS | DEBUT DE LA DATE DE MODIFICATION -->
				Date Modified: <span class="date">
					<!--- the query is set up in tete-header --->
					<cfoutput query="GetFile">	#LSDateFormat(parseDateTime(GetFile.DateLastModified,"mm-dd-yyyy"), "yyyy-mm-dd")#</cfoutput>
				</span>
				<!-- DATE MODIFIED ENDS | FIN DE LA DATE DE MODIFICATION -->
			</div>
			<cfinclude  template="#CLF_Path#/clf20/ssi/foot-pied-eng.html">
		</div>
		<!-- FOOTER ENDS | FIN DU PIED DE LA PAGE -->
	</div>
</div>
</body>
</html>
