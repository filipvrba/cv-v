module src

import time

struct Profile {
	id		   int [primary; sql: serial]
	created_at time.Time
mut:
	full_name string
	avatar	  string
	email     string
	phone	  string
	bio		  string
}