import DataElement from "./data_element.js";

export default class ElmProjects extends DataElement {
  constructor() {
    super();
    this._data = this._data[0];
    this._md = window.markdownit({breaks: true, html: true});
    this.init_elm()
  };

  connectedCallback() {};
  disconnectedCallback() {};

  init_elm() {
    let template = `${`
    <div class='pricing-header p-3 pb-md-4 mx-auto text-center'>
        <h1 class='display-4 fw-normal'>${this._data.name}</h1>
    </div>
    <article class='blog-post mx-auto col-lg-9'>
      <div class='md-html' class='pb-4 mb-4'>
        ${this._md.render(this._data.content)}
      </div>
      <hr>
      <ul class='list-inline'>
        <li class='list-inline-item'>
          <p class='fa fa-user-o'></p>
          ${this._data.author}
        </li>
        <li class='list-inline-item'>
          <p class='fa fa-folder-o'></p>
          ${this._data.category}
        </li>
        <li class='list-inline-item'>
          <p class='fa fa-calendar-o'></p>
          ${this._data.create_at.to_date()}
        </li>
      </ul>
    </article>
    `}`;
    this.innerHTML = template
  }
}