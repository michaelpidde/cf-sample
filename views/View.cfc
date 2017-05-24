component View {
	this.viewPath = "/views/";

	function render(struct args = request.data) {
		writeOutput(loadView("_layout", args));
	}


	/*
	 * The args struct here is used to provide variables to the included files.
	 */
	function loadView(string view, struct args = request.data) {
		if(fileExists(expandPath(this.viewPath) & "/" & view & ".cfm")) {
			cfsavecontent(variable = "content") {
				include this.viewPath & view & ".cfm";
			}
			return content;
		} else {
			// Log this or something.
		}
	}
}