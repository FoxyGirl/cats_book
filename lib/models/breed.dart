import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'breed.g.dart';

@JsonSerializable()
class BreedModel extends Equatable {
  BreedModel({
    this.id,
    this.name,
  });

  final String id;
  final String name;

  @override
  List<Object> get props => [id, name];

  static BreedModel fromJson(Map<String, dynamic> json) =>
      _$BreedModelFromJson(json);

  Map<String, dynamic> toJson() => _$BreedModelToJson(this);
}