component SiteController {
	this.VALID_ACTIONS = ["getSite", "saveSite", "viewSite", "removeSite", "list"];


	function route() {
		// Run the action dynamically if it's valid, otherwise run a default.
		if(structKeyExists(url, "action") && arrayContains(this.VALID_ACTIONS, url.action)) {
			var func = variables[url.action];
			func();
		} else {
			getSite();
		}
	}


	function getSite() {
		request.data.title = "Get Site Data";
		request.data.content = application.view.loadView("getSite");
	}


	function saveSite() {
		// Validate form variable
		var valid = false;
		if(structKeyExists(form, "url")) {
			// If less than 7, the first part of the URL cannot be "http://"
			if(len(form.url) >= 7 && left(form.url, 7) == "http://") {
				valid = true;
			} else {
				session.error = "Whoa, Johnny, that URL doesn't start with http://";
			}
		} else {
			session.error = "The 'url' form field doesn't exist for some reason...";
		}

		if(!valid) {
			// Redirect back to form.
		}

		application.siteInfo.getSiteMetadata(form.url);
		application.siteInfo.getSiteScreenshot(form.url);
		request.key = application.siteInfo.getCacheKey(form.url);

		viewSite();
	}


	function viewSite() {
		var key = "";

		if(structKeyExists(request, "key")) {
			key = request.key;
		} else if(structKeyExists(url, "key")) {
			key = url.key;
		}

		if(len(key) > 0) {
			request.data.title = "View Site Data";
			request.data.siteInfo = {
				metadata = application.siteInfo.getSiteMetadata(key), 
				screenshot = application.siteInfo.getSiteScreenshot(key)
			};
			request.data.content = application.view.loadView("viewSite");
		} else {
			writeDump("Invalid key"); abort;
			// Add invalid key error.
		}
	}


	function removeSite() {
		// Remove from cache, no view
		request.data.title = "";
		request.data.content = "removeSite";
	}


	function list() {
		request.data.title = "Cached Site Data List";
		request.data.content = application.view.loadView("list");
	}
}