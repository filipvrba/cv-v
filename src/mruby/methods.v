module mruby

pub fn unescape(str string) string
{
	return mrb_code("eval %Q{'$str'}")
}
