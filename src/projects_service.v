module src

import json
import encoding.base32
import markdown
import src.mruby
import regex

const (
	query_all_projects = "SELECT projects.id, full_name as author, name, category, content, projects.created_at, last_change FROM projects INNER JOIN profiles ON projects.author_id = profiles.id"
	query_where_project = "WHERE REPLACE(LOWER(name), ' - ', ' ') = '[*]'"
)

pub fn (mut app App) get_projects() []Project
{
	mut projects := []Project{}
	rows, _ := app.db.exec("$query_all_projects;")
	

	for _, row in rows {
		data := row.vals

		mut content := mruby.unescape(data[4])
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
				content: markdown.to_html( mruby.unescape(data[4]) )
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