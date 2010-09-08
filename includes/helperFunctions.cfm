<cfscript>
			function FormatParagraph(txt) {
				var temp = ReReplace(Trim(txt), '\r\n\r\n', '</p><p>', 'all');
				temp = '<p>' & ReReplace(temp, '\r\n', '<br />', 'all') & '</p>';
				temp=Replace(temp, '</p>', '</p>#Chr(10)##Chr(13)#', 'all');
				temp=Replace(temp, '<br />', '<br />#Chr(10)##Chr(13)#', 'all');
				return temp;
			}
</cfscript>