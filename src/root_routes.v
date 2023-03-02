module src

import vweb

['/']
pub fn(mut app App) root_index() vweb.Result
{
	title := "Home"

	return $vweb.html()
}