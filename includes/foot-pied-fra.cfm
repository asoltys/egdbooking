			<!-- DEBUT DU PIED DE LA PAGE | FOOTER BEGINS -->
			<div class="footer">
				<div class="footerline"></div>
				<div class="foot1">
					<!-- DEBUT DE LA DATE DE MODIFICATION | DATE MODIFIED BEGINS -->
					Date de modification&nbsp;: <span class="date">
						<!--- the query is set up in tete-header --->
						<cfoutput query="GetFile">	#LSDateFormat(parseDateTime(GetFile.DateLastModified,"mm-dd-yyyy"), "yyyy-mm-dd")#</cfoutput>
					</span>
					<!-- FIN DE LA DATE DE MODIFICATION | DATE MODIFIED ENDS -->
				</div>
				<cfinclude template="/egd_internet_clf2/clf20/ssi/foot-pied-fra.html">
			</div>
			<!-- FIN DU PIED DE LA PAGE | FOOTER ENDS -->
		</div>
	</div>
</div>
</body>
</html>
