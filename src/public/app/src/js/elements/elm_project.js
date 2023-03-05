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
    <article class='blog-post'>
      <h1 class='pb-4 mb-4'>${this._data.name}</h1>
      <div class='pb-4 mb-4'>
        ${this._md.render(this._data.content)}
      </div>

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