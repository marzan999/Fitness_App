import 'dart:convert';

import 'package:fitness_app/model/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String link =
      'https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json?fbclid=IwAR0PDhO_MVKiZaUxo0RaG2M0Kt-qVyxwQf3n';
  List<Exercise> allData = [];
  late Exercise exercise;

  fetchData() async {
    var responce = await http.get(Uri.parse(link));
    //print('${responce.body}');

    if (responce.statusCode == 200) {
      var data = jsonDecode(responce.body);
      for (var i in data['exercises']) {
        exercise = Exercise(
            id: i["id"],
            title: i["title"],
            thumbnail: i["thumbnail"],
            seconds: i["seconds"],
            gif: i['gif']);
        setState(() {
          allData.add(exercise);
        });
      }
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
            itemCount: allData.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Text('${allData[index].id}');
            }),
      ),
    );
  }
}
