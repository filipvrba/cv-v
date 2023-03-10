import DataElement from "./data_element.js";

export default class ElmGreet extends DataElement {
  constructor() {
    super();
    this._data = this._data[0];
    this._spinner = document.getElementById("spinner_greet");
    this.init_elm()
  };

  init_elm() {
    let template = `${`
    <div class='row justify-content-center pb-3 mb-4 pt-3 mt-4'>
      <div class='col-lg-6'>
        <p class='h1 m-0'>Resources for a CV With More Clarity</p>
        <ul class='nav list-unstyled d-flex align-items-center'>
          <li class='ms-3'>
          <img src='${this._data.avatar}' class='rounded d-block mb-3 mt-3' width='50' height='50' />
          </li>
          <li class='ms-3'>
            <p class='m-0'><strong>by ${this._data.full_name}</strong></p>
          </li>
        </ul>
        <p>Need more information about my <strong>projects</strong>?</p>
        <p>
          In the written <strong>articles</strong>, I'll take you through how a few <strong>projects</strong> have developed.
          Due to the diversity of each project, I categorize its location and specify its purpose.
        </p>

        <hr>

        <div class='row align-items-center'>
          <div class='col-1'>
            <p class='fs-2 fa fa-flag-o'></p>
          </div>
          <div class='col'>
            <p class='fs-6'>
              <strong>${this._data.count.articles} articles</strong> and <strong>${this._data.count.projects} projects</strong>
              have already been created.
            </p>
          </div>
        </div>
      </div>
    </div>
    `}`;
    this._spinner.remove();
    this.innerHTML = template
  }
}