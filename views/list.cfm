<ul>
<cfscript>
for(key in listSort(structKeyList(application.appCache), 'textnocase')) {
	writeOutput('<li><a href="?action=viewSite&key=' & key 
		& '">' & application.appCache[key].metadata.requestedUrl & '</a></li>');
}
</cfscript>
</ul>