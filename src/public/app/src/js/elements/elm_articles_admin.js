import DataElement from "./data_element.js";
import Data from "../core/data.js";

export default class ElmArticlesAdmin extends DataElement {
  constructor() {
    super();
    this._spinner = document.getElementById("spinner_articles");
    this.init_elm();
    window.click_article_edit = this.click_article_edit.bind(this);
    window.click_article_free = this.click_article_free.bind(this)
  };

  init_elm() {
    let template;

    if (this._data.length == 1 && this._data[0].id == -1 || this._data.length == 0) {
      template = `${`
      <div class='text-center'>
        <a class='h4' href='${ElmArticlesAdmin.LINK_ADD}'>
          <p>
            <p class='mb-0 fa fa-plus'></p>
            Add
          </p>
        </a>
      </div>
      `}`
    } else {
      let l_tbody = () => {
        let result = "";

        for (let i = 0; i < this._data.length; i++) {
          let article = this._data[i];
          let s_td = `${`
            <tr id='article-${article.id}'>
              <th scope='row' class='text-start'>${article.name}</a>
              </th>
              <th scope='row' class='text-center'>${article.id}</th>
              <th scope='row' class='text-center'>${article.created_at}</th>
              <th scope='row' class='text-center'>
                <div class='btn-group'>
                  <button type='button' class='btn btn-primary' onclick='click_article_edit(${article.id})'>Edit</button>
                  <button type='button' class='btn btn-primary dropdown-toggle dropdown-toggle-split' data-bs-toggle='dropdown' aria-expanded='false'>
                    <span class='visually-hidden'>Toggle Dropdown</span>
                  </button>
                  <ul class='dropdown-menu' style=''>
                    <li>
                      <button type='button' class='dropdown-item' onclick='click_article_free(${article.id})'>Free</button>
                    </li>
                  </ul>
                </div>
              </th>
            </tr>
          `}`;
          result += `${s_td}\n`
        };

        return result
      };

      template = `${`
        <div class='table-responsive'>
          <table class='table text-center'>
            <thead>
              <tr>
                <th style='width: 31%; text-align: left;'>
                  <a href='${ElmArticlesAdmin.LINK_ADD}'>
                    <p class='mb-0 fa fa-plus'></p>
                    Add
                  </a>
                </th>
                <th style='width: 22%;'>ID</th>
                <th style='width: 22%;'>Create At</th>
                <th style='width: 22%;'>Action</th>
              </tr>
            </thead>
            <tbody>
              ${l_tbody.call()}
            </tbody>
          </table>
        </div>
      `}`
    };

    this._spinner.remove();
    this.innerHTML = template
  };

  click_article_edit(id) {
    location.replace(`/admin/article/edit/${id}`)
  };

  click_article_free(id) {
    let is_ok = window.confirm(`Would you really like to remove this '${id}' article?`);

    if (is_ok) {
      let data = {id};
      Data.post(data, "admin/article/free");
      this.remove_article(id)
    }
  };

  remove_article(id) {
    let elm_article = document.getElementById(`article-${id}`);
    elm_article.remove();
    let data = this._data;

    for (let i = 0; i <= data.length; i++) {
      let article = data[i];

      if (article.id == id) {
        this._data.splice(id, data.length - 1);
        this._data.pop();
        break
      }
    };

    this.init_elm();
    this.send_message_alert(`Successful freeing of this '${id}' article.`)
  }
};

ElmArticlesAdmin.LINK_ADD = "/admin/article/add"