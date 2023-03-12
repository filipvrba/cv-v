import Data from "../core/data.js";
import ElmAlert from "./elm_alert.js";

export default class DataElement extends HTMLElement {
  constructor() {
    super();
    this._data = this.get_data()
  };

  get_data() {
    let attr_data = this.getAttribute("data");
    return Data.get_decode_obj(attr_data)
  };

  send_message_alert(message) {
    let show_alert = new CustomEvent(ElmAlert.ALERT_EVENT, {detail: {message}});
    document.dispatchEvent(show_alert)
  }
}