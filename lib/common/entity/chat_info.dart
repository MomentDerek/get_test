import 'package:json_annotation/json_annotation.dart';

part 'chat_info.g.dart';


@JsonSerializable()
class ChatInfoEntity extends Object {

  @JsonKey(name: 'lastMessage')
  String lastMessage;

  @JsonKey(name: 'workId')
  String workId;

  @JsonKey(name: 'nickname')
  String? nickname;

  @JsonKey(name: 'lastTime')
  String lastTime;

  @JsonKey(name: 'sender')
  String sender;

  ChatInfoEntity(this.lastMessage,this.workId,this.nickname,this.lastTime,this.sender,);

  factory ChatInfoEntity.fromJson(Map<String, dynamic> srcJson) => _$ChatInfoEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ChatInfoEntityToJson(this);

}


