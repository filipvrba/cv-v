module src

import json
import encoding.base32
import markdown
import regex

const (
	query_all_projects = "SELECT projects.id, full_name as author, name, category, content, projects.created_at, last_change FROM projects INNER JOIN profiles ON projects.author_id = profiles.id"
	query_where_project = "WHERE REPLACE(LOWER(name), ' - ', ' ') = '[*]'"
	query_sort_projects = "ORDER BY last_change DESC LIMIT 3"
	query_update_project = "UPDATE projects SET [0] WHERE id = [1]"
)

pub fn (mut app App) update_project(id int, query_set string) int
{
	query := "${ query_update_project.replace('[0]', query_set).replace('[1]', id.str()) };"
	return app.db.exec_none(query)
}

pub fn (mut app App) get_projects() []Project
{
	mut projects := []Project{}
	rows, _ := app.db.exec("$query_all_projects;")
	

	for _, row in rows {
		data := row.vals

		mut content := data[4]
		mut reg, _, _ := regex.regex_base("^.*\n")
		a_reg_result := reg.find_all_str( content )

		if a_reg_result.len > 0 {
			content = a_reg_result[0].replace("\n", '')
		}

		projects << Project{
			id: data[0].int()
			author: data[1]
			name: data[2]
			category: data[3]
			content: markdown.to_html( content )
			create_at: data[5].int()
			last_change: data[6].int()
		}
	}

	return projects
}

pub fn (mut app App) get_top_projects() []Project
{
	query := "$query_all_projects $query_sort_projects;"
	rows, _ := app.db.exec(query)
	mut projects := []Project{}

	if rows.len > 0 {
		for _, row in rows {
			data := row.vals

			mut content := data[4]
			mut reg, _, _ := regex.regex_base("^.*\n")
			a_reg_result := reg.find_all_str( content )

			if a_reg_result.len > 0 {
				content = a_reg_result[0].replace("\n", '')
			}

			projects << Project{
				id: data[0].int()
				author: data[1]
				name: data[2]
				category: data[3]
				content: markdown.to_html( content )
				create_at: data[5].int()
				last_change: data[6].int()
			}
		}
		
	}
	else {
		eprintln("No top Projects were found.")
	}

	return projects
}

pub fn (mut app App) get_project(name string) ![]Project
{
	query := "$query_all_projects ${query_where_project.replace_once('[*]', name)};"
	rows, _ := app.db.exec(query)

	if rows.len > 0 {
		mut projects := []Project{}

		for _, row in rows {
			data := row.vals

			projects << Project{
				id: data[0].int()
				author: data[1]
				name: data[2]
				category: data[3]
				content: markdown.to_html( data[4] )
				create_at: data[5].int()
				last_change: data[6].int()
			}
		}
		return projects
	}
	else {
		return error("Name $name not found.")
	}
}

pub fn (mut app App) get_encode_json_projects(projects []Project) string
{
	s_projects_json := json.encode(projects)
	encode_json_projects := base32.encode_string_to_string(s_projects_json)

	return encode_json_projects
}