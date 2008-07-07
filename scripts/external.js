<!-- 
// Opens links marked with rel="external" in new windows.
// By: Kevin Yank
// From: http://www.sitepoint.com/article/standards-compliant-world/3
// -->


function externalLinks() {
	if (!document.getElementsByTagName) { return; }
	var anchors = document.getElementsByTagName("a");
	for (var i=0; i<anchors.length; i++) {
		var anchor = anchors[i];
		if (anchor.getAttribute("href") && anchor.getAttribute("rel") == "external") {
			anchor.target = "_blank";
		}
	}
}

window.onload = externalLinks;
