module src

import vweb

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
