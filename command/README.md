## Command Pattern
In object-oriented programming, the command pattern is a behavioral design pattern in which an object is used to encapsulate all information needed to perform an action or trigger an event at a later time. This information includes the method name, the object that owns the method and values for the method parameters.

Four terms always associated with the command pattern are command, receiver, invoker and client.

A command object knows about receiver and invokes a method of the receiver. Values for parameters of the receiver method are stored in the command.

The receiver object to execute these methods is also stored in the command object by aggregation. The receiver then does the work when the execute() method in command is called.

An invoker object knows how to execute a command, and optionally does bookkeeping about the command execution. The invoker does not know anything about a concrete command, it knows only about the command interface.

Invoker object(s), command objects and receiver objects are held by a client object, the client decides which receiver objects it assigns to the command objects, and which commands it assigns to the invoker. The client decides which commands to execute at which points. To execute a command, it passes the command object to the invoker object.

Using command objects makes it easier to construct general components that need to delegate, sequence or execute method calls at a time of their choosing without the need to know the class of the method or the method parameters. Using an invoker object allows bookkeeping about command executions to be conveniently performed, as well as implementing different modes for commands, which are managed by the invoker object, without the need for the client to be aware of the existence of bookkeeping or modes.

[Wikipedia: Command Pattern](https://en.wikipedia.org/wiki/Command_pattern)

### Example

[View on GitHub](https://github.com/scottt2/design-patterns-in-dart/tree/master/command)

```dart
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
  String toString() => history.fold("", (events, event) => events + "$event\r\n");
}

class TurnOffCommand extends Command {
  String name = "Turn off";
  TurnOffCommand(Light light): super(light);
  void execute() {
    (receiver as Light).turnOff();
  }
}

class TurnOnCommand extends Command {
  String name = "Turn on";
  TurnOnCommand(Light light): super(light);
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
    switch(action) {
      case "on": return _switch.execute(TurnOnCommand(light));
      case "off": return _switch.execute(TurnOffCommand(light));
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
```

