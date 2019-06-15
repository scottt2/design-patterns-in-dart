## Factory Method Pattern
The factory method pattern is a creational pattern that uses factory methods to deal with the problem of creating objects without having to specify the exact class of the object that will be created. This is done by creating objects by calling a factory method—either specified in an interface and implemented by child classes, or implemented in a base class and optionally overridden by derived classes—rather than by calling a constructor.

[Wikipedia: Factory Method](https://en.wikipedia.org/wiki/Factory_method_pattern)

### Example

[View on GitHub](https://github.com/scottt2/design-patterns-in-dart/tree/master/factor_method)

```dart
class Volume {
  final int quantity;
  final String unit;

  Volume(this.quantity, this.unit);
  String toString() => "$quantity $unit";
}

abstract class Vessel {
  Volume volume;
  String liquid;
}

class Bucket extends Vessel {
  final Volume volume;

  Bucket(int q, String u) : volume = Volume(q, u);
  String toString() => "a $volume bucket full of $liquid";
}

class Cup extends Vessel {
 final Volume volume;

  Cup(int q, String u) : volume = Volume(q, u);
  String toString() => "a $volume cup full of $liquid";
}

enum Tiredness {
  rested, sleepy, barelyAlive, hasChildren
}

class CoffeeVesselFactory {
  static Vessel vesselFor(Tiredness howTired) {
    Vessel vessel;
    switch(howTired) {
      case Tiredness.rested: vessel = Cup(100, "milliliter"); break;
      case Tiredness.sleepy:
      case Tiredness.barelyAlive: vessel = Cup(500, "milliliter"); break;
      case Tiredness.hasChildren: vessel = Bucket(5, "liter"); break;
      default: vessel = Cup(200, "milliliter"); break;
    }
    vessel.liquid = "coffee";
    return vessel;
  }
}

void main() {
  var sleepyVessel = CoffeeVesselFactory.vesselFor(Tiredness.sleepy);
  var kidVessel = CoffeeVesselFactory.vesselFor(Tiredness.hasChildren);

  // A sleepy person would like a 500 milliliter cup full of coffee.
  print("A sleepy person would like $sleepyVessel.");
  // A person with children NEEDS a 5 liter bucket full of coffee.
  print("A person with children NEEDS $kidVessel.");
}
```
