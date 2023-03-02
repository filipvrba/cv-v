module src

import vweb

pub fn main() {
	server_new()
}

pub fn (mut app App) redirect_to_index() vweb.Result {
	return app.redirect('/')
}
