import DataElement from "./data_element.js";

export default class ElmTopProjects extends DataElement {
  constructor() {
    super();
    this.init_elm()
  };

  connectedCallback() {};
  disconnectedCallback() {};

  init_elm() {
    let l_projects = () => {
      let result = "";

      for (let i = 0; i < this._data.length; i++) {
        let project = this._data[i];
        let md_img = project.content.split(" ")[0];
        let src_img = md_img.replace(")", "").split("(")[1];
        if (!src_img) src_img = "";
        let content = project.content;
        if (src_img) content = project.content.replace(md_img, "").trim();
        let template = `${`
        <div class='col-lg-4 text-center'>
          <img src='${src_img}' class='bd-placeholder-img rounded-circle' width='140' height='140' />
          <h2 class='fw-normal'>${project.name}</h2>
          <p>${content}</p>
          <p><a class='btn btn-secondary' href='/projects/${project.name.url_form()}'>See details</a></p>
        </div>
        `}`;
        result += template
      };

      return result
    };

    let template = `${`
    <div class='row justify-content-center'>
      ${l_projects.call()}
    </div>
    `}`;
    this.innerHTML = template
  }
}