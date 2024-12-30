import 'package:flutter/material.dart';

class SaladPage extends StatelessWidget {
  final String categoryName;

  SaladPage({required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Salads'),
      ),
    );
  }
}