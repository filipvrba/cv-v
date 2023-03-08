module src

import vweb

['/']
pub fn(mut app App) root_index() vweb.Result
{
	title := "Home"
	author_id := app.get_profiles(true)[0].id
	profiles := app.get_profile(author_id)
	p_data := app.get_encode_json_profiles(profiles)

	top_projects := app.get_top_projects(author_id)
	tps_data := app.get_encode_json_projects(top_projects)

	top_articles := app.get_top_articles(author_id)
	tas_data := app.get_encode_json_articles(top_articles)

	return $vweb.html()
}