import 'package:json_annotation/json_annotation.dart';

part 'team_member.g.dart';


@JsonSerializable()
class TeamMemberEntity extends Object {

  @JsonKey(name: 'workId')
  String workId;

  @JsonKey(name: 'nickname')
  String? nickname;

  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'phone')
  String? phone;

  @JsonKey(name: 'roles')
  TeamMemberRoles teamMemberRoles;

  TeamMemberEntity(this.workId,this.nickname,this.email,this.phone,this.teamMemberRoles,);

  factory TeamMemberEntity.fromJson(Map<String, dynamic> srcJson) => _$TeamMemberEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TeamMemberEntityToJson(this);

}


@JsonSerializable()
class TeamMemberRoles extends Object {

  @JsonKey(name: 'teamId')
  int teamId;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'sort')
  int sort;

  TeamMemberRoles(this.teamId,this.name,this.code,this.sort,);

  factory TeamMemberRoles.fromJson(Map<String, dynamic> srcJson) => _$TeamMemberRolesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TeamMemberRolesToJson(this);

}


