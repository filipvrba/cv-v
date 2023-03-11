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
  };

  static get_binary_to_image(str_hex, type="png") {
    let head = `data:image/${type};base64`;
    return `${Data.hex_to_base64(str_hex)}`
  };

  static hex_to_base64(str_hex) {
    return btoa(String.fromCharCode.apply(
      null,

      str_hex.replace(/\r|\n/, "").replace(/([\da-fA-F]{2}) ?/, "0x$1 ").replace(
        / +$/m,
        ""
      ).split(" ")
    ))
  };

  static post(data, endpoint) {
    let xmr = new XMLHttpRequest;
    let s_data = JSON.stringify(data);
    xmr.open("POST", endpoint);

    xmr.setRequestHeader(
      "Content-Type",
      "application/json;charset=UTF-8"
    );

    xmr.send(s_data)
  }
}