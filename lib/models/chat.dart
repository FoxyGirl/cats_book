import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:cats_book/import.dart';

part 'chat.g.dart';

@CopyWith()
@JsonSerializable()
class ChatModel extends Equatable {
  ChatModel({
    this.unit,
    this.companion,
    this.messages,
  });

  final UnitModel unit;
  final MemberModel companion;
  final List<MessageModel> messages;

  String get id => '${unit.id} ${companion.id}';

  @override
  List<Object> get props => [
        unit,
        companion,
        messages,
      ];

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);
}
