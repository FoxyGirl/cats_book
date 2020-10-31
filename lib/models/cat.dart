import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'cat.g.dart';

@CopyWith()
@JsonSerializable()
class CatModel extends Equatable {
  CatModel({
    this.name,
    this.breed,
    this.gender,
    this.location,
    this.distance,
    this.condition,
    this.imageUrl,
    this.favorite,
    this.newest,
    this.birthDate,
  });

  final String name;
  final String breed;
  final String gender;
  final String location;
  final String distance;
  final String condition;
  final String imageUrl;
  final bool favorite;
  final bool newest;
  final String birthDate;

  @override
  List<Object> get props => [
        name,
        breed,
        gender,
        location,
        distance,
        condition,
        imageUrl,
        favorite,
        newest,
        birthDate
      ];

  factory CatModel.fromJson(Map<String, dynamic> json) =>
      _$CatModelFromJson(json);

  Map<String, dynamic> toJson() => _$CatModelToJson(this);
}
