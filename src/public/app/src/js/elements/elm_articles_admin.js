import DataElement from "./data_element.js";

export default class ElmArticlesAdmin extends DataElement {
  constructor() {
    super();
    this._spinner = document.getElementById("spinner_articles");
    this.init_elm()
  };

  init_elm() {
    let template = `${`\n    `}`;
    this._spinner.remove();
    this.innerHTML = template
  }
}