module src

import json
import encoding.base32

const (
	query_all_articles = "SELECT articles.id, profiles.full_name, projects.name, articles.name, description, url, articles.created_at FROM articles " +
							"INNER JOIN profiles ON articles.author_id = profiles.id " +
							"INNER JOIN projects ON articles.project_id = projects.id"
	query_sort_articles = "ORDER BY articles.created_at DESC LIMIT 3"
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

pub fn (mut app App) get_encode_json_articles(articles []Article) string
{
	s_articles_json := json.encode(articles)
	encode_json_articles := base32.encode_string_to_string(s_articles_json)

	return encode_json_articles
}
