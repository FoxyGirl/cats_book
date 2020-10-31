// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cat.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension CatModelCopyWith on CatModel {
  CatModel copyWith({
    String birthDate,
    String breed,
    String condition,
    String distance,
    bool favorite,
    String gender,
    String imageUrl,
    String location,
    String name,
    bool newest,
  }) {
    return CatModel(
      birthDate: birthDate ?? this.birthDate,
      breed: breed ?? this.breed,
      condition: condition ?? this.condition,
      distance: distance ?? this.distance,
      favorite: favorite ?? this.favorite,
      gender: gender ?? this.gender,
      imageUrl: imageUrl ?? this.imageUrl,
      location: location ?? this.location,
      name: name ?? this.name,
      newest: newest ?? this.newest,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatModel _$CatModelFromJson(Map<String, dynamic> json) {
  return CatModel(
    name: json['name'] as String,
    breed: json['breed'] as String,
    gender: json['gender'] as String,
    location: json['location'] as String,
    distance: json['distance'] as String,
    condition: json['condition'] as String,
    imageUrl: json['image_url'] as String,
    favorite: json['favorite'] as bool,
    newest: json['newest'] as bool,
    birthDate: json['birth_date'] as String,
  );
}

Map<String, dynamic> _$CatModelToJson(CatModel instance) => <String, dynamic>{
      'name': instance.name,
      'breed': instance.breed,
      'gender': instance.gender,
      'location': instance.location,
      'distance': instance.distance,
      'condition': instance.condition,
      'image_url': instance.imageUrl,
      'favorite': instance.favorite,
      'newest': instance.newest,
      'birth_date': instance.birthDate,
    };
