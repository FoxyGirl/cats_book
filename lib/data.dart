import 'package:cats_book/import.dart';

// enum Category { male, female, kitten, all }
// enum Gender { male, female }
// enum Condition { Adoption, Disappear, Mating }

const catsJSON = [
  {
    "name": "Alisa",
    "breed": "Abyssinian Cats",
    "gender": "female",
    "location": "California",
    "distance": "2.5",
    "condition": "Adoption",
    "image_url": "assets/images/cats/cat_1.jpg",
    "favorite": true,
    "newest": true,
    "birth_date": "2019-05-08T15:26:20.198028+00:00"
  },
  {
    "name": "Scotty",
    "breed": "Scottish Fold",
    "gender": "male",
    "location": "New Jersey",
    "distance": "1.2",
    "condition": "Mating",
    "image_url": "assets/images/cats/cat_2.jpg",
    "favorite": false,
    "newest": false,
    "birth_date": "2019-05-08T15:26:20.198028+00:00"
  },
  {
    "name": "Rageon",
    "breed": "Ragdoll",
    "gender": "male",
    "location": "Miami",
    "distance": "1.2",
    "condition": "Disappear",
    "image_url": "assets/images/cats/cat_3.jpg",
    "favorite": false,
    "newest": false,
    "birth_date": "2019-05-08T15:26:20.198028+00:00"
  },
  {
    "name": "Berta",
    "breed": "Burmés",
    "gender": "female",
    "location": "Chicago",
    "distance": "1.2",
    "condition": "Disappear",
    "image_url": "assets/images/cats/cat_4.jpg",
    "favorite": true,
    "newest": true,
    "birth_date": "2019-05-08T15:26:20.198028+00:00"
  },
  {
    "name": "Arthur",
    "breed": "American Shorthair",
    "gender": "male",
    "location": "Washintong",
    "distance": "1.2",
    "condition": "Mating",
    "image_url": "assets/images/cats/cat_5.jpg",
    "favorite": true,
    "newest": false,
    "birth_date": "2019-05-08T15:26:20.198028+00:00"
  },
  {
    "name": "Bridgite",
    "breed": "British Shorthair",
    "gender": "female",
    "location": "New York",
    "distance": "1.9",
    "condition": "Adoption",
    "image_url": "assets/images/cats/cat_6.jpg",
    "favorite": false,
    "newest": false,
    "birth_date": "2019-05-08T15:26:20.198028+00:00"
  },
  {
    "name": "Romeo",
    "breed": "Abyssinian Cats",
    "gender": "male",
    "location": "California",
    "distance": "2.2",
    "condition": "Adoption",
    "image_url": "assets/images/cats/cat_7.jpg",
    "favorite": true,
    "newest": false,
    "birth_date": "2019-05-08T15:26:20.198028+00:00"
  },
  {
    "name": "Sandra",
    "breed": "Scottish Fold",
    "gender": "female",
    "location": "Florida",
    "distance": "1.2",
    "condition": "Mating",
    "image_url": "assets/images/cats/cat_8.jpg",
    "favorite": false,
    "newest": false,
    "birth_date": "2019-05-08T15:26:20.198028+00:00"
  },
  {
    "name": "Nikolas",
    "breed": "Ragdoll",
    "gender": "male",
    "location": "Miami",
    "distance": "1.2",
    "condition": "Disappear",
    "image_url": "assets/images/cats/cat_9.jpg",
    "favorite": false,
    "newest": true,
    "birth_date": "2019-05-08T15:26:20.198028+00:00"
  }
];

// Fix getting list from JSON
List<CatModel> catsList = catsJSON.map((x) => CatModel.fromJson(x)).toList();
