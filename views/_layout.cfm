<!doctype html>
<html>
<head>
	<title><cfoutput>#args.title#</cfoutput></title>
	<meta name="viewport" content="width=device-width">
	<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Lato">
	<link rel="stylesheet" href="assets/css/bootstrap-3.3.7/bootstrap.min.css">
	<link rel="stylesheet" href="assets/css/bootstrap-3.3.7/bootstrap-theme.min.css">
	<link rel="stylesheet" href="assets/css/main.css">
	<script src="assets/js/bootstrap-3.3.7/bootstrap.min.js"></script>
</head>
<body class="panel-body">
	<nav class="navbar navbar-inverse">
		<div class="container-fluid">
			<div class="navbar-header">
		    	<span class="navbar-brand">Site Info Cache</span>
		    </div>
			<ul class="nav navbar-nav">
				<li><a href="?action=getSite">Get Site Data</a></li>
				<li><a href="?action=list">List Sites</a></li>
			</ul>
		</div>
	</nav>
	<main class="container">
		<cfoutput>#args.content#</cfoutput>
	</main>
	<footer class="container">
		<cfscript>
			if(structKeyExists(args, "loadTime")) {
				writeOutput("Load time: " & args.loadTime);
			}
		</cfscript>
	</footer>
</body>
</html>