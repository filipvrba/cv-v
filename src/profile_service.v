module src

import json
import encoding.base32

const(
	query_all_profiles = "SELECT * FROM profiles"
	query_pcount = "SELECT (SELECT COUNT(*) FROM articles WHERE author_id = [*]) " +
		"AS c_articles, (SELECT COUNT(*) FROM projects WHERE author_id = [*]) AS c_projects"
)

pub fn (mut app App) add_profile(profile Profile) {

	// println( app.db.exec("select full_name from profiles where full_name=$profile.full_name")[0] )

	// if full_name_len == 0 {
	// 	sql app.db {
	// 		insert profile into Profile
	// 	}
	// }
}

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
				count: app.get_pcount(id)
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

pub fn (mut app App) get_encode_json_profiles(profiles []Profile) string
{
	s_profiles_json := json.encode(profiles)
	encode_json_profiles := base32.encode_string_to_string(s_profiles_json)

	return encode_json_profiles
}
