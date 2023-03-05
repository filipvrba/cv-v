module src

import vweb

['/projects']
pub fn(mut app App) projects_index() vweb.Result
{
	title := "Projects"
	projects := app.get_projects()
	data := app.get_encode_json_projects(projects)

	return $vweb.html()
}

['/projects/:name']
pub fn(mut app App) projects_project(name string) vweb.Result
{
	projects := app.get_project(name.replace('-', ' ')) or {
		mut proj := []Project{}
		proj << Project{
			id: -1
			content: err.str()
		}
		proj
	}
	title := if projects[0].id == -1 { "Error | Project" } else { "${projects[0].name} | Project" }
	data := app.get_encode_json_projects(projects)

	return $vweb.html()
}