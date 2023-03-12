import DataElement from "./data_element.js";
import Data from "../core/data.js";

export default class ElmArticleEdit extends DataElement {
  constructor() {
    super();
    this._spinner = document.getElementById("spinner_article");
    this.init_elm();
    window.click_article_edit_post = this.click_article_edit_post.bind(this)
  };

  init_elm() {
    let template = `${`
    <div class='row g-3'>
      <form id='form-edit' class='row g-3' action='/admin/article/edit/${this._data.id}' method='post'>
        <div class='col-md-4'>
          <label for='name' class='form-label'>Name</label>
          <input name='name' type='text' class='form-control' id='name' value='${this._data.name}'>
        </div>
        <div class='col-md-4'>
          <label for='author_id' class='form-label'>Author ID</label>
          <input name='author_id' type='number' class='form-control' id='author_id' value='${this._data.author_id}' min='1'>
        </div>
        <div class='col-md-4'>
          <label for='project_id' class='form-label'>Project ID</label>
          <input name='project_id' type='number' class='form-control' id='project_id' value='${this._data.project_id}' min='1'>
        </div>

        <div class='col-md-2'></div>
        <div class='col-md-8'>
          <label for='url' class='form-label'>URL</label>
          <input name='url' type='text' class='form-control' id='url' value='${this._data.url}'>
        </div>
        <div class='col-md-2'></div>

        <div class='col-md-2'></div>
        <div class='col-md-8 mb-3'>
          <label for='description' class='form-label'>Description</label>
          <textarea name='description' class='form-control' id='description' style='height: 120px'>${this._data.description}</textarea>
        </div>
        <div class='col-md-2'></div>
      </form>
      <div class='col-md-3'></div>
        <div class='col-md-6 d-grid gap-2'>
          <button id='btn-submit'class='btn btn-primary' onclick='click_article_edit_post()'>Modify the article, then leave.</button>
        </div>
      <div class='col-md-3'></div>
    </div>
    `}`;
    this._spinner.remove();
    this.innerHTML = template
  };

  click_article_edit_post() {
    let form_edit = document.getElementById("form-edit");
    let btn_submit = document.getElementById("btn-submit");
    btn_submit.classList.add("disabled");
    Data.post_form(form_edit);
    this.send_message_alert("Within 3 seconds, the content will be changed, and you'll be taken directly to the admin page.");
    setTimeout(() => location.replace("/admin"), 3_000)
  }
}