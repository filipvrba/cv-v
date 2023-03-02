export default class Data {
  static get_decode_obj(data) {
    let decode_data, obj;
    let result = null;

    if (data != "" && data != "null") {
      decode_data = base32.decode(data);
      obj = JSON.parse(decode_data);
      result = obj
    };

    return result
  }
}