// A collection of unique elements
var set = new Set();

set.count(); // => 0

// Doesn't confuse strings and other values
set.add(1);     // => true
set.add(1);     // => false
set.add('1')    // => true
set.add(null)   // => true
set.add('null') // => true

set.count(); // => 4

// Uses reference equality for objects
var object = {};
set.add(object); // => true
set.add(object); // => false
set.add({});     // => true

set.count(); // => 6

// Handles potential problem strings just fine
set.add('__proto__');   // => true
set.add('constructor'); // => true

set.count(); // => 8

// Handles NaN
set.add(NaN); // => true
set.add(NaN); // => false

set.count(); // => 9
