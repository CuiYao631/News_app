import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/common/utils/utils.dart';
import 'package:news_app/common/values/values.dart';

Widget btnFlatButtonWidget({
  @required VoidCallback onPressed,
  double width = 140,
  double height = 44,
  Color gbColor = AppColors.primaryElement,
  String title = "button",
  Color fontColor = AppColors.primaryElementText,
  double fontSize = 18,
  String fontName = "Montserrat",
  FontWeight fontWeight = FontWeight.w400,
}) {
  return Container(
    width: duSetWidth(width),
    height: duSetHeight(height),
    child: FlatButton(
      onPressed: onPressed,
      color: gbColor,
      shape: RoundedRectangleBorder(borderRadius: Radii.k6pxRadius),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: fontColor,
            fontWeight: fontWeight,
            fontFamily: fontName,
            fontSize: duSetFontSize(fontSize),
            height: 1),
      ),
    ),
  );
}

Widget btnflatButtonOnlyWidget({
  @required VoidCallback onPessed,
  double width=66,
  double height=44,
  String iconFileName,
}) {
  return Container(
    width: duSetWidth(width),
    height: duSetHeight(height),
    child: FlatButton(
      onPressed: onPessed,
      shape: RoundedRectangleBorder(
        side: Borders.primrayBorder,
        borderRadius: Radii.k6pxRadius
      ),
      child: Image.asset("assets/images/icons-$iconFileName.png"),
    ),
  );
}
