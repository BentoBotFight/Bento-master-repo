
import 'package:flutter/material.dart';

Map<String, Color> lightThemePallete = {
  'red': const Color(0xffFF5252),
  'blue': const Color(0xff34AFF7),
  'green': const Color(0xff2EDB4B)
};

Map<String, Color> darkThemePallete = {
  'red': const Color(0xffFFB8B8),
  'blue': const Color(0xffB0DCFF),
  'green': const Color(0xffD1FFD9)
};

/*
Color hexToColor(String hexColor) {
  // Remove '#' if it exists in the beginning of the string
  hexColor = hexColor.replaceAll('#', '');

  // Parse hex color string to integer
  int hexValue = int.parse(hexColor, radix: 16);

  // Return Color object
  return Color(hexValue | 0xFF000000); // Set alpha value to fully opaque
}
*/

Color colorConversion(BuildContext context, String color){
  var currentMode = MediaQuery.of(context).platformBrightness;

  //if lightmode is enabled, convert to color using light theme pallete
  if(currentMode == Brightness.light){
    return lightThemePallete[color]!;
  }
  else if(currentMode == Brightness.dark){
    return darkThemePallete[color]!;
  }
  else{
    return lightThemePallete[color]!;
  }
}