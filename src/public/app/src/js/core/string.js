function gsub(...args) {
  let result = this;

  if (result != "" && result != null) {
    while (true) {
      if (result.indexOf(args[0]) == -1) break;
      result = result.replace(args[0], args[1])
    }
  };

  return result
};

String.prototype.gsub = gsub;

function url_form() {
  return this.gsub(" ", "-").toLowerCase()
};

String.prototype.url_form = url_form