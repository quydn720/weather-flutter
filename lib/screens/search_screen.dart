import 'package:flutter/material.dart';
import 'package:weather_app/services/constants.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String cityName = '';
  final _text = TextEditingController();
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            TextField(
              controller: _text,
              cursorColor: Colors.black54,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.black54),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.black54),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.black54),
                ),
                hintText: 'Enter city name',
                errorText: _validate ? 'You need to provide a city name' : null,
              ),
              style: kTextStyle.copyWith(color: Colors.black),
              autofocus: true,
              onChanged: (input) {
                setState(() {
                  cityName = input;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _validate = _text.text.isEmpty;
                  if (!_validate) Navigator.pop(context, cityName);
                });
              },
              child: Text('Search'),
            )
          ],
        ),
      ),
    );
  }
}
