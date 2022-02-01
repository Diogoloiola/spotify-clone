import 'package:flutter/material.dart';
import 'package:spotify_clone/screens/result_album.dart';
import 'package:spotify_clone/screens/result_playlist.dart';
import 'package:spotify_clone/screens/result_podcast.dart';

import 'home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotify clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
        '/result_podcast': (context) => const ResultPodcast(),
        '/result_playlist': (context) => const ResultPlayList(),
        '/result_album': (context) => const RescultAlbum(),
      },
    );
  }
}
