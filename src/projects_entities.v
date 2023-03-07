module src

struct Project {
	id		  	int
	create_at   int
mut:
	author 		string
	name 	  	string
	category	string
	content	  	string
	last_change int
}

struct ApiProject {
	id			int
	author_id 	int
	name 		string
	category 	string
	content 	string
	query		string
}
