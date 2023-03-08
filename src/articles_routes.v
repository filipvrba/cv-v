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
