// Each function gets wrapped in a closure to prevent naming collisions
(function() {
  function function1() {
    // Blah blah blah
  }

  exports.function1 = function1;
});

// Etc. etc.
(function() {
  function function2() {
    // Yada yada yada
  }

  exports.function2 = function2;
});