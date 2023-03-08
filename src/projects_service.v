module src

import json
import encoding.base32
import markdown
import regex
import time
import net.urllib

const (
	query_all_projects = "SELECT projects.id, full_name as author, name, category, content, projects.created_at, last_change FROM projects INNER JOIN profiles ON projects.author_id = profiles.id"
	query_where_project = "WHERE REPLACE(LOWER(name), ' - ', ' ') = '[*]'"
	query_where_author_project = "WHERE projects.author_id = [0]"
	query_sort_projects = "ORDER BY last_change DESC LIMIT 3"
	query_update_project = "UPDATE projects SET [0] WHERE id = [1]"
	query_add_project = "INSERT INTO projects (author_id, name, category, content, created_at, last_change) " +
		"VALUES ([0], '[1]', '[2]', '[3]', [4], [4])"
	query_free_project = "DELETE FROM projects WHERE id = [0]"
	query_create_projects = "CREATE TABLE projects (" +
		"id INTEGER PRIMARY KEY AUTOINCREMENT, " +
		"author_id INTEGER, " +
		"name TEXT(60) UNIQUE NOT NULL, " +
		"category TEXT, " +
		"content TEXT, " +
		"created_at INTEGER, " +
		"last_change INTEGER" +
	");"
	query_free_projects = "DROP TABLE projects"
)

pub fn (mut app App) get_projects(author_id int) []Project
{
	mut query := query_all_projects
	if author_id > -1 {
		query += " ${query_where_author_project.replace('[0]', author_id.str())}"
	}

	mut projects := []Project{}
	rows, _ := app.db.exec("$query;")

	for _, row in rows {
		data := row.vals

		mut content := urllib.query_unescape(data[4]) or {""}
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

pub fn (mut app App) get_top_projects(author_id int) []Project
{
	query := "$query_all_projects ${query_where_author_project.replace('[0]', author_id.str())} $query_sort_projects;"
	rows, _ := app.db.exec(query)
	mut projects := []Project{}

	if rows.len > 0 {
		for _, row in rows {
			data := row.vals

			mut content := urllib.query_unescape(data[4]) or {""}
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
				content: markdown.to_html( urllib.query_unescape(data[4]) or {""} )
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

pub fn (mut app App) set_project(api_project ApiProject) int
{
	query := query_add_project
		.replace('[0]', api_project.author_id.str())
		.replace('[1]', api_project.name)
		.replace('[2]', api_project.category)
		.replace('[3]', api_project.content)
		.replace('[4]', time.now().unix.str()) + ";"
	result_code := app.db.exec_none(query)
	return result_code
}

pub fn (mut app App) free_project(api_project ApiProject) int
{
	query := query_free_project
		.replace('[0]', api_project.id.str()) + ";"
	result_code := app.db.exec_none(query)
	return result_code
}

pub fn (mut app App) update_project(api_project ApiProject) int
{
	query := query_update_project
		.replace('[0]', "$api_project.query, last_change=${time.now().unix}")
		.replace('[1]', api_project.id.str()) + ";"

	result_code := app.db.exec_none(query)
	return result_code
}

pub fn (mut app App) create_projects() int
{
	query := query_create_projects
	result_code := app.db.exec_none("$query")
	return result_code
}

pub fn (mut app App) free_projects() int
{
	query := query_free_projects
	result_code := app.db.exec_none("$query")
	return result_code
}

pub fn (mut app App) get_encode_json_projects(projects []Project) string
{
	s_projects_json := json.encode(projects)
	encode_json_projects := base32.encode_string_to_string(s_projects_json)

	return encode_json_projects
}