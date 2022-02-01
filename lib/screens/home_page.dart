import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spotify_clone/helpers/chose_message.dart';
import 'package:spotify_clone/helpers/list_widgets.dart';
import 'package:spotify_clone/repositories/chart_repositorire.dart';
import 'package:spotify_clone/repositories/resource.dart';
import 'package:spotify_clone/theme/colors.dart';
import 'package:spotify_clone/screens/search.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Resource client = Resource('https://api.deezer.com/', {});

    List<Widget> _widgetOptions = [
      FutureBuilder(
        future: ChartRepositorie(client.dio).all(),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, List<Object>>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              EasyLoading.dismiss();
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
          EasyLoading.show();
          return const SizedBox();
        },
      ),
      const Search(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(choseMessage(_selectedIndex)),
        backgroundColor: ColorPalette.darkItermediare,
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
          color: ColorPalette.darkItermediare,
          child: _widgetOptions[_selectedIndex]),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50.0,
          width: double.maxFinite,
          decoration: const BoxDecoration(
            color: ColorPalette.darkItermediare,
          ),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      onTap: () => _onItemTapped(0),
                      child: Column(
                        children: const [
                          Icon(
                            Icons.home,
                            color: Colors.white,
                          ),
                          Text(
                            'Home',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      )),
                  GestureDetector(
                    onTap: () => _onItemTapped(1),
                    child: Column(
                      children: const [
                        Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        Text(
                          'Pesquisar',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
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
          height: 170,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [...widgets],
          ),
        )
      ]),
    );
  }
}
