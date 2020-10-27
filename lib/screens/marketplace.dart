import 'package:flutter/material.dart';
import 'package:cats_book/import.dart';

class MarketPlace extends StatelessWidget {
  Route get route {
    return buildRoute<void>(
      '/marketplace',
      builder: (_) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MarketPlace')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            'MarketPlace',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
