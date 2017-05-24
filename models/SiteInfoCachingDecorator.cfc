/*
 * This decorator could viably connect to whatever caching system you'd want
 * to use in a production environment. Memcached, Redis, whatever. I'm just
 * using the application scope for the sake of simplicity.
 */

component SiteInfoCachingDecorator implements = "ISiteInfo" {
	function init(ISiteInfo base) {
		this.base = base;

		/*
		 * This gets instantiated on application startup, but in the very off chance
		 * that it's not there, we need it to exist for caching to work.
		 */
		if(!structKeyExists(application, "appCache")) {
			application.appCache = {};
		}
	}


	function getSiteMetadata(string url) {
		var key = getCacheKey(url);
		addCacheKeyIfNotExists(key);

		if(!structKeyExists(application.appCache[key], "metadata")) {
			// Metadata is not in cache - add it.
			structInsert(application.appCache[key], "metadata", this.base.getSiteMetadata(url));
		}

		return application.appCache[key].metadata;
	}


	function getSiteScreenshot(string url) {
		var key = getCacheKey(url);
		addCacheKeyIfNotExists(key);
		
		if(!structKeyExists(application.appCache[key], "screenshot")) {
			// Screenshot is not in cache - add it.
			structInsert(application.appCache[key], "screenshot", this.base.getSiteScreenshot(url));
		}

		return application.appCache[key].screenshot;
	}


	function getSiteWhois(string url) {
		this.base.getSiteWhois(url);
	}


	function addCacheKeyIfNotExists(string key) {
		if(!structKeyExists(application.appCache, key)) {
			structInsert(application.appCache, key, {});
		}
	}


	function getCacheKey(string url) {
		// Just strip out every non-alphanumeric character.
		return reReplace(url, "[\W]", "", "all");
	}
}