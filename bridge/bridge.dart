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
  for (var i = 0; i < 3; i++) {
    roaster.turnGasValve();
    if (roaster.isTooHot) {
      roaster.loudspeaker = LoudspeakerWithAlarm();
    }
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
