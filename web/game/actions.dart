// TODO probably need both a class describing an action, with it's preconditions
// etc. of which there should be one, or one per building type or instance of
// that building and another class to actually track the execution of an
// instance of that task of which there could be many per building
abstract class GameAction {
  // How long this action takes to execute
  Duration _executionTime;
  String _description;

  GameAction(this._description, this._executionTime);

  bool CanExecute();
  ActionTracker Execute();
}

class ActionTracker {
  Duration _timeRemaining;
  GameAction _parentAction;
// TODO implement a timer and callback here
}