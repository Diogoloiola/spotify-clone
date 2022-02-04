import 'package:flutter/cupertino.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:spotify_clone/models/track.dart';

class PlayerController extends ChangeNotifier {
  int maxduration = 100;
  int currentpos = 0;
  String currentpostlabel = '00:00';
  List<Track> tracks = [
    Track.track(
        'Meu Pedaço de Pecado',
        'https://e-cdns-images.dzcdn.net/images/artist/65e1fbf38b84a7d0380b754452886aa8/250x250-000000-80-0-0.jpg',
        'https://cdns-preview-7.dzcdn.net/stream/c-70255a40b7c438c3239e94ba0c909128-3.mp3')
  ];
  bool isplaying = true;
  bool audioplayed = false;
  bool isCollapse = false;
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

  collpase() {
    isCollapse = !isCollapse;
    notifyListeners();
  }

  // play(int index) async {
  //   int result = await player.play(tracks[index]);
  //   if (result == 1) {
  //     isplaying = true;
  //     audioplayed = true;
  //     currentpos = index;
  //     notifyListeners();
  //   } else {
  //     print('Deu errado');
  //   }
  // }

  setCurrentpos(int currentpos) {
    this.currentpos = currentpos;
    notifyListeners();
  }

  setnovo() {
    isplaying = true;
    notifyListeners();
  }
}
