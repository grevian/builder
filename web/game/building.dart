import 'dart:collection';
import 'package:stagexl/stagexl.dart';
import 'actions.dart';
import 'game.dart';

abstract class BuildingAction extends GameAction {
  // This building this action is associated with, stop the action if the building is destroyed,
  // Use this buildings queue, etc.
  Building _parent;

  // TODO A standard interface for checking if this action can be executed (Have enough resources, have tech tree level, nothing else in progress, etc.)
  // TODO A standard interface for executing this action, add it to a buildings queue, etc.
  BuildingAction(this._parent, String description, Duration executionTime) : super (description, executionTime);
}

class Building extends GameObject {
  // The graphic representing this building
  Sprite _graphic;

  // A list of actions that the player can perform through this building
  // eg. Create a new unit, spend resources on something, etc.
  List<BuildingAction> _actions;
  Queue<ActionTracker> _queue;

  // The grid footprint of this building (Only rectangles for now!)
  int width, height;

  // Basic constructor to give us something to place
  Building(this.width, this.height, this._graphic) {

  }
}

class TownHall extends Building {
  TownHall() : super(6, 4, null) {
    _actions.add(new RecruitWorker(this));
  }
}

class RecruitWorker extends BuildingAction {
  RecruitWorker(Building parent) : super(parent, "Recruit a new worker", new Duration(seconds: 10)) {
    this._parent = parent;
    // RESULT: Instantiate and place a new worker/character
  }

  @override
  bool CanExecute() {
    // TODO: implement CanExecute
    // PRECONDITION Game state has 100 resources available, maybe "have enough food" too?

    // Inspect the game state
    GameObject go = new GameObject();

    return true;
  }

  @override
  ActionTracker Execute() {
    // TODO: implement Execute
    // TODO Should I double check CanExecute here? or is it useful to allow it to be
    // TODO overridden?

    if (this.CanExecute()) {
      ActionTracker a = new ActionTracker();
      _parent._queue.add(a);
      return g;
    } else {
      // TODO Log to the console, alert the user
    }
    return null;
  }
}