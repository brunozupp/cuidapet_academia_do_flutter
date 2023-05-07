import 'package:flutter_screenutil/flutter_screenutil.dart';

extension SizeScreenExtension on num {
  double get w => ScreenUtil().setWidth(this);

  double get h => ScreenUtil().setHeight(this);

  double get r => ScreenUtil().radius(this);

  // Font Size adaption
  double get sp => ScreenUtil().setSp(this);

  // Width relative to screen
  double get sw => ScreenUtil().screenWidth * this;

  // Height relative to screen
  double get sh => ScreenUtil().screenHeight * this;

  double get statusBar => ScreenUtil().statusBarHeight * this;
}