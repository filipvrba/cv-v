module src

import vweb

['/']
pub fn(mut app App) root_index() vweb.Result
{
	title := "Home"
	top_projects := app.get_top_projects()
	tps_data := app.get_encode_json_projects(top_projects)
	profiles := app.get_profile(1)
	p_data := app.get_encode_json_profiles(profiles)
	top_articles := app.get_top_articles()
	tas_data := app.get_encode_json_articles(top_articles)

	return $vweb.html()
}