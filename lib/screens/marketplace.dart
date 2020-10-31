import 'package:flutter/material.dart';
import 'package:cats_book/import.dart';

import '../data.dart';

class MarketPlace extends StatelessWidget {
  Route get route {
    return buildRoute<void>(
      '/marketplace',
      builder: (_) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    print(catsJSON.runtimeType);
    print('catsList ${catsList.runtimeType} ${catsList.length}');
    var cat = catsList[0];
    print('first act = ${cat.name}');

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
