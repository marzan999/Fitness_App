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
              return Container(
                height: 1000,
                child: ListView.separated(
                    itemBuilder: (context, index) => Container(
                          height: 450,
                          color: Color.fromARGB(255, 212, 209, 209),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Colors.grey),
                                      child: Center(
                                        child: Text(
                                          '${allData[index].id}',
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      '${allData[index].title}',
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 150,
                                        width: 280,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    '${allData[index].thumbnail}'),
                                                fit: BoxFit.cover)),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'You have\nto do this\nexercise\n${allData[index].seconds} times\nat a time',
                                        style: TextStyle(fontSize: 25),
                                      )
                                    ],
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'As example:',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    )),
                                SizedBox(
                                  height: 5,
                                ),
                                // Container(
                                //   height: 150,
                                //   width: 280,
                                //   color: Colors.yellow,
                                //   child: Image.network('${allData[index].gif}'),
                                // ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    height: 170,
                                    width: 330,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                '${allData[index].gif}'),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    separatorBuilder: (_, index) => SizedBox(
                          height: 10,
                        ),
                    itemCount: allData.length),
              );
            }),
      ),
    );
  }
}
