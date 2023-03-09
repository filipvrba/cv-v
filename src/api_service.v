module src

pub fn get_greet_message() Message {
	return Message {
		status_code: StatusCode {
			code: 300
			status: "Multiple Choices"
		}
		message: "The database can be altered using this API. " +
			"It allows you to add, remove, and amend data."
	}
}

pub fn get_forbidden_message() Message {
	return Message {
		status_code: StatusCode {
			code: 403
			status: "Forbidden"
		}
		message: "The request has been granted but cannot be implemented. Invalid Token!"
	}
}

pub fn (mut a App) get_api_articles() ApiArticles {
	return ApiArticles {
		status_code: StatusCode {
			code: 200
			status: "OK"
		}
		articles: a.get_articles(-1)
	}
}

pub fn (mut a App) get_api_projects() ApiProjects {
	return ApiProjects {
		status_code: StatusCode {
			code: 200
			status: "OK"
		}
		projects: a.get_projects(-1)
	}
}

pub fn (mut a App) get_api_profiles() ApiProfile {
	return ApiProfile {
		status_code: StatusCode {
			code: 200
			status: "OK"
		}
		profile: a.get_profiles(false)
	}
}

pub fn (mut a App) api_reset_tables() Message {
	mut code := a.free_articles()
	code = a.free_projects()
	code = a.free_profiles()
	
	code = a.create_articles()
	code = a.create_projects()
	code = a.create_profiles()

	return Message {
		status_code: StatusCode {
			code: code
		}
	}
}
