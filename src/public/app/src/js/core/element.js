export default class Element {
  static find_headers() {
    let node_list = [];
    node_list.push(document.querySelectorAll("h1"));
    node_list.push(document.querySelectorAll("h2"));
    node_list.push(document.querySelectorAll("h3"));
    return node_list
  };

  static add_ids(headers) {
    headers.forEach(node_list => (
      node_list.forEach((element) => {
        let name = element.innerText.url_form().toLowerCase().replace(
          ".",
          ""
        );

        element.setAttribute("id", name)
      })
    ))
  }
}