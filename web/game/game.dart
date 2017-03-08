import 'package:stagexl/stagexl.dart';

class GameObject {
  static ResourceManager _resourceManager;
  static Stage _stage;

  get stage => _stage;
  get resourceManager => _resourceManager;

  GameObject();

  factory GameObject.Initialize(ResourceManager r, Stage s) {
    if (_resourceManager != null || _stage != null) {
      // RAISE EXCEPTION
    }
    GameObject._resourceManager = r;
    GameObject._stage = s;
    return new GameObject();
  }

}

