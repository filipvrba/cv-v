module src

import vweb

['/']
pub fn(mut app App) root_index() vweb.Result
{
	title := "Home"
	top_projects := app.get_top_projects()
	tps_data := app.get_encode_json_projects(top_projects)

	return $vweb.html()
}