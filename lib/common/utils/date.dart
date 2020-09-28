



import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String duTimeLineFormat(DateTime dt){
 var now=DateTime.now();
 var difference=now.difference(dt);

 //1天内
  if(difference.inHours<24){
    return"${difference.inHours} 小时前";
  }
  //30天内
  else if(difference.inDays<30){
    return "${difference.inDays} 天前";
  }
  //MM-dd
  else if(difference.inDays<365){
    final dtformat=new DateFormat("MM-dd");
    return dtformat.format(dt);
  }
  //yyyy-MM-dd
  else{
    final dtFormat=new DateFormat("yyyy-M-dd");
    var str=dtFormat.format(dt);
    return str;
  }

}