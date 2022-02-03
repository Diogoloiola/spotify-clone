import 'package:flutter/cupertino.dart';
import 'package:audioplayers/audioplayers.dart';

class PlayerController extends ChangeNotifier {
  int maxduration = 100;
  int currentpos = 0;
  String currentpostlabel = '00:00';
  List<String> tracks = [];
  bool isplaying = false;
  bool audioplayed = false;
  AudioPlayer player = AudioPlayer();

  static PlayerController instance = PlayerController();

  stop() {
    isplaying = false;
    audioplayed = false;
    currentpos = 0;
    notifyListeners();
  }

  continueMusic() {
    isplaying = true;
    audioplayed = true;
    notifyListeners();
  }

  play(int index) async {
    int result = await player.play(tracks[index]);
    if (result == 1) {
      isplaying = true;
      audioplayed = true;
      currentpos = index;
      notifyListeners();
    } else {
      print('Deu errado');
    }
  }

  setCurrentpos(int currentpos) {
    this.currentpos = currentpos;
    notifyListeners();
  }

  setnovo() {
    isplaying = true;
    notifyListeners();
  }
}
