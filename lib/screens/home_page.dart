import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spotify_clone/helpers/list_widgets.dart';
import 'package:spotify_clone/repositories/chart_repositorire.dart';
import 'package:spotify_clone/repositories/resource.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Resource client = Resource('https://api.deezer.com/', {});

    return Scaffold(
      appBar: AppBar(
        title: const Text('Boa noite'),
        backgroundColor: Colors.black,
        actions: const [
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.bell,
              color: Colors.white,
            ),
            tooltip: 'Notificações',
            onPressed: null,
          ),
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.redoAlt,
              color: Colors.white,
            ),
            tooltip: 'Show Snackbar',
            onPressed: null,
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            tooltip: 'Show Snackbar',
            onPressed: null,
          ),
        ],
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(10),
          color: Colors.black,
          child: FutureBuilder(
            future: ChartRepositorie(client.dio).all(),
            builder: (BuildContext context,
                AsyncSnapshot<Map<String, List<Object>>> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  return ListView(
                    children: [
                      ListElements(
                        title: 'Podcast',
                        type: 1,
                        widgets: getWidgets(snapshot.data!['podcasts']),
                      ),
                      ListElements(
                        title: 'Albums',
                        type: 1,
                        widgets: getWidgets(snapshot.data!['albums']),
                      ),
                      ListElements(
                        title: 'Playlists',
                        type: 1,
                        widgets: getWidgets(snapshot.data!['playlists']),
                      ),
                      ListElements(
                        title: 'Tracks',
                        type: 1,
                        widgets: getWidgets(snapshot.data!['tracks']),
                      ),
                    ],
                  );
                }
              }
              return const CircularProgressIndicator();
            },
          )),
    );
  }
}

class ListElements extends StatelessWidget {
  final String title;
  final int type;
  final List<Widget> widgets;

  const ListElements(
      {Key? key, required this.title, this.type = 1, required this.widgets})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 4, top: 20),
      child: Column(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(bottom: 20),
          child: Text(
            title,
            textDirection: TextDirection.ltr,
            style: const TextStyle(
                color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [...widgets],
          ),
        )
      ]),
    );
  }
}
