module src

import vweb
import db.sqlite
import os
// import time

const (
	port = 8080
	static_dir = 'src/public'
    token = os.environ()["CV_TOKEN"]
	web_year = 2023
)

struct App {
    vweb.Context

pub mut:
	logged_in bool
	db sqlite.DB
	year int = web_year
}

struct Health {
	status_code int
	status string
}

pub fn server_new()
{
	vweb.run_at(new_app(), vweb.RunParams{
        port: port
    }) or { panic(err) }
}

fn new_app() &App {
    mut app := &App{
		db: sqlite.connect('cv.sqlite') or { panic(err) }
	}

	app.handle_static(static_dir, true)

    return app
}

pub fn (mut app App) health() vweb.Result {
	context := Health{ 200, "ok" }
	return app.json(context)
}
