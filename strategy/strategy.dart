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

