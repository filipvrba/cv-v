module src

import json
import encoding.base32
import time

const (
	query_all_articles = "SELECT articles.id, profiles.full_name, projects.name, articles.name, description, url, articles.created_at FROM articles " +
							"INNER JOIN profiles ON articles.author_id = profiles.id " +
							"INNER JOIN projects ON articles.project_id = projects.id"
	query_sort_articles = "ORDER BY articles.created_at DESC LIMIT 3"
	query_add_article = "INSERT INTO articles (author_id, project_id, name, description, url, created_at) " +
		"VALUES ([0], [1], '[2]', '[3]', '[4]', [5])"
	query_free_article = "DELETE FROM articles WHERE id = [0]"
	query_update_article = "UPDATE articles SET [0] WHERE id = [1]"
)

pub fn (mut app App) get_articles() []Article
{
	query := "$query_all_articles;"
	rows, _ := app.db.exec(query)
	mut articles := []Article{}

	if rows.len > 0 {
		for _, row in rows {
			data := row.vals

			articles << Article{
				id: data[0].int()
				author: data[1]
				project: data[2]
				name: data[3]
				description: data[4]
				url: data[5]
				created_at: data[6].int()
			}
		}
	}
	else {
		eprintln("No results were found when looking for Artiles in the query.")
		articles << Article{
			id: -1
		}
	}

	return articles
}

pub fn (mut app App) get_top_articles() []Article
{
	query := "$query_all_articles $query_sort_articles;"
	rows, _ := app.db.exec(query)
	mut articles := []Article{}

	if rows.len > 0 {
		for _, row in rows {
			data := row.vals

			articles << Article{
				id: data[0].int()
				author: data[1]
				project: data[2]
				name: data[3]
				description: data[4]
				url: data[5]
				created_at: data[6].int()
			}
		}
	}
	else {
		eprintln("No results were found when looking for Artiles in the query.")
		articles << Article{
			id: -1
		}
	}

	return articles
}

pub fn (mut app App) add_article(api_article ApiArticle) int
{
	query := query_add_article
		.replace('[0]', api_article.author_id.str())
		.replace('[1]', api_article.project_id.str())
		.replace('[2]', api_article.name)
		.replace('[3]', api_article.description)
		.replace('[4]', api_article.url)
		.replace('[5]', time.now().unix.str()) + ";"
	result_code := app.db.exec_none(query)
	return result_code
}

pub fn (mut app App) free_article(api_article ApiArticle) int
{
	query := query_free_article
		.replace('[0]', api_article.id.str()) + ";"
	result_code := app.db.exec_none(query)
	return result_code
}

pub fn (mut app App) update_article(api_article ApiArticle) int
{
	query := query_update_article
		.replace('[0]', api_article.query)
		.replace('[1]', api_article.id.str()) + ";"

	result_code := app.db.exec_none(query)
	return result_code
}

pub fn (mut app App) get_encode_json_articles(articles []Article) string
{
	s_articles_json := json.encode(articles)
	encode_json_articles := base32.encode_string_to_string(s_articles_json)

	return encode_json_articles
}
