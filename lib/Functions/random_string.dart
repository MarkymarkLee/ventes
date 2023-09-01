import 'dart:math';

String getRandomString(int length) {
  const allChars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  // ignore: non_constant_identifier_names
  Random RNG = Random();
  return String.fromCharCodes(Iterable.generate(
      length, (_) => allChars.codeUnitAt(RNG.nextInt(allChars.length))));
}