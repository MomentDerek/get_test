import 'package:json_annotation/json_annotation.dart';

part 'user_password_update.g.dart';


@JsonSerializable()
class UserPasswordUpdateEntity extends Object {

  @JsonKey(name: 'workId')
  String workId;

  @JsonKey(name: 'password')
  String password;

  @JsonKey(name: 'oldPassword')
  String oldPassword;

  UserPasswordUpdateEntity(this.workId,this.password,this.oldPassword,);

  factory UserPasswordUpdateEntity.fromJson(Map<String, dynamic> srcJson) => _$UserPasswordUpdateEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserPasswordUpdateEntityToJson(this);

}


