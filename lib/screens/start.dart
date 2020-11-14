import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cats_book/import.dart';

class StartScreen extends StatelessWidget {
  Route get route {
    return buildRoute<void>(
      '/start',
      builder: (_) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Pet Finder'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.notifications_none,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
      body: BlocProvider(
        create: (BuildContext context) =>
            StartCubit(getRepository<DatabaseRepository>(context))..load(),
        child: Container(
          child: Center(
            child: Text('Start Screen'),
          ),
        ),
      ),
    );
  }
}
