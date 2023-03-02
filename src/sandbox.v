module src

pub fn (mut app App) create_tables()
{
	sql app.db {
		create table Profile
	}
	sql app.db {
		create table Project
	}
}