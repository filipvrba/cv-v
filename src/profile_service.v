module src

import json
import encoding.base32
import time
import crypto.md5

const(
	query_all_profiles = "SELECT * FROM profiles"
	query_pcount = "SELECT (SELECT COUNT(*) FROM articles WHERE author_id = [*]) " +
		"AS c_articles, (SELECT COUNT(*) FROM projects WHERE author_id = [*]) AS c_projects"
	query_add_profile = "INSERT INTO profiles (full_name, avatar, email, phone, bio, created_at, is_author, password) " +
		"VALUES ('[0]', '[1]', '[2]', '[3]', '[4]', [5], [6], '[7]')"
	query_free_profile = "DELETE FROM profiles WHERE id = [0]"
	query_update_profile = "UPDATE profiles SET [0] WHERE id = [1]"
	query_where_author = "WHERE is_author = 1"
	query_create_profiles = "CREATE TABLE profiles (" +
		"id INTEGER PRIMARY KEY AUTOINCREMENT, " +
		"full_name TEXT, " +
		"avatar TEXT, " +
		"email TEXT, " +
		"phone TEXT, " +
		"bio TEXT, " +
		"created_at INTEGER, " +
		"is_author INTEGER, " +
		"password TEXT" +
	");"
	query_free_profiles = "DROP TABLE profiles"
)

pub fn (mut app App) get_pcount(author_id int) PCount
{
	query := "${query_pcount.replace('[*]', author_id.str())};"
	rows, _ := app.db.exec(query)
	mut pcount := PCount{
		articles: -1,
		projects: -1
	}

	if rows.len > 0 {
		for _, row in rows {
			data := row.vals
			pcount = PCount{
				articles: data[0].int(),
				projects: data[1].int()
			}
		}
	}
	else {
		eprintln("No results were found when looking for Projects and Articles in the query.")
	}

	return pcount
}

pub fn (mut app App) get_profile_password(id int) string
{
	query := "$query_all_profiles WHERE id = $id;"
	rows, _ := app.db.exec(query)
	mut profile := ""

	if rows.len > 0 {
		for _, row in rows {
			data := row.vals
			profile = data[8]
		}
	}
	else {
		eprintln("No results were found when looking for Profiles in the query.")
		profile = -1.str()
	}

	return profile
}

pub fn (mut app App) get_profile(id int) []Profile
{
	query := "$query_all_profiles WHERE id = $id;"
	rows, _ := app.db.exec(query)
	mut profiles := []Profile{}

	if rows.len > 0 {
		for _, row in rows {
			data := row.vals
			profiles << Profile{
				id: data[0].int()
				full_name: data[1],
				avatar: data[2],
				email: data[3],
				phone: data[4],
				bio: data[5],
				created_at: data[6].int(),
				count: app.get_pcount(id),
				is_author: data[7].int()
			}
		}
	}
	else {
		eprintln("No results were found when looking for Profiles in the query.")
		profiles << Profile{
			id: -1
		}
	}

	return profiles
}

pub fn (mut app App) get_profiles(is_select_author bool) []Profile
{
	mut query := query_all_profiles
	if is_select_author {
		query += " $query_where_author"
	}

	rows, _ := app.db.exec("$query;")
	mut profiles := []Profile{}

	if rows.len > 0 {
		for _, row in rows {
			data := row.vals
			profiles << Profile{
				id: data[0].int()
				full_name: data[1],
				avatar: data[2],
				email: data[3],
				phone: data[4],
				bio: data[5],
				created_at: data[6].int(),
				count: app.get_pcount(data[0].int()),
				is_author: data[7].int()
			}
		}
	}
	else {
		eprintln("No results were found when looking for Profiles in the query.")
		profiles << Profile{
			id: -1
		}
	}

	return profiles
}

pub fn (mut app App) add_profile(api_profile ApiProfileTwo) int
{
	password := md5.hexhash(api_profile.password).str()
	query := query_add_profile
		.replace('[0]', api_profile.full_name)
		.replace('[1]', api_profile.avatar)
		.replace('[2]', api_profile.email)
		.replace('[3]', api_profile.phone)
		.replace('[4]', api_profile.bio)
		.replace('[5]', time.now().unix.str())
		.replace('[6]', api_profile.is_author.str())
		.replace('[7]', password) + ";"

	result_code := app.db.exec_none(query)
	return result_code
}

pub fn (mut app App) free_profile(api_profile ApiProfileTwo) int
{
	query := query_free_profile
		.replace('[0]', api_profile.id.str()) + ";"
	result_code := app.db.exec_none(query)
	return result_code
}

pub fn (mut app App) update_profile(api_profile ApiProfileTwo) int
{
	query := query_update_profile
		.replace('[0]', api_profile.query)
		.replace('[1]', api_profile.id.str()) + ";"

	result_code := app.db.exec_none(query)
	return result_code
}

pub fn (mut app App) create_profiles() int
{
	query := query_create_profiles
	result_code := app.db.exec_none("$query")
	return result_code
}

pub fn (mut app App) free_profiles() int
{
	query := query_free_profiles
	result_code := app.db.exec_none("$query")
	return result_code
}

pub fn (mut app App) get_encode_json_profiles(profiles []Profile) string
{
	s_profiles_json := json.encode(profiles)
	encode_json_profiles := base32.encode_string_to_string(s_profiles_json)

	return encode_json_profiles
}
