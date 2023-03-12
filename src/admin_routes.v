module src

import vweb
import json
import crypto.md5
import time

[get; '/admin']
pub fn(mut app App) admin_index() vweb.Result
{
	if app.is_logged_in()
	{
		title := "Admin"
		author_id := app.get_profiles(true)[0].id
		profiles := app.get_profile(author_id)
		full_name := profiles[0].full_name

		artilces := app.get_articles(author_id)
		data_articles := app.get_encode_json_articles(artilces)

		projects := app.get_projects(author_id)
		data_projects := app.get_encode_json_projects(projects)

		return $vweb.html()
	} else {
		return app.redirect_to_admin_login()
	}
}

[get; '/admin/login']
pub fn(mut app App) admin_login() vweb.Result
{
	if app.is_logged_in() {
		return app.redirect_to_admin()
	} else {
		title := "Login | Admin"
		author_id := app.get_profiles(true)[0].id
		profiles := app.get_profile(author_id)
		full_name := profiles[0].full_name

		return $vweb.html()
	}
}

[post; '/admin/login']
pub fn(mut app App) admin_logging_in() vweb.Result
{
	password_form := md5.hexhash( app.Context.form['password'] )
	author_id := app.get_profiles(true)[0].id
	password_db := app.get_profile_password(author_id)

	if password_form == password_db {
		app.set_cookie_logged_in(1)
		return app.redirect_to_admin()
	}
	else {
		return app.redirect_to_admin_login()
	}
}

[post; '/admin/article/free']
pub fn(mut app App) admin_article_free() vweb.Result
{
	if app.is_logged_in() {
		api_article := json.decode(ApiArticle, app.Context.req.data) or {
			ApiArticle{}
		}

		app.free_article(api_article)
		return app.redirect_to_admin()
	}
	else {
		return app.redirect_to_admin_login()
	}
}
