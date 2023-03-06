import DataElement from "./data_element.js";

export default class ElmArticles extends DataElement {
  constructor() {
    super();
    this._l_hash_change = () => this.hash_change(location.hash.replace("#", ""));
    this.init_elm()
  };

  connectedCallback() {
    window.addEventListener(ElmArticles.HASH_EVENT, this._l_hash_change)
  };

  disconnectedCallback() {
    window.removeEventListener(
      ElmArticles.HASH_EVENT,
      this._l_hash_change
    )
  };

  init_elm() {
    let l_acc_item = () => {
      let result = "";

      for (let i = 0; i < this._data.length; i++) {
        let article = this._data[i];
        let article_id = `${i}-${article.name.url_form()}`;
        let template = `${`
<div id='${article_id}' class='accordion-item'>
  <h2 class='accordion-header' id='heading_${article_id}'>
    <button id='button_${article_id}' class='accordion-button collapsed' type='button' data-bs-toggle='collapse' data-bs-target='#collapse_${article_id}' aria-expanded='false' aria-controls='collapse_${article_id}'>
      <p class='h5 mb-0'>${article.name}</p>
    </button>
  </h2>
  <div id='collapse_${article_id}' class='accordion-collapse collapse ${this.show(article_id)}' aria-labelledby='heading_${article_id}' data-bs-parent='#accordionArticles'>
    <div class='accordion-body'>
      
      <div class='mb-3'>
        <div class='row g-0'>
          <div class='container'>
            <div class='card-body'>
              <p class='card-text'>${article.description}</p>
              <div class='row g-0'>
                <div class='col-6' style='margin-top: auto; margin-bottom: auto;'>
                  <p class='card-text'><small class='text-muted'><a href='/projects/${article.project.url_form()}'>${article.project}</a> | ${article.created_at.to_date()}</small></p>
                </div>

                <div class='col-6 text-center'>
                  <div class='btn-group'>
                    <a href='${article.url}' target='_blank' class='btn btn-primary card-text'>Read...</a>
                    <button type='button' class='btn btn-primary dropdown-toggle dropdown-toggle-split' data-bs-toggle='dropdown' aria-expanded='false'>
                      <span class='visually-hidden'>Toggle Dropdown</span>
                    </button>
                    <ul class='dropdown-menu' style=''>
                      <li>
                        <button class='dropdown-item' onclick='navigator.clipboard.writeText("${location.origin}/articles/#${article_id}")'>Copy Link</button>
                      </li>
                    </ul>
                  </div>
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
  };

  show(id) {
    let result = "";
    if (id == location.hash.replace("#", "")) result = "show";
    return result
  };

  hash_change(id) {
    let item = document.getElementById(id);

    if (item) {
      let collapse = document.getElementById(`collapse_${id}`);

      if (collapse.className.indexOf("show") == -1) {
        let button = document.getElementById(`button_${id}`);
        button.click()
      }
    }
  }
};

ElmArticles.HASH_EVENT = "hashchange"