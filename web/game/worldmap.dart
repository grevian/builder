import 'dart:async';
import 'dart:convert';
import 'package:stagexl/stagexl.dart';

const VERSION_MAGIC_STRING = "builder_map_version";

/* MAP FILE FORMAT

 {
  "builder_map_version": 1,
  "title": "Some sweet map",
  "description": "A map with some stuff",
  "manifests": [
         {
          "name": "Common desert resources"
          "resources": [
             {
               "type": "bitmap",
               "name": "sand1",
               "path": "/assets/tiles/sand01.png",
             },
             {
               "type": "bitmap",
               "name": "cactus",
               "path": "/assets/tiles/cactus01.png",
             }
          },
          {
          "name": "Common building resources"
          "resources": [
             {
               "type": "bitmap",
               "name": "door",
               "path": "/assets/objects/door.png",
             },
             {
               "type": "sound",
               "name": "door-opening",
               "path": "/assets/sounds/door-opening.mp3",
             }
          }
         ],
   // The initial visual layout of the tile resources
   "tile_layout": "TODO",

   // The map mask that impacts pathing, resources, etc.
   "tile_mask": "TODO",

   // A list of entities + coordinates to place on the map, things like
   // resources, enemies, portals, objects to be interacted with, etc.
   // Will have to reference enemies from the game state component? Otherwise
   // maybe just make this field available to that component and don't try to
   // place entities during file loading
   "entities": "TODO"
 }

 */


class Worldmap {
  final ResourceManager _resourceManager = new ResourceManager();
  final Stage _stage;

  Map<String, dynamic> _parsedMapfile;

  String _title;
  String _description;
  String _version;
  List<Map<String, dynamic>> _manifests;
  num _size_x, _size_y;

  String Description () => _description;
  String Title () => _title;
  String Version () => _version;

  Worldmap(String levelFile, this._stage) {
    _parsedMapfile = JSON.decode(levelFile);
    if (!_parsedMapfile.containsKey(VERSION_MAGIC_STRING)) {
      throw new Exception("Invalid Map Format! No Version String found!");
    }
    if (_parsedMapfile[VERSION_MAGIC_STRING] != 1) {
      throw new Exception("Invalid Map Format! Unexpected version ${_parsedMapfile[VERSION_MAGIC_STRING]}!");
    }
  }

  Future load() async {
    // Load the basic map details,
    // title, version, description, background colour, size, etc.
    _version = _parsedMapfile[VERSION_MAGIC_STRING];
    _title = _parsedMapfile["title"];
    _description = _parsedMapfile["description"];

    var layout = _parsedMapfile["tile_layout"];
    var mask = _parsedMapfile["tile_mask"];

    // Save the full manifest list
    _manifests = _parsedMapfile["manifests"];

    // Loop over one or more manifests and load the required resources into the resource manager
    _manifests.forEach((Map<String, dynamic> m) {
      // Load manifest metadata
      String manifestName = m["name"];

      // Load all the resources for this manifest
      List<String> manifestResourceList = m["resources"];
      manifestResourceList.forEach((r){
        String type = r["type"];
        String path = r["path"];
        String name = r["name"];
        switch (type) {
          case "bitmap":
            _resourceManager.addBitmapData(name, path);
            break;
          case "sound":
            _resourceManager.addSound(name, path);
            break;
          default:
            throw new Exception("Unexpected resource type ${type} encountered in manifest ${manifestName}!");
        }
      });
    });

    _resourceManager.load();



  }
}