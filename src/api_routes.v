module src

import vweb
import json

[get; '/api/v1']
pub fn(mut app App) api_index() vweb.Result
{
	return app.json(get_greet_message())
}

[get; '/api/v1/get/articles']
pub fn(mut app App) api_get_articles() vweb.Result
{
	articles := app.get_api_articles()
	return app.json(articles)
}

[get; '/api/v1/get/projects']
pub fn(mut app App) api_get_projects() vweb.Result
{
	projects := app.get_api_projects()
	return app.json(projects)
}

[get; '/api/v1/get/profile']
pub fn(mut app App) api_get_profile() vweb.Result
{
	profile := app.get_api_profile()
	return app.json(profile)
}

[post; '/api/v1/post/sandbox']
pub fn(mut app App) api_post_sandbox() vweb.Result
{
	println(app.Context.req.data)

	message := Message{
		status_code: StatusCode{
			code: 200
			status: "OK"
		}
		message: "The Sandbox function took the request and processed it."
	}
	return app.json(message)
}

[post; '/api/v1/post/project/add']
pub fn(mut app App) post_project_add() vweb.Result
{
	api_project := json.decode(ApiProject, app.Context.req.data) or {
		ApiProject{}
	}
	code_result := app.set_project(api_project)

	message := Message{
		status_code: StatusCode{
			code: code_result
		}
	}
	return app.json(message)
}

[post; '/api/v1/post/project/free']
pub fn(mut app App) post_project_free() vweb.Result
{
	api_project := json.decode(ApiProject, app.Context.req.data) or {
		ApiProject{}
	}
	code_result := app.free_project(api_project)

	message := Message{
		status_code: StatusCode{
			code: code_result
		}
	}
	return app.json(message)
}

[post; '/api/v1/post/project/update']
pub fn(mut app App) post_project_update() vweb.Result
{
	api_project := json.decode(ApiProject, app.Context.req.data) or {
		ApiProject{}
	}
	code_result := app.update_project(api_project)

	message := Message{
		status_code: StatusCode{
			code: code_result
		}
	}
	return app.json(message)
}
