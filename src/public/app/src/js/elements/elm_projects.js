import DataElement from "./data_element.js";

export default class ElmProjects extends DataElement {
  constructor() {
    super();
    this.init_elm()
  };

  connectedCallback() {};
  disconnectedCallback() {};

  init_elm() {
    let l_acc_item = () => {
      let result = "";

      for (let i = 0; i < this._data.length; i++) {
        let project = this._data[i];
        let template = `${`
<div class='accordion-item'>
  <h2 class='accordion-header' id='heading_${i}'>
    <button class='accordion-button collapsed' type='button' data-bs-toggle='collapse' data-bs-target='#collapse_${i}' aria-expanded='false' aria-controls='collapse_${i}'>
      <strong>${project.name}</strong>
    </button>
  </h2>
  <div id='collapse_${i}' class='accordion-collapse collapse' aria-labelledby='heading_${i}' data-bs-parent='#accordionProjects'>
    <div class='accordion-body'>
      
    <div class='mb-3'>
      <div class='row g-0'>
        <div class='col-md-4'>
          <img src='/vite.svg' class='img-fluid rounded-start' alt='...'>
        </div>
        <div class='col-md-8'>
          <div class='card-body'>
            <p class='card-title'>${project.category}</p>
            <p class='card-text'>${project.content}</p>
            <div class='row g-0'>
              <div class='col-md-6'>
                <p class='card-text'><small class='text-muted'>Last updated ${project.last_change.to_date()}</small></p>
              </div>
              <div class='col-md-6 text-center'>
                <a href='/projects/${project.name.url_form()}' class='btn btn-primary card-text'>See details</a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    </div>
  </div>
</div>
        `}`;
        result += `${template}\n`
      };

      return result
    };

    let template = `${`
<div class='accordion' id='accordionProjects'>
  ${l_acc_item.call()}
</div>
    `}`;
    this.innerHTML = template
  }
}