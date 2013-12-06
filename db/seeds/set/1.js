function Set() {
  this.values = [];
}

Set.prototype.count = function() {
  return values.length;
};

Set.prototype.add = function(element) {
  if (!this.contains(element)) {
    this.values.push(element);
    return true;
  }
  return false;
};

Set.prototype.contains = function(element) {
  if (isNaN(element)) {
    return search(this.values, isNaN);
  }
  return search(this.values, function(value) {
    return value === element;
  });
};

function search(array, predicate) {
  for (var i = 0; i < array.length; ++i) {
    if (predicate(array[i])) {
      return true;
    }
  }
  return false;
}
