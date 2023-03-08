module src

import vweb

['/profile']
pub fn(mut app App) profile_index() vweb.Result
{
	title := "Profile"
	author_id := app.get_profiles(true)[0].id
	profiles := app.get_profile(author_id)
	data := app.get_encode_json_profiles(profiles)

	return $vweb.html()
}
