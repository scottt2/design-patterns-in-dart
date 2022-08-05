class Me {
  static final Me _singleton = new Me._internal();
  static final String _name = "Tyler";

  factory Me() {
    return _singleton;
  }

  static String get name => _name;

  @override
  String toString() => "Hello, my name is $name.";

  Me._internal();
}

void main() {
  var tyler = Me();
  var anotherTyler = Me();

  print(tyler);
  print(anotherTyler);

  var samenessCheck = identical(tyler, anotherTyler)
      ? "We are both the same ${Me.name}."
      : "We are NOT the same. I mean, just look at us.";
  print(samenessCheck);

  /*
    Hello, my name is Tyler.
    Hello, my name is Tyler.
    We are both the same Tyler.
  */
}
