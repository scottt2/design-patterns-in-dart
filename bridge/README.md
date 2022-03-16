## Bridge Pattern
The bridge pattern is a design pattern used in software engineering that is meant to "decouple an abstraction from its implementation so that the two can vary independently", introduced by the Gang of Four. The bridge uses encapsulation, aggregation, and can use inheritance to separate responsibilities into different classes.

When a class varies often, the features of object-oriented programming become very useful because changes to a program's code can be made easily with minimal prior knowledge about the program. The bridge pattern is useful when both the class and what it does vary often. The class itself can be thought of as the abstraction and what the class can do as the implementation. The bridge pattern can also be thought of as two layers of abstraction.

When there is only one fixed implementation, this pattern is known as the Pimpl idiom in the C++ world.

The bridge pattern is often confused with the adapter pattern, and is often implemented using the object adapter pattern.

Variant: The implementation can be decoupled even more by deferring the presence of the implementation to the point where the abstraction is utilized.

[Wikipedia: Bridge Pattern](https://en.wikipedia.org/wiki/Bridge_pattern)

### Example

[View on GitHub](https://github.com/scottt2/design-patterns-in-dart/tree/master/bridge)

```dart
abstract class Loudspeaker {
  void announce(String message);
}

class LoudspeakerWithMuzak implements Loudspeaker {
  void announce(String message) => print("<soothing muzak playing> $message");
}

class LoudspeakerWithAlarm implements Loudspeaker {
  void announce(String message) => print("<BOO-OP BOO-OP> $message <BOO-OP>");
}

abstract class Factory {
  Loudspeaker loudspeaker = LoudspeakerWithMuzak();
  void announce(String message) => loudspeaker.announce(message);
}

class CoffeeRoaster extends Factory {
  int _temp = 200;
  bool get isTooHot => _temp >= 225;

  void turnGasValve() {
    loudspeaker.announce("Increasing gas!");
    _temp += 25;
    loudspeaker.announce("Temperature is now at $_temp");
  }
}

void main() {
  var roaster = CoffeeRoaster();
  for (var i=0; i < 3; i++) {
    roaster.turnGasValve();
    if (roaster.isTooHot) { roaster.loudspeaker = LoudspeakerWithAlarm(); }
  }

  /*
    <soothing muzak playing> Increasing gas!
    <soothing muzak playing> Temperature is now at 225
    <BOO-OP BOO-OP> Increasing gas! <BOO-OP>
    <BOO-OP BOO-OP> Temperature is now at 250 <BOO-OP>
    <BOO-OP BOO-OP> Increasing gas! <BOO-OP>
    <BOO-OP BOO-OP> Temperature is now at 275 <BOO-OP>
  */
}
```

