import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/model/model.dart';
import 'package:fitness_app/widget/gif.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class ThumbnailPage extends StatefulWidget {
  ThumbnailPage({super.key, required this.exercise});

  final Exercise exercise;

  @override
  State<ThumbnailPage> createState() => _ThumbnailPageState();
}

class _ThumbnailPageState extends State<ThumbnailPage> {
  int second = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            CachedNetworkImage(
              width: double.infinity,
              fit: BoxFit.cover,
              height: double.infinity,
              imageUrl: "${widget.exercise.thumbnail}",
            ),
            Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: SleekCircularSlider(
                  min: 0,
                  max: 30,
                  initialValue: second.toDouble(),
                  onChange: (double value) {
                    setState(() {
                      second = value.toInt();
                    });
                  },
                  innerWidget: (double value) {
                    return Center(
                        child: Column(
                      children: [
                        SizedBox(
                          height: 45,
                        ),
                        Text(
                          '$second',
                          style: TextStyle(fontSize: 45, color: Colors.orange),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => GifPage(
                                      exercise: widget.exercise,
                                    )));
                          },
                          child: Text('Start'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey),
                        )
                      ],
                    ));
                  },
                ))
          ],
        ),
      ),
    );
  }
}
