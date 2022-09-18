import 'package:get/get.dart';
import 'package:get_test/app/data/model/response.dart';
import 'package:get_test/common/api/base.dart';
import 'package:get_test/common/entity/team_member.dart';
import 'package:get_test/common/store/user.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class TeamProvider extends BaseProvider {
  static TeamProvider get to => Get.find();

  Future<ResponseEntity> fetchTeamMemberList() {
    var userStore = UserStore.to;
    return get("/api/system/team/user/"+userStore.teamName)
        .then((value) => ResponseEntity.fromJson(value.body));
  }

  Future<ResponseEntity> updateTeamMember(TeamMemberEntity entity) {
    return post("/api/system/user/update", entity.toJson())
        .then((value) => ResponseEntity.fromJson(value.body));
  }

  Future<ResponseEntity> inviteTeamMember(String workId, String teamName) {
    return post("/api/system/team/user/"+workId+"/"+teamName, null)
        .then((value) => ResponseEntity.fromJson(value.body));
  }


}