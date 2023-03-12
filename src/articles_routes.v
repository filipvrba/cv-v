module src

import vweb

['/articles']
pub fn(mut app App) articles_index() vweb.Result
{
	title := "Articles"
	author_id := app.get_profiles(true)[0].id
	articles := app.get_articles(author_id)
	data := app.get_encode_json_articles(articles)

	return $vweb.html()
}

[get; '/admin/article/edit/:id']
pub fn(mut app App) article_edit(id int) vweb.Result
{
	if app.is_logged_in() {
		article := app.get_article(id)[0]
		title := "$article.name | Edit"
		data := app.get_encode_json_article(article)

		return $vweb.html()
	}
	else {
		return app.redirect_to_admin_login()
	}
}

[post; '/admin/article/edit/:id']
pub fn(mut app App) post_article_edit(id int) vweb.Result
{
	if app.is_logged_in() {
		form := app.Context.form.clone()
		api_article := ApiArticle{
			id: id
			query: "name=\'${form['name']}\', author_id=${form['author_id']}, " +
				"project_id=${form['project_id']}, url=\'${form['url']}\', " +
				"description=\'${form['description']}\'"
		}

		code_result := app.update_article(api_article)
		message := Message{
			status_code: StatusCode{
				code: code_result
			}
		}
		return app.json(message)
	}
	else {
		return app.redirect_to_admin_login()
	}
}

[get; '/admin/article/add']
pub fn(mut app App) article_add() vweb.Result
{
	if app.is_logged_in() {
		title := "Add | Article"

		return $vweb.html()
	}
	else {
		return app.redirect_to_admin_login()
	}
}

[post; '/admin/article/add']
pub fn(mut app App) post_admin_article_add() vweb.Result
{
	if app.is_logged_in() {
		form := app.Context.form.clone()
		api_article := ApiArticle{
			name: form['name']
			author_id: form['author_id'].int()
			project_id: form['project_id'].int()
			url: form['url']
			description: form['description']
		}

		code_result := app.add_article(api_article)
		message := Message{
			status_code: StatusCode{
				code: code_result
			}
		}
		return app.json(message)
	}
	else {
		return app.redirect_to_admin_login()
	}
}
