import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/model/model.dart';
import 'package:flutter/material.dart';

class GifPage extends StatefulWidget {
  const GifPage({super.key, required this.exercise});

  final Exercise exercise;

  @override
  State<GifPage> createState() => _GifPageState();
}

class _GifPageState extends State<GifPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          CachedNetworkImage(
            width: double.infinity,
            fit: BoxFit.cover,
            height: double.infinity,
            imageUrl: "${widget.exercise.gif}",
          ),
        ]),
      ),
    );
  }
}
