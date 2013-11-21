/*
 * Returns a copy of the given string with leading and trailing whitespace removed.
 *
 * @example
 * trim('foo')        // => 'foo'
 * trim('  foo')      // => 'foo'
 * trim('foo  ')      // => 'foo'
 * trim('\tfoo\n\r')  // => 'foo'
 * trim(' foo  bar ') // => 'foo  bar'
 */
function trim(str) {
  return str.replace(/^\s+|\s+$/g, '');
}