import DataElement from "./data_element.js";

export default class ElmProfile extends DataElement {
  constructor() {
    super();
    this._data = this._data[0];
    this.init_elm()
  };

  connectedCallback() {};
  disconnectedCallback() {};

  init_elm() {
    let template = `${`
      <div class='d-flex flex-column flex-md-row align-items-center pb-3 mb-4 pt-3 mt-4'>
        <div class='col-6 col-md-6'>
          <img src='${this._data.avatar}' class='rounded mx-auto d-block' alt='profile_avatar' style='max-width: 100%; max-height: 256px;'>
        </div>
        <div class='col-6 col-md-6'>
          <p class='display-3 pt-3 mt-4'>${this._data.full_name}</p>
          <ul class='list-unstyled d-flex align-items-center'>
            <li class='ms-3'>
              <p class='fs-4 text-muted fa fa-vcard-o'></p>
            </li>
            <li class='ms-3'>
              <p class='fs-5 text-muted'>${this._data.email}</p>
            </li>
          </ul>
        </div>
      </div>
      <div class='pricing-header p-3 pb-md-4 mx-auto text-center'>
        <h2>Bio</h2>
        <p class='fs-5 text-muted'>${this._data.bio}</p>
      </div>
      
      <div class='row text-center'>
        <h2>Created</h2>
        <div class='col-6'>
          <p class='h1'>${this._data.count.articles}</p>
          <p class='fs-5 text-muted'>Articles<p>
        </div>
        <div class='col-6'>
          <p class='h1'>${this._data.count.projects}</p>
          <p class='fs-5 text-muted'>Projects<p>
        </div>
      </div>

    `}`;
    console.log(this._data);
    this.innerHTML = template
  }
}