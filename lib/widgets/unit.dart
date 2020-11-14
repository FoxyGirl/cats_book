import 'package:flutter/material.dart';
import 'package:cats_book/import.dart';

class Unit extends StatelessWidget {
  Unit({@required this.unit, this.index});

  final UnitModel unit;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigator.push(UnitScreen(unit).getRoute());
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          border: Border.all(
            color: Colors.grey[200],
            width: 1,
          ),
        ),
        margin: EdgeInsets.only(
            right: index == null ? 0 : 16,
            left: index == 0 ? 16 : 0,
            bottom: 16),
        width: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Stack(
                children: [
                  Hero(
                    tag: unit.imageUrl,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(unit.imageUrl),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // color: pet.favorite ? Colors.red[400] : Colors.white,
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.favorite,
                          size: 16,
                          // color: pet.favorite ? Colors.white : Colors.grey[300],
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: getConditionBackgroundColor(unit.condition),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      getConditionName(unit.condition),
                      style: TextStyle(
                        color: getConditionForegroundColor(unit.condition),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    unit.breed.name,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.grey[600],
                        size: 18,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        unit.address,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                      // SizedBox(
                      //   width: 4,
                      // ),
                      // Text(
                      //   "(" + unit.location + "km)",
                      //   style: TextStyle(
                      //     color: Colors.grey[600],
                      //     fontSize: 12,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
