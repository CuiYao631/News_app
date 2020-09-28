


import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:news_app/common/values/values.dart';
class CacheObject{
  CacheObject(this.response)
    :timeStamp=DateTime.now().millisecondsSinceEpoch;
  Response response;
  int timeStamp;

  @override
  bool operator==(other){
    return response.hashCode==other.hashCode;
  }

  @override
  int get hashCode=>response.realUri.hashCode;
}


class NetCache extends Interceptor{
  var cache=LinkedHashMap<String,CacheObject>();

  @override
  Future onRequest(RequestOptions options) async {
    if(!CACHE_ENABLE) return options;

    ///refresh标记是否为“下拉刷新”
    bool refresh=options.extra["refresh"]==true;
    ///如果是下拉刷新，先删除相关缓存
    if(refresh){
      ///若是列表，则只要URL中包含当前PATH的缓存全部删除
      if(options.extra["list"]==true){
        cache.removeWhere((key, value) => key.contains(options.path));
        ///如果不是列表，则只删除URL相同的缓存
      }else{
        delete(options.uri.toString());
      }
    }
    ///get请求开启缓存
    if(options.extra["noCache"]!=true&&options.method.toLowerCase()=="get"){
      String key=options.extra["cacheKey"]??options.uri.toString();
      var ob =cache[key];
      if(ob!=null){
        //若缓存未过期，则返回缓存内容
        if((DateTime.now().millisecondsSinceEpoch-ob.timeStamp)/1000<CACHE_MAXAGE){
          return cache[key].response;
        }else{
          cache.remove(key);
        }
      }
    }
  }
  @override
  Future onError(DioError err)async {
    ///错误状态不缓存
  }
  @override
  Future onResponse(Response response) async{
   ///如果启用缓存，将返回结果保存到缓存
    if(CACHE_ENABLE){
      _saveCache(response);
    }
  }
  _saveCache(Response object){
    RequestOptions options=object.request;
    ///只缓存get 的请求
    if(options.extra['noCache']!=true&&options.method.toLowerCase()=="get"){
      ///如果缓存数量超过最大数量限制，则先移除最早的一条记录
      if(cache.length==CACHE_MAXCOUNT){
        cache.remove(cache[cache.keys.first]);
      }
      String key=options.extra["cacheKey"]??options.uri.toString();
      cache[key]=CacheObject(object);
    }
  }
  void delete(String key){
    cache.remove(key);
  }

}