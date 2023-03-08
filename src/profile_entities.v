module src

struct PCount {
	articles int
	projects int
}

struct Profile {
	id		   int
	created_at int
mut:
	is_author int
	full_name string
	avatar	  string
	email     string
	phone	  string
	bio		  string
	count	  PCount
}

struct ApiProfileTwo {
	id 		  int
	is_author int
	full_name string
	avatar	  string
	email     string
	phone	  string
	bio		  string
	query	  string
}
