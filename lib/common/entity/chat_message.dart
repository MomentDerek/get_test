import 'package:json_annotation/json_annotation.dart';
  
part 'chat_message.g.dart';


@JsonSerializable()
class ChatMessageEntity extends Object {

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'time')
  String time;

  @JsonKey(name: 'sender')
  String sender;

  ChatMessageEntity(this.id,this.message,this.time,this.sender,);

  factory ChatMessageEntity.fromJson(Map<String, dynamic> srcJson) => _$ChatMessageEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ChatMessageEntityToJson(this);

}

  
