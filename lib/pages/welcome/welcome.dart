
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:news_app/common/utils/utils.dart';
import 'package:news_app/common/values/values.dart';
import 'package:news_app/global.dart';

class WelcomePage extends StatefulWidget {

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  ///页头标题
  Widget _buildPageHeadTile(){
    return Container(
      margin: EdgeInsets.only(top: duSetHeight(65)),
      child: Text("特征",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.primaryText,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w600,
          fontSize: duSetFontSize(24),
        ),
      ),
    );
  }
  ///页头说明
  Widget _buildPageHeadDetail(){
    return Container(
      width: duSetWidth(242),
      height: duSetHeight(70),
      margin: EdgeInsets.only(top: duSetHeight(14)),
      child: Text("最好的新闻频道都在一个地方。为您提供可靠的来源和个性化的新闻",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.primaryText,
            fontFamily: "Avenir",
            fontWeight: FontWeight.normal,
              fontSize: duSetFontSize(14),
            height: 2,
          ),
      ),
    );
  }
  ///特性说明
  Widget _buildFeatureItem(String imagename,String intro,double marginTop){
    return Container(
      width: duSetWidth(290),
      height: duSetHeight(80),
      margin: EdgeInsets.only(top: duSetHeight(marginTop)),
      child: Row(
        children: [
          Container(
            width: duSetWidth(80),
            height: duSetHeight(80),
            child: Image.asset("assets/images/$imagename.png",fit: BoxFit.none,),
          ),
          Spacer(),
          Container(
            width: duSetWidth(195),
            child: Text(intro,
            textAlign: TextAlign.left,
              style: TextStyle(
                color: AppColors.primaryText,
                fontFamily: "Avenir",
                fontWeight: FontWeight.normal,
                fontSize: duSetFontSize(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
  ///开始按钮
  Widget _buildStartButton(){
    return Container(
      width: duSetWidth(295),
      height: duSetHeight(44),
      margin: EdgeInsets.only(bottom: duSetHeight(20)),
      child: FlatButton(
        color: AppColors.primaryElement,
        textColor: AppColors.primaryElementText,
        child: Text("开始吧"),
        shape: RoundedRectangleBorder(
          borderRadius:Radii.k6pxRadius,
        ),
        onPressed: (){
          Navigator.pushNamed(context, "/sgin_in");
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //print(Global.profile.displayName);
    ///设置字体大小根据系统的“字体大小”辅助选项来进行缩放,默认为false
    ScreenUtil.init(context, width: 375, height: 812-44-34,allowFontScaling: true);
    return Scaffold(
      body: Center(
        child:Column(
          children: <Widget>[
            _buildPageHeadTile(),
            _buildPageHeadDetail(),
            _buildFeatureItem("feature-3","引人入胜的摄影和排版提供了一个美丽的阅读",86),
            _buildFeatureItem("feature-2","行业新闻从不与广告商或出版商分享你的个人资料",40),
            _buildFeatureItem("feature-1","你可以获得解锁数百个优质的出版物",40),
            Spacer(),
            _buildStartButton(),
          ],
        )
      ),
    );
  }
}
