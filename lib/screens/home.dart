import 'package:flutter/material.dart';
import 'package:cats_book/import.dart';

class HomeScreen extends StatelessWidget {
  Route get route {
    return buildRoute<void>(
      '/home',
      builder: (_) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = getBloc<AuthenticationCubit>(context).state.user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: <Widget>[
          IconButton(
            key: const Key('homeScreen_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () =>
                getBloc<AuthenticationCubit>(context).requestLogout(),
          )
        ],
      ),
      body: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Avatar(photo: user.photo),
            const SizedBox(height: 4.0),
            Text(user.email, style: textTheme.headline6),
            const SizedBox(height: 4.0),
            Text(user.name ?? '', style: textTheme.headline5),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: RaisedButton(
                  key: const Key('start_raisedButton'),
                  // onPressed: () => navigator.push<void>(MarketPlace(
                  //       databaseRepository: DatabaseRepository(),
                  //     ).route),
                  onPressed: () => navigator.push<void>(StartScreen().route),
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
                      'Let`s go!'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
