import DataElement from "./data_element.js";

export default class ElmArticles extends DataElement {
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
        let article = this._data[i];
        let template = `${`
<div class='accordion-item'>
  <h2 class='accordion-header' id='heading_${i}'>
    <button class='accordion-button collapsed' type='button' data-bs-toggle='collapse' data-bs-target='#collapse_${i}' aria-expanded='false' aria-controls='collapse_${i}'>
      <p id='${i}-${article.name.url_form()}' class='h5 mb-0'>${article.name}</p>
    </button>
  </h2>
  <div id='collapse_${i}' class='accordion-collapse collapse' aria-labelledby='heading_${i}' data-bs-parent='#accordionArticles'>
    <div class='accordion-body'>
      
    <div class='mb-3'>
      <div class='row g-0'>
        <div class='container'>
          <div class='card-body'>
            <p class='card-text'>${article.description}</p>
            <div class='row g-0'>
              <div class='col-6' style='margin-top: auto; margin-bottom: auto;'>
                <p class='card-text'><small class='text-muted'>${article.project} | ${article.created_at.to_date()}</small></p>
              </div>
              <div class='col-6 text-center'>
                <a href='${article.url}' target='_blank' class='btn btn-primary card-text'>Read...</a>
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
      <div class='accordion' id='accordionArticles'>
        ${l_acc_item.call()}
      </div>
    `}`;
    this.innerHTML = template
  }
}