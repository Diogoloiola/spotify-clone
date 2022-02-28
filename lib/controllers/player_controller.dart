import 'package:flutter/cupertino.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:spotify_clone/models/track.dart';

class PlayerController extends ChangeNotifier {
  int currentIndex = 0;
  String label = '00:00';
  String coverMedium = '';
  List<Track> tracks = [];
  bool isPlaying = false;
  bool audioPlayed = false;
  bool isCollapse = false;
  AudioPlayer player = AudioPlayer();

  static PlayerController instance = PlayerController();

  stop() async {
    int result = await player.stop();
    if (result == 1) {
      isPlaying = false;
      audioPlayed = false;
      coverMedium = '';
      notifyListeners();
    }
  }

  pause() async {
    if (audioPlayed) {
      await player.pause();
    } else {
      await player.resume();
    }
    audioPlayed = !audioPlayed;
    notifyListeners();
  }

  collapse() {
    isCollapse = !isCollapse;
    notifyListeners();
  }

  play(int index) async {
    String preview = tracks[index].preview;
    if (preview.isNotEmpty) {
      int result = await player.play(preview);
      if (result == 1) {
        isPlaying = true;
        audioPlayed = true;
        currentIndex = index;
        notifyListeners();
      }
    }
  }

  setImage(String coverMedium) {
    this.coverMedium = '';
    this.coverMedium = coverMedium;
    notifyListeners();
  }
}
