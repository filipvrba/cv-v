module src

import vweb

['/profile']
pub fn(mut app App) profile_index() vweb.Result
{
	title := "Profile"
	profiles := app.get_profile(1)
	data := app.get_encode_json_profiles(profiles)

	return $vweb.html()
}
