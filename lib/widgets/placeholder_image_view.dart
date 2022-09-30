import 'package:flutter/material.dart';

class PlaceholderImageView extends StatelessWidget {
  final double imageSize;

  PlaceholderImageView(this.imageSize);

  @override
  Widget build(BuildContext context) {
    return Center(child: Icon(Icons.image_outlined,color: Colors.white,size: imageSize),);
  }
}