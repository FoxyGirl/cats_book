import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cats_book/import.dart';

class ShowcaseScreen extends StatelessWidget {
  ShowcaseScreen({this.category, this.query});

  Route<T> getRoute<T>() {
    return buildRoute<T>(
      '/showcase?category_id=${category?.id}&query=$query',
      builder: (_) => this,
      fullscreenDialog: true,
    );
  }

  final CategoryModel category;
  final String query;

  @override
  Widget build(BuildContext context) {
    // timeDilation = 2.0; // Will slow down animations by a factor of two
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          category == null
              ? 'Showcase by "$query"'
              : '${category.name} Category',
          style: TextStyle(
            color: Colors.grey[800],
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.more_horiz,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
      body: BlocProvider(
        create: (BuildContext context) =>
            ShowcaseCubit(getRepository<DatabaseRepository>(context))
              ..load(categoryId: category?.id, query: query),
        child: ShowcaseBody(),
      ),
      floatingActionButton: category == null
          ? null
          : FloatingActionButton(
              onPressed: () {
                // navigator.push(AddUnitScreen(category: category).getRoute());
                out('navigate to AddUnitScreen');
              },
              tooltip: 'Add your pet',
              child: Icon(Icons.add),
            ),
    );
  }
}

// TODO: добавить поле ввода для поиска (продублировать с HomeScreen)
// TODO: добавить выбор категории (продублировать с HomeScreen)

class ShowcaseBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowcaseCubit, ShowcaseState>(
        builder: (BuildContext context, ShowcaseState state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TODO: добавить фильт по ConditionValue
          // Material(
          //   child: Padding(
          //     padding:
          //         EdgeInsets.only(right: 16, left: 16, top: 16, bottom: 32),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         buildFilter("Mating", false),
          //         buildFilter("Adoption", true),
          //         buildFilter("Disappear", true),
          //       ],
          //     ),
          //   ),
          //   // elevation: 2, // TODO: add elevation
          // ),
          if (state.status == ShowcaseStatus.initial)
            Spacer()
          else if (state.status == ShowcaseStatus.loading)
            Expanded(
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: kWidthCircularProgressIndicator,
                ),
              ),
            )
          else if (state.units.length == 0)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'Nothing was found :(',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: RouteButton('Try again!', StartScreen().route),
                    ),
                  ),
                ],
              ),
            )
          else
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: GridView.count(
                  physics: BouncingScrollPhysics(),
                  childAspectRatio:
                      1 / 1.55, // TODO: нулевой индекс - неверная ширина Unit
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  children: List.generate(state.units.length,
                      (int index) => Unit(unit: state.units[index])),
                ),
              ),
            ),
        ],
      );
    });
  }
}

// Widget buildFilter(String name, bool selected) {
//   return Container(
//     padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.all(
//         Radius.circular(20),
//       ),
//       border: Border.all(
//         width: 1,
//         color: selected ? Colors.transparent : Colors.grey[300],
//       ),
//       boxShadow: [
//         BoxShadow(
//           color: selected ? Colors.blue[300].withOpacity(0.5) : Colors.white,
//           spreadRadius: 3,
//           blurRadius: 5,
//           offset: Offset(0, 0),
//         ),
//       ],
//       color: selected ? Colors.blue[300] : Colors.white,
//     ),
//     child: Row(
//       children: [
//         Text(
//           name,
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.bold,
//             color: selected ? Colors.white : Colors.grey[800],
//           ),
//         ),
//         selected
//             ? Row(
//                 children: [
//                   SizedBox(
//                     width: 8,
//                   ),
//                   Icon(
//                     Icons.clear,
//                     color: Colors.white,
//                     size: 18,
//                   ),
//                 ],
//               )
//             : Container(),
//       ],
//     ),
//   );
// }
