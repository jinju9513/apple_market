import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String imagePath;

  const ProductImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      width: double.infinity,
      height: 250,
      fit: BoxFit.cover,
    );
  }
}