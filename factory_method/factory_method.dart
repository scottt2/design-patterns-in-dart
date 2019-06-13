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

  // A sleepy person would like a 500 milliliters cup full of coffee.
  print("A sleepy person would like $sleepyVessel.");
  // A person with children NEEDS a 5 liters bucket full of coffee.
  print("A person with children NEEDS $kidVessel.");
}
