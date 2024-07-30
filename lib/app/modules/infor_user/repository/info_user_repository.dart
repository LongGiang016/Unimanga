import 'package:unimanga_app/app/modules/infor_user/provider/info_user_provider.dart';

import '../../../models/user.dart';

class InforUserRepository {
  InforUserRepository({required this.inforUserProvider});
  final InforUserProvider inforUserProvider;
  Future<Users?> getUserByUid(String uid) =>
    inforUserProvider.getUserByUid(uid);
}