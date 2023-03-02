module src

import json
import encoding.base32
import markdown

const (
	query_all_projects = "SELECT projects.id, full_name as author, name, category, content, projects.created_at, last_change FROM projects INNER JOIN profiles ON projects.author_id = profiles.id"
	query_where_project = "WHERE LOWER(name) = '[*]'"
)

pub fn (mut app App) get_projects() []Project
{
	mut projects := []Project{}
	rows, _ := app.db.exec("$query_all_projects;")
	for _, row in rows {
		data := row.vals
		projects << Project{
			id: data[0].int()
			author: data[1]
			name: data[2]
			category: data[3]
			content: data[4]
			create_at: data[5].int()
			last_change: data[6].int()
		}
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
				content: markdown.to_html(data[4])
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