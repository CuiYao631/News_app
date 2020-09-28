import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/common/api/apis.dart';
import 'package:news_app/common/enlity/enlity.dart';
import 'package:news_app/common/utils/utils.dart';
import 'package:news_app/common/values/values.dart';
import 'package:news_app/common/widgets/widgets.dart';

class SginUpPage extends StatefulWidget {
  @override
  _SginUpPageState createState() => _SginUpPageState();
}

class _SginUpPageState extends State<SginUpPage> {
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passController = new TextEditingController();

  _handleNavPop() {
    Navigator.pop(context);
  }

  _handleSignUp() async {
    if (!duCheckStringLength(_nameController.value.text, 5)) {
      tosatInfo(msg: "用户名长度不能小于5位");
      return;
    }
    if (!duISEmail(_emailController.value.text)) {
      tosatInfo(msg: "邮件格式不正确！");
      return;
    }
    if (!duCheckStringLength(_passController.value.text, 6)) {
      tosatInfo(msg: "密码长度不能小于6位");
      return;
    }
    Navigator.pop(context);
  }

  //logo部分
  Widget _buildLogo() {
    return Container(
      width: duSetWidth(110),
      margin: EdgeInsets.only(top: duSetHeight(40)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.only(top: duSetHeight(15)),
            child: Text(
              "注册",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.primaryText,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w600,
                  fontSize: duSetFontSize(24),
                  height: 1),
            ),
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
              controller: _nameController,
              keyboardType: TextInputType.text,
              hintText: "Name",
              marginTop: 0),
          inputTextEdit(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            hintText: "Email",
          ),
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
                onPressed: _handleSignUp,
                gbColor: AppColors.primaryElement,
                title: "创建账号",
                width: 295,
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

  //有账号
  Widget _buildSignupButton() {
    return Container(
      margin: EdgeInsets.only(bottom: duSetHeight(20)),
      child: btnFlatButtonWidget(
        onPressed: _handleNavPop,
        width: 294,
        gbColor: AppColors.secondaryElement,
        fontColor: AppColors.primaryText,
        title: "有账号",
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: transparentAppBar(context: context, actions: <Widget>[
        IconButton(
          icon: Icon(Icons.message),
        ),
      ]),
      body: Center(
        child: Column(
          children: <Widget>[
            Divider(height: 1),
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
