component {
	this.name = 'SiteInformation';
	this.timeout = 20;
	this.sessionManagement = true;
	this.root = getDirectoryFromPath(getTemplatePath());
	this.mappings["/views"] = this.root & "\views\";

	function onApplicationStart() {
		/* 
		 * This can be in application scope since there's no need right now to
		 * reinstantiate it for every request.
		 *
		 * TEMPORARILY MOVED to onRequestStart to init new version each request.
		 */
		// application.siteInfo = new models.SiteInfo();
		// This can be removed or swapped depending on caching requirements.
		// application.siteInfo = new models.SiteInfoCachingDecorator(application.siteInfo);
		application.appCache = {};
		// application.view = new views.View();
		// application.controller = new controllers.SiteController();
	}


	function onRequestStart() {

		// These app vars need to be moved back to onApplicationStart after development.
		application.siteInfo = new models.SiteInfo();
		application.siteInfo = new models.SiteInfoCachingDecorator(application.siteInfo);
		application.view = new views.View();
		application.controller = new controllers.SiteController();

		if(structKeyExists(url, 'reinit')) {
			onApplicationStart();
		}

		// Initialize data structure used throughout the request.
		request.data = {};

		request.startTime = getTickCount();

		// Handle request
		application.controller.route();
	}


	function onRequestEnd() {
		var endTime = getTickCount() - request.startTime;
		request.data.loadTime = endTime & " milliseconds";

		application.view.render(request.data);
	}
}