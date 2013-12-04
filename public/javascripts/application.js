window.addEventListener('load', function() {
  function forEach(collection, fn) {
    for (var i = 0; i < collection.length; ++i) {
      fn(collection[i]);
    }
  }

  forEach(document.querySelectorAll('textarea.code-mirror-placeholder'), function(textarea) {
    CodeMirror.fromTextArea(textarea, {
      mode: 'javascript',
      lineNumbers: true
    });
  });
});
