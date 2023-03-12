import DataElement from "./data_element.js";
import Data from "../core/data.js";
import HeaderAdmin from "../controllers/header_admin.js";

export default class ElmProjectEdit extends DataElement {
  constructor() {
    super();
    this._spinner = document.getElementById("spinner_project");
    this.init_elm();

    this._simplemde = new SimpleMDE({
      toolbar: false,
      tabSize: 4,
      autofocus: false,
      autosave: {enabled: false},
      spellChecker: false,
      status: false
    });

    window.click_project_edit_post = this.click_project_edit_post.bind(this)
  };

  init_elm() {
    let template = `${`
    <div class='row g-3'>
      <form id='form-edit' class='row g-3' action='/admin/project/edit/${this._data.id}' method='post'>
        <div class='col-md-4'>
          <label for='name' class='form-label'>Name</label>
          <input name='name' type='text' class='form-control' id='name' value='${this._data.name}'>
        </div>
        <div class='col-md-4'>
          <label for='author_id' class='form-label'>Author ID</label>
          <input name='author_id' type='number' class='form-control' id='author_id' value='${this._data.author_id}' min='1'>
        </div>
        <div class='col-md-4'>
          <label for='category' class='form-label'>Category</label>
          <input name='category' type='text' class='form-control' id='category' value='${this._data.category}'>
        </div>

        <div class='col-md-0 mb-3'>
          <label for='content' class='form-label'>Content</label>
          <textarea name='content' class='form-control' id='content' style='height: 120px'>${this._data.content}</textarea>
        </div>
      </form>
      <div class='col-md-3'></div>
        <div class='col-md-6 d-grid gap-2'>
          <button id='btn-submit'class='btn btn-primary' onclick='click_project_edit_post()'>Modify the project, then leave.</button>
        </div>
      <div class='col-md-3'></div>
    </div>
    `}`;
    this._spinner.remove();
    this.innerHTML = template
  };

  click_project_edit_post() {
    let textarea = document.querySelector("textarea");
    textarea.value = this._simplemde.value();
    let form_edit = document.getElementById("form-edit");
    let btn_submit = document.getElementById("btn-submit");
    btn_submit.classList.add("disabled");
    Data.post_form(form_edit);
    this.send_message_alert("Within 3 seconds, the content will be changed, and you'll be taken directly to the admin page.");
    location.hash = "#";

    setTimeout(
      () => location.replace(`/admin${HeaderAdmin.PROJECTS_HASH}`),
      3_000
    )
  }
}