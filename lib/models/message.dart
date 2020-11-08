import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:cats_book/import.dart';

part 'message.g.dart';

@CopyWith()
@JsonSerializable()
class MessageModel extends Equatable {
  MessageModel({
    this.id,
    this.text,
    this.author,
    this.isRead,
    this.createdAt,
  });

  final String id;
  final String text;
  final MessageAuthor author;
  final bool isRead;
  final DateTime createdAt;

  @override
  List<Object> get props => [
        id,
        text,
        author,
        isRead,
        createdAt,
      ];

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}

enum MessageAuthor {
  @JsonValue('unit_owner')
  unitOwner,
  companion,
}
