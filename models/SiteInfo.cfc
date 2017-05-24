component SiteInfo implements = "ISiteInfo" {
	/*
	 * This should come from an external configuration somewhere, but I'm just putting
	 * it here for ease of use right now. I don't particularly care that these are in
	 * source control since it's a pithy sample program.
	 */
	this.screenshotApiKey = "ab6af2a22d2cfc44a50bed1a3aff02bc3883cd308a87";
	this.whoisApiAuthentication = "45206:F44s4bj83wKlW7pM2n561Qj7EuFsLLE2";


	function getSiteMetadata(string url) {
		var siteInfo = {};
		cfhttp(url = url, result = "siteInfo");

		if(siteInfo.statusCode == "200 OK") {
			// Add original URL to this struct.
			siteInfo.responseHeader.requestedUrl = url;
			return siteInfo.responseHeader;
		} else {
			return {};
		}
	}


	function getSiteScreenshot(string url) {
		var image = {};
		// It looks like this service will return a blank image if it's an invalid site.
		cfhttp(url = getScreenshotServiceUrl(url), getAsBinary = "yes", result = "image", timeout = "20");
		return image.fileContent;
	}


	function getScreenshotServiceUrl(string url) {
		return "https://api.thumbnail.ws/api/" & this.screenshotApiKey & "/thumbnail/get?url=" 
			& urlEncodedFormat(url) & "&width=500";
	}


	function getSiteWhois(string url) {
		// curl -X POST -s --user '{customer_id}:{api_key}' \
		// https://jsonwhoisapi.com/api/v1/whois?identifier='michaelpidde.com'

		// use Authenticate header for --user
	}
}