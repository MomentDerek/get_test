import 'package:json_annotation/json_annotation.dart';

part 'chat_distribute_message.g.dart';


@JsonSerializable()
class ChatDistributeMessageEntity extends Object {

  @JsonKey(name: 'fromWorkId')
  String fromWorkId;

  @JsonKey(name: 'workIdList')
  List<String> workIdList;

  @JsonKey(name: 'message')
  String message;

  ChatDistributeMessageEntity(this.fromWorkId,this.workIdList,this.message,);

  factory ChatDistributeMessageEntity.fromJson(Map<String, dynamic> srcJson) => _$ChatDistributeMessageEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ChatDistributeMessageEntityToJson(this);

}


