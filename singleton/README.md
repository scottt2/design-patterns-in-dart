## Singleton Pattern
In software engineering, the singleton pattern is a software design pattern that restricts the instantiation of a class to one "single" instance. This is useful when exactly one object is needed to coordinate actions across the system. The term comes from the mathematical concept of a singleton.

* The abstract factory, builder, and prototype patterns can use singletons in their implementation.
* Facade objects are often singletons because only one facade object is required.
* State objects are often singletons.

Singletons are often preferred to global variables because:
* They do not pollute the global namespace (or, in languages with nested namespaces, their containing namespace) with unnecessary variables.[4]
* They permit lazy allocation and initialization, whereas global variables in many languages will always consume resources.

[Wikipedia: Singleton Pattern](https://en.wikipedia.org/wiki/Singleton_pattern)

### Example

[View on GitHub](https://github.com/scottt2/design-patterns-in-dart/tree/master/singleton)

```dart
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
```
