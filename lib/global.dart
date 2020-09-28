
import 'package:flutter/cupertino.dart';
import 'package:news_app/common/enlity/enlity.dart';
import 'package:news_app/common/utils/storage.dart';
import 'package:news_app/common/utils/utils.dart';
import 'package:news_app/common/values/values.dart';

class Global{
  //用户配置
  static  UserLoginResponseEntity profile=UserLoginResponseEntity(accessToken: null);

  ///是否 release
  static bool get isRelease=>bool.fromEnvironment("dart.vm.product");

  ///init
  static Future init()async{
    ///运行初始化
    ///允许初始化
    WidgetsFlutterBinding.ensureInitialized();
    //工具初始
    await StorageUtil.init();
    HttpUtil();
    var _profileJson=StorageUtil().getJson(STORAGE_USER_PROFILE_KEY);
    if(_profileJson!=null){
      profile=UserLoginResponseEntity.fromJson(_profileJson);
    }

    //http 缓存

    //android 状态栏为透明的沉浸

    //持久化 用户信息

  }
  static Future<bool> saveProfile(UserLoginResponseEntity userResponse){
    profile=userResponse;
    return StorageUtil().setjSON(STORAGE_USER_PROFILE_KEY, userResponse.toJson());
  }
}

