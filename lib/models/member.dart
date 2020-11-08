import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'member.g.dart';

@CopyWith()
@JsonSerializable()
class MemberModel extends Equatable {
  MemberModel({
    this.id,
    this.name,
    this.avatarUrl,
  });

  final String id;
  final String name;
  @JsonKey(nullable: true)
  final String avatarUrl;

  @override
  List<Object> get props => [
        id,
        name,
        avatarUrl,
      ];

  String get avatarUrlOrRobohash =>
      avatarUrl ?? 'https://robohash.org/$id?set=set4';

  factory MemberModel.fromJson(Map<String, dynamic> json) =>
      _$MemberModelFromJson(json);

  Map<String, dynamic> toJson() => _$MemberModelToJson(this);
}
