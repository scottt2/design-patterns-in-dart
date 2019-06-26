## Strategy Pattern
In computer programming, the strategy pattern (also known as the policy pattern) is a behavioral software design pattern that enables selecting an algorithm at runtime. Instead of implementing a single algorithm directly, code receives run-time instructions as to which in a family of algorithms to use.

Strategy lets the algorithm vary independently from clients that use it. Strategy is one of the patterns included in the influential book Design Patterns by Gamma et al. that popularized the concept of using design patterns to describe how to design flexible and reusable object-oriented software. Deferring the decision about which algorithm to use until runtime allows the calling code to be more flexible and reusable.

For instance, a class that performs validation on incoming data may use the strategy pattern to select a validation algorithm depending on the type of data, the source of the data, user choice, or other discriminating factors. These factors are not known until run-time and may require radically different validation to be performed. The validation algorithms (strategies), encapsulated separately from the validating object, may be used by other validating objects in different areas of the system (or even different systems) without code duplication.

Typically the strategy pattern stores a reference to some code in a data structure and retrieves it. This can be achieved by mechanisms such as the native function pointer, the first-class function, classes or class instances in object-oriented programming languages, or accessing the language implementation's internal storage of code via reflection.

[Wikipedia: Strategy Pattern](https://en.wikipedia.org/wiki/Strategy_pattern)

### Example

[View on GitHub](https://github.com/scottt2/design-patterns-in-dart/tree/master/strategy)

```dart
abstract class CoffeeStrategy {
String announce(String roast);
}

class AmericanoStrategy implements CoffeeStrategy {
String announce(String roast) => "an Americano with $roast beans";
}

class DripStrategy implements CoffeeStrategy {
String announce(String roast) => "a drip coffee with $roast beans";
}

class MochaFrappuccinoStrategy implements CoffeeStrategy {
String announce(String roast) => "a delicious mocha frappuccion with $roast beans";
}

class CoffeeDrinker {
CoffeeStrategy preferredDrink;
String name;
CoffeeDrinker(this.name, this.preferredDrink);
}

void main() {
var americano = AmericanoStrategy();
var drip = DripStrategy();
var mocha = MochaFrappuccinoStrategy();

var me = CoffeeDrinker("Tyler", drip);
var europeanBuddy = CoffeeDrinker("Pieter", americano);
var myDaughter = CoffeeDrinker("Joanie", mocha);

final String roastOfTheDay = "Italian";

for (var person in [me, europeanBuddy, myDaughter]) {
  print("Hey ${person.name}, whatcha drinkin' over there?");
  print("I'm enjoying ${person.preferredDrink.announce(roastOfTheDay)}!\r\n");
}

/*
  Hey Tyler, whatcha drinkin' over there?
  I'm enjoying a drip coffee with Italian beans!

  Hey Pieter, whatcha drinkin' over there?
  I'm enjoying an Americano with Italian beans!

  Hey Joanie, whatcha drinkin' over there?
  I'm enjoying a delicious mocha frappuccion with Italian beans!
*/
}
```

