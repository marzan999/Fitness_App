import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/model/model.dart';
import 'package:fitness_app/widget/thumbnail.dart';
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
        backgroundColor: Color.fromARGB(255, 172, 168, 137),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 172, 168, 137),
          title: Text(
            'Fit your body',
            style: TextStyle(
                fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: allData.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              // return Text('${allData[index].id}');
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ThumbnailPage(exercise: allData[index])));
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: 300,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    NetworkImage('${allData[index].thumbnail}'),
                                fit: BoxFit.cover)),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 60,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "${allData[index].title}",
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white70,
                                fontWeight: FontWeight.bold),
                          ),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                Colors.black,
                                Colors.black54,
                                Colors.transparent
                              ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter)),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
