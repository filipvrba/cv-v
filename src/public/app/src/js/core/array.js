function remove_value_from_id(id) {
  let arr_clone = Array.from(this);
  let result = null;

  for (let i = 0; i <= arr_clone.length; i++) {
    if (this[i].id == id) {
      if (i == 0) {
        result = this.splice(i + 1, arr_clone.length);
        break
      } else {
        let _start = this.splice(0, i);
        let _end = this.splice(i, arr_clone.length);
        result = _start.concat(_end);
        break
      }
    }
  };

  return result
};

Array.prototype.remove_value_from_id = remove_value_from_id