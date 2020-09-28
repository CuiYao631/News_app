
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_app/common/utils/utils.dart';
import 'package:news_app/common/values/values.dart';
import 'package:news_app/global.dart';

class HttpUtil{
  static HttpUtil _instance=HttpUtil._internal();
  factory HttpUtil()=>_instance;
  Dio dio;
  CancelToken cancelToken=new CancelToken();

  HttpUtil._internal(){
    //BaseOpton ,OPtion RequestOption 都可以配置参数，优先级别依次递增，
    BaseOptions options=new BaseOptions(
      //请求基地址，可以包含子路径
      baseUrl: SERVER_API_URL,
      //连接服务器超时时间，单位是毫秒
      connectTimeout: 10000,

      //响应流上前后两次接受到数据间隔，单位为毫秒
      receiveTimeout: 5000,

      //http请求头
      headers: {},

      ///请求的Content-Type 默认值是application/json; charset=utf-8
      ///如果想以"application/x-www/form-urlencoded"格式编码请求数据
      ///可以设置此选项为 `Headers.formUrlEncodedContentType`
      contentType: 'application/json; charset=utf-8',

      responseType: ResponseType.json,
    );
    dio =new Dio(options);
    //cookie管理
    CookieJar cookieJar= CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));

    //添加拦截器
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options){
      return options;
    },onResponse: (Response response){
      return response;
    },onError: (DioError e){
      return e;
    },
    ));
    ///加内存缓存
    dio.interceptors.add(NetCache());

    ///在调试模式下需要抓包调试，所以我们使用代理，并禁用HTTPS证书校验
    if(!Global.isRelease&&PROXY_ENABLE){
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate=
          (client){
        client.findProxy=(uri){
          return "PROXY $PROXY_IP:$PROXY_PORT";
        };
        ///代理工具回提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
        client.badCertificateCallback=
        (X509Certificate cert,String host,int port)=>true;
      };
    }
  }
  /*
    error统一处理
   */
  //错误信息
  ErrorEntity createErrorEntity(DioError error){
    switch(error.type){
      case DioErrorType.CANCEL:
        return ErrorEntity(code:-1,message:"取消操作");
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        return ErrorEntity(code: -1,message: "连接超时");
        break;
      case DioErrorType.SEND_TIMEOUT:
        return ErrorEntity(code: -1,message: "请求超时");
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        return ErrorEntity(code: -1,message: "响应超时");
        break;
      case DioErrorType.RESPONSE:
        try{
          int errCode=error.response.statusCode;
          switch(errCode){
            case 400:
              return ErrorEntity(code: errCode,message: "请求语法错误");
              break;
            case 401:
              return ErrorEntity(code: errCode,message: "没有权限");
              break;
            case 403:
              return ErrorEntity(code: errCode,message: "服务器拒绝执行");
              break;
            case 404:
              return ErrorEntity(code: errCode,message: "无法连接服务器");
              break;
            case 405:
              return ErrorEntity(code: errCode,message: "请求方法被禁止");
              break;
            case 500:
              return ErrorEntity(code: errCode,message: "服务器内部错误");
              break;
            case 502:
              return ErrorEntity(code: errCode,message: "无效的请求");
              break;
            case 503:
              return ErrorEntity(code: errCode,message: "服务器挂了");
              break;
            case 504:
              return ErrorEntity(code: errCode,message: "不支持HTTP协议请求");
              break;
            default:
              return ErrorEntity(code: errCode,message: error.response.statusMessage);

          }
        } on Exception catch(_){
          return ErrorEntity(code: -1,message: "未知错误");
        }
        break;
      default:
        return ErrorEntity(code: -1,message: error.message);
    }
  }

  //取消请求
  void cancelRequests(CancelToken token){
    token.cancel("cancelled");
  }
  /// 读取本地配置
  Map<String, dynamic> getAuthorizationHeader() {
    var headers;
    String accessToken = Global.profile.accessToken;
    if (accessToken != null) {
      headers = {
        'Authorization': 'Bearer $accessToken',
      };
    }
    return headers;
  }
///restful get 操作
  Future get(String path,{dynamic params,Options options,bool refresh=false,bool noCache=!CACHE_ENABLE,bool list=false,String cacheKey})async{
    try{
      Options requestOptions=options ?? Options();
      requestOptions=requestOptions.merge(extra: {
        "refresh":refresh,
        "noCache":noCache,
        "list":list,
        "cacheKey":cacheKey
      });
      Map<String,dynamic> _authorization=getAuthorizationHeader();
      if(_authorization!=null){
        requestOptions=requestOptions.merge(headers: _authorization);
      }
      var response =await  dio.get(path,
          queryParameters: params,
          options: requestOptions,
          cancelToken: cancelToken);
      return response.data;
    } on DioError catch(e){
      throw createErrorEntity(e);
    }
  }

  /// restful post 操作
  Future post(String path,
      {dynamic params, Options options, CancelToken cancelToken}) async {
    try {
      Options requestOptions=options ?? Options();
      Map<String,dynamic> _authorization=getAuthorizationHeader();
      if(_authorization!=null){
        requestOptions=requestOptions.merge(headers: _authorization);
      }
      var response = await dio.post(path,data: params, options: requestOptions, cancelToken: cancelToken);
      return response.data;
    } on DioError catch (e) {
      throw createErrorEntity(e);
    }
  }

  Future put(String path,{dynamic params,Options options,CancelToken cancelToken})async{
    try{
      Options requestOptions=options ?? Options();
      Map<String,dynamic> _authorization=getAuthorizationHeader();
      if(_authorization!=null){
        requestOptions=requestOptions.merge(headers: _authorization);
      }
      var response =await  dio.put(path,
          data: params,
          options: requestOptions,
          cancelToken: cancelToken);
      return response.data;
    } on DioError catch(e){
      throw createErrorEntity(e);
    }
  }

  Future delete(String path,{dynamic params,Options options,CancelToken cancelToken})async{
    try{
      Options requestOptions=options ?? Options();
      Map<String,dynamic> _authorization=getAuthorizationHeader();
      if(_authorization!=null){
        requestOptions=requestOptions.merge(headers: _authorization);
      }
      var response =await  dio.delete(path,
          data: params,
          options: requestOptions,
          cancelToken: cancelToken);
      return response.data;
    } on DioError catch(e){
      throw createErrorEntity(e);
    }
  }

  Future postForm(String path,{dynamic params,Options options,CancelToken cancelToken})async{
    try{
      Options requestOptions=options ?? Options();
      Map<String,dynamic> _authorization=getAuthorizationHeader();
      if(_authorization!=null){
        requestOptions=requestOptions.merge(headers: _authorization);
      }
      var response =await  dio.post(path,
          data: params,
          options: requestOptions,
          cancelToken: cancelToken);
      return response.data;
    } on DioError catch(e){
      throw createErrorEntity(e);
    }
  }


}
class ErrorEntity implements Exception{
 int code ;
 String message;
 ErrorEntity({this.code,this.message});
 String toString(){
   if(message==null)return "Exception";
   return "Exception: code: $code,$message";
 }
}