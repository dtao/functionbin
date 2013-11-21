window.addEventListener('load', function() {
  if (!localStorage.GITHUB_USERNAME || !localStorage.GITHUB_PASSWORD) {
    alert('You must set GITHUB_USERNAME and GITHUB_PASSWORD before continuing.');
    return;
  }

  var github = new Github({
    username: localStorage.GITHUB_USERNAME,
    password: localStorage.GITHUB_PASSWORD
  });

  var repo = github.getRepo('dtao', 'functionbin');

  var createFunctionForm = document.getElementById('create-function-form'),
      nameField = createFunctionForm.querySelector('input[name="name"]'),
      codeField = createFunctionForm.querySelector('textarea[name="code"]'),
      commentsField = createFunctionForm.querySelector('textarea[name="comments"]');

  createFunctionForm.addEventListener('submit', function(e) {
    e.preventDefault();

    var name = trim(nameField.value),
        code = trim(codeField.value),
        comments = commentsField.value;

    if (!(/^\w[\d\w]+$/).test(name)) {
      alert('"Name" must only contain letters and numbers.');
      return;
    }

    if (code === '') {
      alert('"Code" must not be blank.');
      return;
    }

    if (comments === '') {
      alert('"Comments" must not be blank.');
      return;
    }

    repo.write('master', 'functions/' + name + '.js', code, comments, function(err) {
      alert('Saved function "' + name + '"!');
    });
  });
});

/*
 * Trims leading and trailing space from a string.
 *
 * @private
 * @examples
 * trim('foo')     // => 'foo'
 * trim('  foo')   // => 'foo'
 * trim('foo  ')   // => 'foo'
 * trim('  foo  ') // => 'foo'
 * trim(null)      // => ''
 */
function trim(str) {
  return (str || '').replace(/^\s+|\s+$/g, '');
}
