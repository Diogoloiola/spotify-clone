import 'package:flutter/cupertino.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:spotify_clone/models/track.dart';

class PlayerController extends ChangeNotifier {
  int maxduration = 100;
  int currentpos = 0;
  int currentIndex = 0;
  String currentpostlabel = '00:00';
  String coverMedium = '';
  List<Track> tracks = [];
  bool isplaying = false;
  bool audioplayed = false;
  bool isCollapse = false;
  AudioPlayer player = AudioPlayer();

  static PlayerController instance = PlayerController();

  stop() async {
    int result = await player.stop();
    if (result == 1) {
      isplaying = false;
      audioplayed = false;
      currentpos = 0;
      coverMedium = '';
      notifyListeners();
    }
  }

  pause() async {
    if (audioplayed) {
      await player.pause();
    } else {
      await player.resume();
    }
    audioplayed = !audioplayed;
    notifyListeners();
  }

  collpase() {
    isCollapse = !isCollapse;
    notifyListeners();
  }

  play(int index) async {
    String preview = tracks[index].preview;
    if (preview.isNotEmpty) {
      int result = await player.play(preview);
      if (result == 1) {
        isplaying = true;
        audioplayed = true;
        currentpos = index;
        currentIndex = index;
        notifyListeners();
      } else {
        print('Deu errado');
      }
    }
  }

  setCurrentpos(int currentpos) {
    this.currentpos = currentpos;
    notifyListeners();
  }

  setnovo() {
    isplaying = !isplaying;
    notifyListeners();
  }

  setImage(String coverMedium) {
    this.coverMedium = '';
    this.coverMedium = coverMedium;
    print('Troquei a img');
    notifyListeners();
  }
}
