import 'package:flutter/cupertino.dart';

class GetSize {
  static double height(BuildContext context) => MediaQuery.of(context).size.height;
  static double width(BuildContext context) => MediaQuery.of(context).size.width;

  static bool isDesktop(BuildContext context) => width(context) >= 600;

}