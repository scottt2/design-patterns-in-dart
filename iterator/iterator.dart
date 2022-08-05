// NOTE: See https://api.dartlang.org/stable/2.4.0/dart-core/Iterator-class.html
// for details on Dart's Iterator class.

class RainbowIterator implements Iterator {
  var _colors = [
    "Red",
    "Orange",
    "Yellow",
    "Green",
    "Blue",
    "Indigo",
    "Violet"
  ];
  var _index = 0;
  String get current => _colors[_index++];
  bool moveNext() => _index < _colors.length;
}

void main() {
  var rainbowColors = RainbowIterator();
  while (rainbowColors.moveNext()) {
    print(rainbowColors.current);
  }

  /*
    Red
    Orange
    Yellow
    Green
    Blue
    Indigo
    Violet
  */
}
