export default class ElmAlert extends HTMLElement {
  constructor() {
    super();
    this._h_show_alert = e => this.init_elm(e.detail.message)
  };

  connectedCallback() {
    document.addEventListener(ElmAlert.ALERT_EVENT, this._h_show_alert)
  };

  disconnectedCallback() {
    document.removeEventListener(
      ElmAlert.ALERT_EVENT,
      this._h_show_alert
    )
  };

  init_elm(message) {
    let template = `${`
    <div id='alert-message' class='alert alert-info alert-dismissible fade show' role='alert'>
        ${message}
        <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>
    </div>
    `}`;
    this.innerHTML = template
  }
};

ElmAlert.ALERT_EVENT = "eahe_show"