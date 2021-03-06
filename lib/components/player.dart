import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:spotify_clone/controllers/player_controller.dart';
import 'package:spotify_clone/helpers/choose_height.dart';
import 'package:spotify_clone/theme/colors.dart';

class Player extends StatelessWidget {
  final int type;
  const Player({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: PlayerController.instance.isPlaying ? double.infinity : 0,
      height: PlayerController.instance.isPlaying
          ? chooseHeight(
              PlayerController.instance.isCollapse, [height * .92, 50.0])
          : 0,
      child: type == 1 ? const PlayerOne() : const PlayerTwo(),
    );
  }
}

class PlayerOne extends StatefulWidget {
  const PlayerOne({Key? key}) : super(key: key);

  @override
  _PlayerOneState createState() => _PlayerOneState();
}

class _PlayerOneState extends State<PlayerOne> {
  @override
  Widget build(BuildContext context) {
    String title = PlayerController
        .instance.tracks[PlayerController.instance.currentIndex].title;
    return GestureDetector(
      onTap: () {
        PlayerController.instance.collapse();
      },
      child: Container(
        color: ColorPalette.darkSecondary,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _containerImage(),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    title.length > 40 ? title.substring(0, 40) : title,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            IconButton(
                onPressed: () async {
                  await PlayerController.instance.pause();
                  setState(() {});
                },
                icon: Icon(
                  PlayerController.instance.audioPlayed
                      ? Icons.pause
                      : Icons.play_circle,
                  color: Colors.white,
                ))
          ],
        ),
      ),
    );
  }

  Widget _containerImage() {
    if (PlayerController.instance.coverMedium == '') {
      return Container(
        width: 40,
        height: 40,
        color: ColorPalette.darkSecondary,
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        PlayerController.instance.coverMedium,
        fit: BoxFit.fill,
        width: 40,
        height: 40,
      ),
    );
  }
}

class PlayerTwo extends StatefulWidget {
  const PlayerTwo({Key? key}) : super(key: key);

  @override
  _PlayerTwoState createState() => _PlayerTwoState();
}

class _PlayerTwoState extends State<PlayerTwo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 8))
        ..repeat();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(20),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Header(),
              Container(
                width: width * .7,
                height: height * .4,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(200)),
                    color: Colors.red),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: Transform.rotate(
                    angle: _controller.value * 2 * math.pi,
                    child: Image.network(
                      PlayerController.instance.coverMedium,
                      fit: BoxFit.fill,
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),
              ),
              const Controls()
            ],
          );
        },
      ),
    );
  }
}

class Controls extends StatefulWidget {
  const Controls({Key? key}) : super(key: key);

  @override
  _ControlsState createState() => _ControlsState();
}

class _ControlsState extends State<Controls> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      child: Column(
        children: [
          Container(
            width: width,
            margin: const EdgeInsets.only(bottom: 20),
            child: Text(
              PlayerController.instance
                  .tracks[PlayerController.instance.currentIndex].title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: width,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      '00:00',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                    Text(
                      '00:00',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            width: width,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: const Icon(
                    Icons.skip_previous_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                Container(
                  width: 60,
                  height: 60,
                  child: IconButton(
                      onPressed: () async {
                        await PlayerController.instance.pause();
                        setState(() {});
                      },
                      icon: Icon(
                        PlayerController.instance.audioPlayed
                            ? Icons.pause
                            : Icons.play_arrow,
                        size: 40,
                      )),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(90)),
                      color: Colors.white),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const Icon(
                    Icons.skip_next_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'M??sica',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          TextButton(
              onPressed: () {
                PlayerController.instance.collapse();
              },
              child: const Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
                size: 40,
              ))
        ],
      ),
    );
  }
}
