module src

struct StatusCode {
	code int
	status string
}

struct Message {
	status_code StatusCode
	message string
}

struct ApiArticles {
	status_code StatusCode
	articles []Article
}

struct ApiProjects {
	status_code StatusCode
	projects []Project
}

struct ApiProfile {
	status_code StatusCode
	profile []Profile
}

struct ApiTable {
	token string
}