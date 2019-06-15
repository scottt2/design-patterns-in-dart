# Facade Pattern
The facade pattern (also spelled façade) is a software-design pattern commonly used in object-oriented programming. Analogous to a facade in architecture, a facade is an object that serves as a front-facing interface masking more complex underlying or structural code.

The facade pattern is typically used when:
* a simple interface is required to access a complex system,
* a system is very complex or difficult to understand,
* an entry point is needed to each level of layered software, or
* the abstractions and implementations of a subsystem are tightly coupled.

[Wikipedia: Facade Pattern](https://en.wikipedia.org/wiki/Facade_pattern)

## Example

[View on GitHub](https://github.com/scottt2/design-patterns-in-dart/tree/master/facade)

```dart
class Grinder {
  String _type;

  Grinder(this._type);

  void grind() {
    print("Grinding $_type!");
  }
}

class Maker {
  String _type;

  Maker(this._type);

  void fill() {
    print("Filling the $_type maker!");
  }

  void retrieve() {
    print("Retrieving the $_type!");
  }

  void start() {
    print("Starting the $_type maker!");
  }
}

class Imbiber {
  String _beverage;

  Imbiber(this._beverage);

  void drink() {
    print("Mmmmm...drinking $_beverage!");
  }
}

class MorningFacade {
  final _coffeeDrinker = Imbiber("coffee");
  final _coffeeGrinder = Grinder("coffee beans");
  final _coffeeMaker = Maker("coffee");

  void prepareCoffee() {
    print("\r\nPreparing the coffee...");
    _coffeeGrinder.grind();
    _coffeeMaker
        ..fill()
        ..start();
    print("Coffee is brewing!\r\n");
  }

  void drinkCoffee() {
    print("\r\nMust...have...coffee...");
    _coffeeMaker.retrieve();
    _coffeeDrinker.drink();
    print("This is damn fine coffee!");
  }
}

void main() {
  var typicalMorning = MorningFacade();

  print("Wake up! Grab a brush and put on a little makeup...");
  print("\r\nStumble to the kitchen...");

  typicalMorning.prepareCoffee();

  print("Oh my...that smells good...");

  typicalMorning.drinkCoffee();

  print("\r\nI'm ready to attack the day!");
}
```
