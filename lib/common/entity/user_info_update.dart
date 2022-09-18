import 'package:json_annotation/json_annotation.dart';

part 'user_info_update.g.dart';


@JsonSerializable()
class UserInfoUpdateEntity extends Object {

  @JsonKey(name: 'workId')
  String workId;

  @JsonKey(name: 'nickname')
  String? nickname;

  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'phone')
  String? phone;

  UserInfoUpdateEntity(this.workId,this.nickname,this.email,this.phone,);

  factory UserInfoUpdateEntity.fromJson(Map<String, dynamic> srcJson) => _$UserInfoUpdateEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserInfoUpdateEntityToJson(this);

}


