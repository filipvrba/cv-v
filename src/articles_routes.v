module src

import vweb

['/articles']
pub fn(mut app App) articles_index() vweb.Result
{
	title := "Articles"
	articles := app.get_articles()
	data := app.get_encode_json_articles(articles)

	return $vweb.html()
}
