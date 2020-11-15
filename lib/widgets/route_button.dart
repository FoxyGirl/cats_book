import 'package:flutter/material.dart';
import 'package:cats_book/import.dart';

class RouteButton extends StatelessWidget {
  const RouteButton(this.text, this.route);

  final String text;
  final Route route;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      // key: const Key('start_raisedButton'),
      onPressed: () => navigator.push<void>(route),
      textColor: Colors.white,
      padding: const EdgeInsets.all(0),
      shape: const StadiumBorder(),
      child: Container(
        decoration: const ShapeDecoration(
          shape: const StadiumBorder(),
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xFF0D47A1),
              Color(0xFF1976D2),
              Color(0xFF42A5F5),
            ],
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 20,
        ),
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
