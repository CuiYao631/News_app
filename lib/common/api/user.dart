

import 'package:news_app/common/enlity/enlity.dart';
import 'package:news_app/common/utils/utils.dart';

class UserAPI{
  static Future<UserLoginResponseEntity> login({UserLoginRequestEntity params}) async {
    var response = await HttpUtil().post('/user/login', params: params);
    return UserLoginResponseEntity.fromJson(response);
  }
}