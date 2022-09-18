import 'package:json_annotation/json_annotation.dart';

part 'user_register.g.dart';


@JsonSerializable()
class UserRegisterEntity extends Object {

  @JsonKey(name: 'workId')
  String workId;

  @JsonKey(name: 'password')
  String password;

  @JsonKey(name: 'username')
  String username;

  UserRegisterEntity(this.workId,this.password,this.username,);

  factory UserRegisterEntity.fromJson(Map<String, dynamic> srcJson) => _$UserRegisterEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserRegisterEntityToJson(this);

}


