module src

const(
	query_all_profiles = "SELECT * FROM profiles"
)

pub fn (mut app App) add_profile(profile Profile) {

	// println( app.db.exec("select full_name from profiles where full_name=$profile.full_name")[0] )

	// if full_name_len == 0 {
	// 	sql app.db {
	// 		insert profile into Profile
	// 	}
	// }
}

pub fn (mut app App) get_profile(id int) ![]Profile
{
	query := "$query_all_profiles WHERE id = $id;"
	rows, _ := app.db.exec(query)

	if rows.len > 0 {
		mut profiles := []Profile{}

		for _, row in rows {
			data := row.vals
			profiles << Profile{
				id: data[0].int()
				full_name: data[1],
				avatar: data[2],
				email: data[3],
				phone: data[4],
				bio: data[5],
				created_at: data[6].int()
			}
		}
		return profiles
	}
	else {
		return error("Id $id not found.")
	}
}