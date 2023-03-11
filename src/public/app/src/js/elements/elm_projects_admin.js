import DataElement from "./data_element.js";

export default class ElmProjectsAdmin extends DataElement {
  constructor() {
    super();
    this._spinner = document.getElementById("spinner_projects");
    this.init_elm()
  };

  init_elm() {
    let template = `${`\n    `}`;
    this._spinner.remove();
    this.innerHTML = template
  }
}