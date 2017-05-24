<cfscript>
// An array like this can viably come from a View Model.
model = [
	{label = "Requested URL", key = "requestedurl"},
	{label = "Server", key = "server"},
	{label = "Powered By", key = "X-Powered-By"}
];

for(item in model) {
	if(structKeyExists(args.siteInfo.metadata, item.key)) {
		writeOutput(item.label & ": " & args.siteInfo.metadata[item.key] & "<br>");
	}
}

</cfscript>
<div class="row">
	<div class="col-lg-8 centered">
		<cfscript>cfimage(action = "writeToBrowser", source = args.siteInfo.screenshot);</cfscript>
	</div>
</div>