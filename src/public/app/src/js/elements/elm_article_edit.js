import DataElement from "./data_element.js";

export default class ElmArticleEdit extends DataElement {
  constructor() {
    super();
    this.init_elm()
  };

  init_elm() {
    let template = `${`\n    `}`;
    console.log(this._data);
    this.innerHTML = template
  }
}