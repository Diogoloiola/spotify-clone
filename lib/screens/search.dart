import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:spotify_clone/controllers/player_controller.dart';
import 'package:spotify_clone/helpers/chose_message.dart';
import 'package:spotify_clone/models/track.dart';
import 'package:spotify_clone/repositories/resource.dart';
import 'package:spotify_clone/repositories/search_repository.dart';
import 'package:spotify_clone/theme/colors.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _form = GlobalKey<FormState>();
  final _value = TextEditingController();
  bool isCollapse = false;
  List<Track> tracks = [];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    PlayerController.instance.tracks = [];
    int index = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text(choseMessage(1)),
        backgroundColor: ColorPalette.darkItermediare,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.all(10),
          color: ColorPalette.darkItermediare,
          child: Column(
            children: [
              Form(
                key: _form,
                child: Focus(
                  onFocusChange: (focus) {
                    setState(() {
                      isCollapse = true;
                    });
                  },
                  child: TextFormField(
                    controller: _value,
                    cursorColor: Colors.white,
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: ColorPalette.darkItermediare,
                      ),
                      fillColor: ColorPalette.darkSecondary,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: ColorPalette.darkItermediare, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  EasyLoading.show();
                  Resource client = Resource('https://api.deezer.com/', {});
                  SearchRepository search = SearchRepository(client.dio);
                  var data = await search.search(_value.text);
                  setState(() {
                    tracks = data;
                    isCollapse = false;
                  });
                  index = 0;
                  EasyLoading.dismiss();
                },
                child: const Button(),
              ),
              SizedBox(
                width: width,
                height: height * 0.6,
                child: ListView(
                  children: [
                    ...tracks.map<Widget>((object) {
                      PlayerController.instance.tracks.add(object);
                      return EpisodeWidget(
                          urlImage: object.coverMedium,
                          duration: object.duration,
                          title: object.title,
                          preview: object.preview,
                          index: index++,
                          code: object.code);
                    }).toList()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * .5,
      margin: const EdgeInsets.only(top: 15),
      height: 50,
      decoration: const BoxDecoration(
        color: ColorPalette.redPrimary,
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: const Center(
        child: Text('Pesquisar',
            style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class EpisodeWidget extends StatelessWidget {
  final String urlImage;
  final int duration;
  final String title;
  final String preview;
  final int index;
  final int code;
  const EpisodeWidget(
      {Key? key,
      required this.urlImage,
      required this.duration,
      required this.title,
      required this.preview,
      required this.index,
      required this.code})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      child: code != 200
          ? const Text(
              'Algo deu errado, verifique se você digitou o campo corretamente',
              style: TextStyle(color: Colors.white, fontSize: 20),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      urlImage,
                      fit: BoxFit.fill,
                      width: 40,
                      height: 40,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Text(
                      title.length > 45 ? title.substring(0, 30) : title,
                      // textDirection: TextDirection.rtl,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )
                ]),
                IconButton(
                    onPressed: () async {
                      await PlayerController.instance.stop();
                      await Future.delayed(const Duration(milliseconds: 7));
                      PlayerController.instance.setImage(urlImage);
                      await PlayerController.instance.play(index);
                    },
                    icon: const Icon(
                      Icons.play_circle,
                      color: Colors.white,
                    ))
              ],
            ),
    );
  }
}
