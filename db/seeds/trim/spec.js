// Trim leading and trailing whitespace from a string
trim('  foo')             // => 'foo'
trim('foo  ')             // => 'foo'
trim('  foo  ')           // => 'foo'
trim('\tfoo\t')           // => 'foo'
trim('\nfoo\n')           // => 'foo'
trim('\rfoo\r')           // => 'foo'
trim(' \t\n\rfoo\n\r\t ') // => 'foo'
trim('  foo  bar  ')      // => 'foo  bar'
