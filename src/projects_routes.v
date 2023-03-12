module src

import vweb
import net.urllib

['/projects']
pub fn(mut app App) projects_index() vweb.Result
{
	title := "Projects"
	author_id := app.get_profiles(true)[0].id
	projects := app.get_projects(author_id)
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

[get; '/admin/project/edit/:id']
pub fn(mut app App) project_edit(id int) vweb.Result
{
	if app.is_logged_in() {
		project := app.get_project_raw(id)[0]
		title := "$project.name | Edit"
		data := app.get_encode_json_project(project)

		return $vweb.html()
	}
	else {
		return app.redirect_to_admin_login()
	}
}

[post; '/admin/project/edit/:id']
pub fn(mut app App) post_project_edit(id int) vweb.Result
{
	if app.is_logged_in() {
		form := app.Context.form.clone()
		api_project := ApiProject{
			id: id
			query: "author_id=${form['author_id']}, name=\'${form['name']}\', " +
				"category=\'${form['category']}\', content=\'${urllib.query_escape( form['content'] )}\'"
		}

		code_result := app.update_project(api_project)
		message := Message{
			status_code: StatusCode{
				code: code_result
			}
		}
		return app.json(message)
	}
	else {
		return app.redirect_to_admin_login()
	}
}

[get; '/admin/project/add']
pub fn(mut app App) project_add() vweb.Result
{
	if app.is_logged_in() {
		title := "Add | Project"

		return $vweb.html()
	}
	else {
		return app.redirect_to_admin_login()
	}
}

[post; '/admin/project/add']
pub fn(mut app App) post_admin_project_add() vweb.Result
{
	if app.is_logged_in() {
		form := app.Context.form.clone()
		api_project := ApiProject{
			author_id: form["author_id"].int()
			name: form["name"]
			category: form["category"]
			content: urllib.query_escape( form["content"] )
		}

		code_result := app.set_project(api_project)
		message := Message{
			status_code: StatusCode{
				code: code_result
			}
		}
		return app.json(message)
	}
	else {
		return app.redirect_to_admin_login()
	}
}
