import 'package:flutter/cupertino.dart';

/// GetSize class provides the height and width of the screen.
class GetSize {
  static double height(BuildContext context) => MediaQuery.of(context).size.height; /// returns the height of the screen
  static double width(BuildContext context) => MediaQuery.of(context).size.width; /// returns the width of the screen

  /// checks if the code is running in desktop
  /// condition is if the width is >= 6000, that means the screen is desktop
  static bool isDesktop(BuildContext context) => width(context) >= 600;

}