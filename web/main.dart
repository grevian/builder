import 'dart:html';
import 'dart:convert';
import 'game/game.dart';
import 'package:stagexl/stagexl.dart';

void main() {
  var canvas = querySelector('#stage');
  var stage = new Stage(canvas, width: 800, height: 600);
  stage.scaleMode = StageScaleMode.SHOW_ALL;
  stage.align = StageAlign.NONE;

  var renderLoop = new RenderLoop();
  renderLoop.addStage(stage);

  var resourceManager = new ResourceManager()
    ..addBitmapData('tile/1', 'assets/tiles/medievalTile_27.png')
    ..addBitmapData('tile/2', 'assets/tiles/medievalTile_17.png')
    ..addBitmapData('tile/3', 'assets/tiles/medievalTile_03.png')
    ..addBitmapData('tile/4', 'assets/tiles/medievalTile_31.png')
    ..addBitmapData('tile/5', 'assets/tiles/medievalTile_04.png')
    ..addBitmapData('tile/6', 'assets/tiles/medievalTile_58.png')
    ..addBitmapData('tile/7', 'assets/tiles/medievalTile_04.png')
    ..addBitmapData('tile/8', 'assets/tiles/medievalTile_18.png')
    ..addBitmapData('tile/9', 'assets/tiles/medievalTile_03.png')
    ..addBitmapData('tile/10', 'assets/tiles/medievalTile_32.png')
    ..addTextFile('maps/demo', 'assets/maps/demo.json');

  resourceManager.load().then((result) {
    String mapFile = resourceManager.getTextFile("maps/demo");
    Map<String, dynamic> parsedMap = JSON.decode(mapFile);
    print(parsedMap);
    List<List<int>> tiles = parsedMap["tiles"];

    for (int i = 0; i < tiles.length; i++ ) {
      for (int j = 0; j < tiles.length; j++ ) {
        int t = tiles[i][j];
        Bitmap tileData = new Bitmap(resourceManager.getBitmapData('tile/${t}'));
        stage.addChild(tileData);
        var tween = new Tween(tileData, 3.0, Transition.easeOutBounce);
        tween.animate.x.to(64*i);
        tween.animate.y.to(64*j);
        tween.delay = 0.5;
        renderLoop.juggler.add(tween);
      }
    }

    GameObject go = new GameObject.Initialize(resourceManager, stage);

  });

}
