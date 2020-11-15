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
        child: StartBody(),
      ),
    );
  }
}

class StartBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenPadding = 8.0;
    final height = 80.0;
    final margin = 8.0;
    final crossAxisCount = 2;
    final childAspectRatio =
        ((screenWidth - screenPadding * 2) / crossAxisCount) /
            (height + margin * 2);
    return BlocBuilder<StartCubit, StartState>(
      builder: (BuildContext context, StartState state) {
        if (state.status == StartStatus.loading) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.blue,
              ),
              strokeWidth: kWidthCircularProgressIndicator,
            ),
          );
        }

        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Find your pet',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                child: Text(
                  'Lovely pet in anywere',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 24,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: TextField(
                  onSubmitted: (String value) => {out(value)},
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(fontSize: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding: EdgeInsets.only(
                      right: 30,
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(right: 16.0, left: 16.0),
                      child: Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pet Category',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    Icon(
                      Icons.more_horiz,
                      color: Colors.grey[800],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenPadding),
                child: GridView.count(
                  crossAxisCount: crossAxisCount,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  childAspectRatio: childAspectRatio,
                  children: List.generate(
                      state.categories.length,
                      (int index) => _PetCategory(
                          category: state.categories[index], margin: margin)),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Newest Pet',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.more_horiz,
                      color: Colors.grey[800],
                    ),
                  ],
                ),
              ),
              Container(
                height: 280,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                    state.units.length,
                    (index) => Unit(unit: state.units[index], index: index),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class _PetCategory extends StatelessWidget {
  const _PetCategory({
    Key key,
    @required this.category,
    @required this.margin,
  }) : super(key: key);

  final CategoryModel category;
  final double margin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(category.name);
      },
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.all(margin),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[200],
            width: 1,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: [
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: HexColor(category.color).withOpacity(0.5),
              ),
              child: Center(
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: Image.asset(
                    'assets/images/${category.id}.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  category.name,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Total of ${category.totalOf}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
