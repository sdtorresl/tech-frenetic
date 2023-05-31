import 'package:flutter/material.dart';

final ThemeData techFreneticTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xff006ee8),
  primaryColorLight: const Color(0xFFF5F9FF),
  primaryColorDark: const Color(0xff004999),
  canvasColor: const Color(0xfffafafa),
  scaffoldBackgroundColor: const Color(0xfffafafa),
  bottomAppBarColor: const Color(0xffffffff),
  cardColor: const Color(0xffffffff),
  dividerColor: const Color(0x1f000000),
  highlightColor: const Color(0x66bcbcbc),
  splashColor: const Color(0x66c8c8c8),
  selectedRowColor: const Color(0xfff5f5f5),
  unselectedWidgetColor: const Color(0x8a000000),
  disabledColor: const Color(0x61000000),
  toggleableActiveColor: const Color(0xff0061cc),
  secondaryHeaderColor: const Color(0xffe5f2ff),
  backgroundColor: const Color(0xffcce4ff),
  dialogBackgroundColor: const Color(0xffffffff),
  indicatorColor: const Color(0xFF006EE8),
  hintColor: const Color(0x8a000000),
  errorColor: const Color(0xffd32f2f),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.all(10)),
      textStyle: MaterialStateProperty.resolveWith<TextStyle>(
          (Set<MaterialState> states) {
        return const TextStyle(
          fontFamily: 'NunitoSansBold',
          fontSize: 20,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        );
      }),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.all(10)),
      backgroundColor:
          MaterialStateProperty.all<Color>(const Color(0xf5f9ffff)),
      textStyle: MaterialStateProperty.resolveWith<TextStyle>(
          (Set<MaterialState> states) {
        return const TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: 20,
          fontStyle: FontStyle.normal,
        );
      }),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
      side: MaterialStateProperty.all<BorderSide>(
        const BorderSide(
          color: Color(0xff006ee8),
        ),
      ),
    ),
  ),
  buttonTheme: const ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    minWidth: 140,
    height: 44,
    padding: EdgeInsets.only(top: 20, bottom: 20, left: 36, right: 36),
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: Color(0xff000000),
        width: 0,
        style: BorderStyle.none,
      ),
      borderRadius: BorderRadius.zero,
    ),
    alignedDropdown: false,
    buttonColor: Color(0xff006ee8),
    disabledColor: Color(0xffeaeaf4),
    highlightColor: Color(0x00000000),
    splashColor: Color(0x1fffffff),
    focusColor: Color(0x1f000000),
    hoverColor: Color(0x0a000000),
    colorScheme: ColorScheme(
      primary: Color(0xff006ee8),
      primaryContainer: Color(0xff004999),
      secondary: Color(0xff0079ff),
      secondaryContainer: Color(0xff004999),
      surface: Color(0xffffffff),
      background: Color(0xff99c9ff),
      error: Color(0xffd32f2f),
      onPrimary: Color(0xffffffff),
      onSecondary: Color(0xffffffff),
      onSurface: Color(0xff000000),
      onBackground: Color(0xffffffff),
      onError: Color(0xffffffff),
      brightness: Brightness.light,
    ),
  ),
  textTheme: const TextTheme(
    headline6: TextStyle(
      color: Colors.black,
      fontFamily: 'NunitoSans',
      fontSize: 10,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    headline5: TextStyle(
      color: Colors.black,
      fontFamily: 'NunitoSansBold',
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    headline4: TextStyle(
      color: Colors.black,
      fontFamily: 'NunitoSansBold',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    headline3: TextStyle(
      color: Colors.black,
      fontFamily: 'NunitoSansBold',
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    headline2: TextStyle(
      color: Colors.black,
      fontFamily: 'NunitoSansBold',
      fontSize: 18,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    headline1: TextStyle(
      color: Color(0xff000000),
      fontFamily: 'NunitoSansBold',
      fontSize: 20,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    bodyText2: TextStyle(
      color: Color(0xdd000000),
      fontFamily: 'NunitoSans',
      fontSize: 14,
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.normal,
    ),
    bodyText1: TextStyle(
      color: Color(0xdd000000),
      fontFamily: 'NunitoSans',
      fontSize: 16,
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.normal,
    ),
    caption: TextStyle(
      color: Colors.black,
      fontFamily: 'NunitoSans',
      fontSize: 8,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    button: TextStyle(
      color: Color(0xdd000000),
      fontFamily: 'NunitoSans',
      fontSize: 17,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
    ),
    subtitle1: TextStyle(
      color: Color(0xff000000),
      fontFamily: 'NunitoSans',
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    subtitle2: TextStyle(
      color: Color(0xff000000),
      fontFamily: 'NunitoSans',
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    overline: TextStyle(
      color: Color(0xff000000),
      fontFamily: 'NunitoSans',
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(
      color: Color(0xdd000000),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    helperStyle: TextStyle(
      color: Color(0xdd000000),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    hintStyle: TextStyle(
      color: Color(0xff9e9e9e),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    errorStyle: TextStyle(
      color: Colors.red,
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    errorMaxLines: null,
    isDense: false,
    contentPadding: EdgeInsets.only(top: 12, bottom: 12, left: 0, right: 0),
    isCollapsed: false,
    prefixStyle: TextStyle(
      color: Color(0xdd000000),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    suffixStyle: TextStyle(
      color: Color(0xdd000000),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    counterStyle: TextStyle(
      color: Color(0xdd000000),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    filled: false,
    fillColor: Color(0x00000000),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
        width: 2,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xff006ee8),
        width: 2,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xff000000),
        width: 2,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xff000000),
        width: 2,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xff000000),
        width: 2,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xff000000),
        width: 2,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
  ),
  iconTheme: const IconThemeData(
    color: Color(0xdd000000),
    opacity: 1,
    size: 24,
  ),
  primaryIconTheme: const IconThemeData(
    color: Color(0xffffffff),
    opacity: 1,
    size: 24,
  ),
  sliderTheme: const SliderThemeData(
    activeTrackColor: null,
    inactiveTrackColor: null,
    disabledActiveTrackColor: null,
    disabledInactiveTrackColor: null,
    activeTickMarkColor: null,
    inactiveTickMarkColor: null,
    disabledActiveTickMarkColor: null,
    disabledInactiveTickMarkColor: null,
    thumbColor: null,
    disabledThumbColor: null,
    thumbShape: null,
    overlayColor: null,
    valueIndicatorColor: null,
    valueIndicatorShape: null,
    showValueIndicator: null,
    valueIndicatorTextStyle: TextStyle(
      color: Color(0xffffffff),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
  ),
  tabBarTheme: const TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
    labelColor: Color(0xffffffff),
    unselectedLabelColor: Color(0xb2ffffff),
  ),
  chipTheme: const ChipThemeData(
    backgroundColor: Color.fromRGBO(5, 20, 47, 1),
    brightness: Brightness.light,
    deleteIconColor: Color(0xde000000),
    disabledColor: Color(0x0c000000),
    labelPadding: EdgeInsets.only(top: 0, bottom: 0, left: 8, right: 8),
    labelStyle: TextStyle(
      color: Color.fromRGBO(5, 20, 47, 1),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    padding: EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
    secondaryLabelStyle: TextStyle(
      color: Color(0x3d000000),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    secondarySelectedColor: Color(0x3d006ee8),
    selectedColor: Colors.white,
    shape: StadiumBorder(
      side: BorderSide(
        color: Color(0xff000000),
        width: 0,
        style: BorderStyle.none,
      ),
    ),
  ),
  dialogTheme: const DialogTheme(
      shape: RoundedRectangleBorder(
    side: BorderSide(
      color: Color(0xff000000),
      width: 0,
      style: BorderStyle.none,
    ),
    borderRadius: BorderRadius.all(Radius.circular(0.0)),
  )),
  colorScheme: ColorScheme.fromSwatch(
      primarySwatch: const MaterialColor(4278218472, {
    50: Color(0xffe5f2ff),
    100: Color(0xffcce4ff),
    200: Color(0xff99c9ff),
    300: Color(0xff66afff),
    400: Color(0xff3394ff),
    500: Color(0xff0079ff),
    600: Color(0xff0061cc),
    700: Color(0xff004999),
    800: Color(0xff003066),
    900: Color(0xff001833)
  })).copyWith(secondary: const Color(0xff0079ff)),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Color(0xff4285f4),
    selectionColor: Color(0xff99c9ff),
    selectionHandleColor: Color(0xff66afff),
  ),
);
