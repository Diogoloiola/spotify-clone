import 'package:flutter/material.dart';
import 'package:spotify_clone/theme/colors.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _form = GlobalKey<FormState>();
  final _value = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(10),
      color: ColorPalette.darkItermediare,
      child: Column(
        children: [
          Form(
            key: _form,
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
        ],
      ),
    );
  }
}
