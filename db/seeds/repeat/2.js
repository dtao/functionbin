function repeat(str, N) {
  if (N < 1 || str === '') {
    return '';
  }

  var result = str,
      remainingLength = (N - 1) * str.length;

  while (remainingLength >= result.length) {
    remainingLength -= result.length;
    result += result;
  }

  result += result.substring(0, remainingLength);

  return result;
}
