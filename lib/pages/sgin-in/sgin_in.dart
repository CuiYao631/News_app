import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/common/api/user.dart';
import 'package:news_app/common/enlity/user.dart';
import 'package:news_app/common/utils/utils.dart';
import 'package:news_app/common/values/values.dart';
import 'package:news_app/common/widgets/widgets.dart';
import 'package:news_app/global.dart';

class SginInPage extends StatefulWidget {
  @override
  _SginInPageState createState() => _SginInPageState();
}

class _SginInPageState extends State<SginInPage> {
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passController = new TextEditingController();

  _handleNavSigUp() {
    Navigator.pushNamed(context, "/sgin_up");
  }

  _handleSignIn() async {
    if (!duISEmail(_emailController.value.text)) {
      tosatInfo(msg: "邮件格式不正确！");
      return;
    }
    if (!duCheckStringLength(_passController.value.text, 6)) {
      tosatInfo(msg: "密码长度不能小于6位");
      return;
    }
    UserLoginRequestEntity params=UserLoginRequestEntity(
      email: _emailController.value.text,
      password: duSHA256(_passController.value.text),
    );
    UserLoginResponseEntity userResponse=await UserAPI.login(params: params);
    if(userResponse.displayName=="admin"){
      Global.saveProfile(userResponse);
      Navigator.pushNamed(context, "/app");
    }else{
      tosatInfo(msg: "用户名或者密码错误-登陆失败！");
    }

    //print(userResponse);
  }

  //logo部分
  Widget _buildLogo() {
    return Container(
      width: duSetWidth(110),
      margin: EdgeInsets.only(top: duSetHeight(40 + 44.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: duSetWidth(76),
            width: duSetWidth(76),
            margin: EdgeInsets.symmetric(horizontal: duSetWidth(15)),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  right: 0,
                  child: Container(
                    height: duSetWidth(76),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBackground,
                      boxShadow: [Shadows.primaryShadow],
                      borderRadius: BorderRadius.all(
                          Radius.circular(duSetWidth(76 * 0.5))),
                    ),
                    child: Container(),
                  ),
                ),
                Positioned(
                  top: duSetWidth(13),
                  child: Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.none,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: duSetHeight(15)),
            child: Text(
              "SECTOR",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.primaryText,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w600,
                  fontSize: duSetFontSize(24),
                  height: 1),
            ),
          ),
          Text(
            "新闻",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColors.primaryText,
                fontFamily: "Avenir",
                fontWeight: FontWeight.w400,
                fontSize: duSetFontSize(16),
                height: 1),
          ),
        ],
      ),
    );
  }

  //登录表单
  Widget _buildInputForm() {
    return Container(
      width: duSetWidth(295),
      //height: 204,
      margin: EdgeInsets.only(top: duSetHeight(49)),
      child: Column(
        children: [
          inputTextEdit(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              hintText: "Email",
              marginTop: 0),
          inputTextEdit(
              controller: _passController,
              keyboardType: TextInputType.visiblePassword,
              hintText: "Password",
              isPassword: true),

          ///注册 登录 横向布局
          Container(
            height: duSetHeight(44),
            margin: EdgeInsets.only(top: duSetHeight(15)),
            child: btnFlatButtonWidget(
                    onPressed: _handleSignIn,
                    gbColor: AppColors.primaryElement,
                    title: "登录",
                    width:295,
                    fontWeight: FontWeight.w600),
          ),
          Container(
            height: duSetHeight(22),
            margin: EdgeInsets.only(top: duSetHeight(20)),
            child: FlatButton(
              onPressed: () {},
              child: Text(
                "忘记账号或密码？",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.secondaryElementText,
                    fontFamily: "Avenir",
                    fontWeight: FontWeight.w400,
                    fontSize: duSetFontSize(16),
                    height: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //第三方登录
  Widget _buildThirdPartyLogin() {
    return Container(
      width: duSetHeight(295),
      margin: EdgeInsets.only(bottom: duSetHeight(40)),
      child: Column(
        children: [
          Text(
            "第三方软件登录",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.primaryText,
              fontFamily: "Avenir",
              fontWeight: FontWeight.w400,
              fontSize: duSetFontSize(14),
              height: 1,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: duSetHeight(20)),
            child: Row(
              children: <Widget>[
                btnflatButtonOnlyWidget(
                    onPessed: () {}, width: 66, iconFileName: "twitter"),
                Spacer(),
                btnflatButtonOnlyWidget(
                    onPessed: () {}, width: 66, iconFileName: "google"),
                Spacer(),
                btnflatButtonOnlyWidget(
                    onPessed: () {}, width: 66, iconFileName: "facebook"),
              ],
            ),
          )
        ],
      ),
    );
  }

  //注册按钮
  Widget _buildSignupButton() {
    return Container(
      margin: EdgeInsets.only(bottom: duSetHeight(20)),
      child: btnFlatButtonWidget(
          onPressed: _handleNavSigUp,
          width: 294,
        gbColor: AppColors.secondaryElement,
        fontColor: AppColors.primaryText,
        title: "注册",
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: <Widget>[
            _buildLogo(),
            _buildInputForm(),
            Spacer(),
            _buildThirdPartyLogin(),
            Spacer(),
            _buildSignupButton(),
          ],
        ),
      ),
    );
  }
}
