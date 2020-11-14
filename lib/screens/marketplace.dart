import 'package:flutter/material.dart';
import 'package:cats_book/import.dart';

import '../data.dart';

class MarketPlace extends StatelessWidget {
  const MarketPlace({
    Key key,
    @required this.databaseRepository,
  })  : assert(databaseRepository != null),
        super(key: key);

  final DatabaseRepository databaseRepository;

  Route get route {
    return buildRoute<void>(
      '/marketplace',
      builder: (_) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    print(databaseRepository);
    databaseRepository
        .readUnits(categoryId: CategoryKey.cat)
        .then((value) => out(value))
        .catchError(print);

    return Scaffold(
        appBar: AppBar(title: const Text('MarketPlace')),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                right: 16,
                left: 16,
                top: 16,
                bottom: 32,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Filters:"),
                  Text("Mating"),
                  Text("Adoption"),
                  Text("Disappear"),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: GridView.count(
                  physics: BouncingScrollPhysics(),
                  childAspectRatio: 1 / 1.65,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: catsList.map((cat) {
                    int index = catsList.indexOf(cat);
                    return CatWidget(cat: cat, index: index);
                  }).toList(),
                ),
              ),
            ),
          ],
        ));
  }
}
