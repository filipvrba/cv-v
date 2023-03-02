import DataElement from "./data_element.js";

export default class ElmProjects extends DataElement {
  constructor() {
    super();
    this.init_elm()
  };

  connectedCallback() {};
  disconnectedCallback() {};

  init_elm() {
    console.log(this._data);
    let template = `${`\n        \n    `}`;
    this.innerHTML = template
  }
}