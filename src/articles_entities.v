module src

struct Article {
	id		   	int
	created_at 	int
mut:
	author		string
	project 	string
	name 		string
	description string
	url			string
}

struct ApiArticle {
	id 			int
	author_id 	int
	project_id 	int
	name 		string
	description string
	url 		string
	query		string
}
