import Data from "../core/data.js";

export default class DataElement extends HTMLElement {
  constructor() {
    super();
    this._data = this.get_data()
  };

  get_data() {
    let attr_data = this.getAttribute("data");
    return Data.get_decode_obj(attr_data)
  }
}