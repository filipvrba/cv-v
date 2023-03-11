module src

import vweb

[get; '/admin']
pub fn(mut app App) admin_index() vweb.Result
{
	title := "Admin"

	author_id := app.get_profiles(true)[0].id
	profiles := app.get_profile(author_id)
	full_name := profiles[0].full_name

	artilces := app.get_articles(author_id)
	data_articles := app.get_encode_json_articles(artilces)

	projects := app.get_projects(author_id)
	data_projects := app.get_encode_json_projects(projects)

	return $vweb.html()
}
