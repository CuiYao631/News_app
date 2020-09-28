

import 'dart:convert';

import 'package:news_app/common/values/values.dart';
import 'package:shared_preferences/shared_preferences.dart';

///本地储存
///单例 StorageUtil().getItem('key')
class StorageUtil{
  static final StorageUtil _instance=new StorageUtil._();
  factory StorageUtil()=>_instance;
  static SharedPreferences _prefs;

  StorageUtil._();

  static Future<void> init()async{
    if(_prefs==null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }
  //设置JSON对象
  Future<bool> setjSON(String key,dynamic jsonVal){
    String jsonString =jsonEncode(jsonVal);
    return _prefs.setString(key, jsonString);
  }
  //获取JSON对象
  dynamic getJson(String key){
    String jsonString=_prefs.getString(key);
    return jsonString==null ? null:jsonDecode(jsonString);
  }
}