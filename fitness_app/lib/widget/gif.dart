import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/model/model.dart';
import 'package:flutter/material.dart';

class GifPage extends StatefulWidget {
  const GifPage({super.key, required this.exercise, this.second});

  final Exercise exercise;
  final int? second;

  @override
  State<GifPage> createState() => _GifPageState();
}

class _GifPageState extends State<GifPage> {
  late Timer timer;
  int startCount = 0;

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timer.tick == widget.second) {
        timer.cancel();
        Future.delayed(Duration(seconds: 1), () {
          Navigator.of(context).pop();
        });
      }
      setState(() {
        startCount = timer.tick;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          CachedNetworkImage(
            width: double.infinity,
            height: double.infinity,
            imageUrl: "${widget.exercise.gif}",
          ),
          Positioned(
              top: 100,
              right: 20,
              left: 20,
              child: Center(
                  child: Text(
                '${startCount}',
                style: TextStyle(
                    fontSize: 60,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold),
              )))
        ]),
      ),
    );
  }
}
