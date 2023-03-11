module src 

import crypto.rand
import json
import encoding.base32
import time

fn generate_token(length int) string {
    mut admin_token := ""
    for _ in 0..length {
        admin_token += rand.int_u64(256) or {0}.str()
    }

    return admin_token
}

pub fn (mut app App) get_encode_json_admin_logged_in(admin_logged_in AdminLoggedIn) string
{
	s_admin_logged_in_json := json.encode(admin_logged_in)
	encode_json_admin_logged_in := base32.encode_string_to_string(s_admin_logged_in_json)

	return encode_json_admin_logged_in
}

pub fn (mut app App) set_cookie_logged_in(value int) {
	time_expire_unix := time.now().unix + (60 * 60)
	time_expire := time.unix(time_expire_unix)

	app.set_cookie_with_expire_date("is_logged_in", value.str(), time_expire)
}

pub fn (mut app App) get_cookie_logged_in() string {
	return app.get_cookie("is_logged_in") or { "0" }
}

pub fn (mut app App)is_logged_in() bool {
	return app.get_cookie_logged_in() == 1.str()
}
