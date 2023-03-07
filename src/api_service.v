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

pub fn (mut a App) get_api_articles() ApiArticles {
	return ApiArticles {
		status_code: StatusCode {
			code: 200
			status: "OK"
		}
		articles: a.get_articles()
	}
}

pub fn (mut a App) get_api_projects() ApiProjects {
	return ApiProjects {
		status_code: StatusCode {
			code: 200
			status: "OK"
		}
		projects: a.get_projects()
	}
}

pub fn (mut a App) get_api_profiles() ApiProfile {
	return ApiProfile {
		status_code: StatusCode {
			code: 200
			status: "OK"
		}
		profile: a.get_profiles()
	}
}
