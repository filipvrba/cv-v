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

[get; '/api/v1/get/profiles']
pub fn(mut app App) api_get_profiles() vweb.Result
{
	profile := app.get_api_profiles()
	return app.json(profile)
}

// Article
[post; '/api/v1/post/article/add']
pub fn(mut app App) post_article_add() vweb.Result
{
	api_article := json.decode(ApiArticle, app.Context.req.data) or {
		ApiArticle{}
	}
	code_result := app.add_article(api_article)

	message := Message{
		status_code: StatusCode{
			code: code_result
		}
	}
	return app.json(message)
}

[post; '/api/v1/post/article/free']
pub fn(mut app App) post_article_free() vweb.Result
{
	api_article := json.decode(ApiArticle, app.Context.req.data) or {
		ApiArticle{}
	}
	code_result := app.free_article(api_article)

	message := Message{
		status_code: StatusCode{
			code: code_result
		}
	}
	return app.json(message)
}

[post; '/api/v1/post/article/update']
pub fn(mut app App) post_article_update() vweb.Result
{
	api_article := json.decode(ApiArticle, app.Context.req.data) or {
		ApiArticle{}
	}
	code_result := app.update_article(api_article)

	message := Message{
		status_code: StatusCode{
			code: code_result
		}
	}
	return app.json(message)
}

// Project
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

// Profile
[post; '/api/v1/post/profile/add']
pub fn(mut app App) post_profile_add() vweb.Result
{
	api_profile := json.decode(ApiProfileTwo, app.Context.req.data) or {
		ApiProfileTwo{}
	}
	code_result := app.add_profile(api_profile)

	message := Message{
		status_code: StatusCode{
			code: code_result
		}
	}
	return app.json(message)
}

[post; '/api/v1/post/profile/free']
pub fn(mut app App) post_profile_free() vweb.Result
{
	api_profile := json.decode(ApiProfileTwo, app.Context.req.data) or {
		ApiProfileTwo{}
	}
	code_result := app.free_profile(api_profile)

	message := Message{
		status_code: StatusCode{
			code: code_result
		}
	}
	return app.json(message)
}

[post; '/api/v1/post/profile/update']
pub fn(mut app App) post_profile_update() vweb.Result
{
	api_profile := json.decode(ApiProfileTwo, app.Context.req.data) or {
		ApiProfileTwo{}
	}
	code_result := app.update_profile(api_profile)

	message := Message{
		status_code: StatusCode{
			code: code_result
		}
	}
	return app.json(message)
}

// Tables
[post; '/api/v1/post/tables/reset']
pub fn(mut app App) post_tables_reset() vweb.Result
{
	message := app.api_reset_tables()
	return app.json(message)
}