abstract class Receiver {
  Set<String> get actions;
}

abstract class Command {
  Receiver receiver;
  String name;

  Command(this.receiver);

  @override
  String toString() => this.name;

  void execute();
}

class Invoker {
  List<String> history = [];
  void execute(Command cmd) {
    cmd.execute();
    history.add("[${DateTime.now()}] Executed $cmd");
  }

  @override
  String toString() =>
      history.fold("", (events, event) => events + "$event\r\n");
}

class TurnOffCommand extends Command {
  String name = "Turn off";
  TurnOffCommand(Light light) : super(light);
  void execute() {
    (receiver as Light).turnOff();
  }
}

class TurnOnCommand extends Command {
  String name = "Turn on";
  TurnOnCommand(Light light) : super(light);
  void execute() {
    (receiver as Light).turnOn();
  }
}

class Light implements Receiver {
  void turnOff() => print("Light off!");
  void turnOn() => print("Light on!");
  Set<String> get actions => Set.from(["off", "on"]);
}

class LightSwitch {
  Invoker _switch = Invoker();
  Light light;

  LightSwitch(this.light);

  String get history => _switch.toString();

  void perform(String action) {
    if (!light.actions.contains(action)) {
      return print("Uh...wait, wut?");
    }
    switch (action) {
      case "on":
        return _switch.execute(TurnOnCommand(light));
      case "off":
        return _switch.execute(TurnOffCommand(light));
    }
  }
}

void main() {
  var myFavoriteLamp = Light();
  var iotLightSwitch = LightSwitch(myFavoriteLamp);

  iotLightSwitch.perform("on");
  iotLightSwitch.perform("off");
  iotLightSwitch.perform("blink");
  iotLightSwitch.perform("on");

  print("\r\n*** Fancy IoT Switch Logs ***\r\n${iotLightSwitch.history}");

  /*
    Light on!
    Light off!
    Uh...wait, wut?
    Light on!

    *** Fancy IoT Switch Logs ***
    [2019-06-20 08:00:38.880050] Executed Turn on
    [2019-06-20 08:00:38.883495] Executed Turn off
    [2019-06-20 08:00:38.883702] Executed Turn on
  */
}
