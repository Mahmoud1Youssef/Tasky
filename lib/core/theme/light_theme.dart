import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primaryContainer: Color(0xFFFFFFFF),
    secondary: Color(0xFF161F1B),
  ),
  scaffoldBackgroundColor: Color(0xFFF6F7F9),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFFF6F7F9),
    iconTheme: IconThemeData(color: Color(0xFF161F1B)),
    titleTextStyle: TextStyle(color: Color(0xFF161F1B), fontSize: 20),
    centerTitle: true,
  ),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xFF15B86C);
      }
      return Colors.white;
    }),
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      }
      return Color(0xFF9E9E9E);
    }),
    trackOutlineColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.transparent;
      }
      return Color(0xFF9E9E9E);
    }),
    trackOutlineWidth: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return 0;
      }
      return 2;
    }),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(Color(0xFF15B86C)),
      foregroundColor: WidgetStateProperty.all(Color(0xFFFFFCFC)),
      textStyle: WidgetStateProperty.all(
        TextStyle(fontSize: 14, fontWeight: FontWeight(500)),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.black)),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF15B86C),
    foregroundColor: Color(0xFFFFFCFC),
    extendedTextStyle: TextStyle(fontSize: 14, fontWeight: FontWeight(500)),
  ),
  textTheme: TextTheme(
    displaySmall: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: 24,
      fontWeight: FontWeight(400),
    ),
    displayMedium: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: 28,
      fontWeight: FontWeight(400),
    ),
    displayLarge: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: 32,
      fontWeight: FontWeight(400),
    ),
    titleSmall: TextStyle(
      color: Color(0xFF3A4640),
      fontSize: 14,
      fontWeight: FontWeight(400),
    ),
    titleMedium: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: 16,
      fontWeight: FontWeight(400),
    ),
    //For Done Task
    titleLarge: TextStyle(
      color: Color(0xFF6A6A6A),
      fontSize: 16,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xFF49454F),
      overflow: TextOverflow.ellipsis,
    ),
    labelSmall: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    labelMedium: TextStyle(color: Colors.black, fontSize: 16),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFFFFFFFF),
    hintStyle: TextStyle(
      color: Color(0xFF9E9E9E),
      fontWeight: FontWeight.w400,
      fontSize: 16,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: Color(0xFFD1DAD6)),
      borderRadius: BorderRadius.circular(16),
    ),

    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: Color(0xFFD1DAD6)),
      borderRadius: BorderRadius.circular(16),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: Color(0xFFD1DAD6)),
      borderRadius: BorderRadius.circular(16),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: Color(0xFFD1DAD6), width: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),
  iconTheme: IconThemeData(color: Color(0xFF161F1B)),
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  ),
  dividerTheme: DividerThemeData(color: Color(0xFFD1DAD6)),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: Colors.black12,
    selectionHandleColor: Colors.green,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xFFF6F7F9),
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Color(0xFF14A662),
    unselectedItemColor: Color(0xFF3A4640),
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xFFF6F7F9),
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(
        color: Color(0xFF161F1B),
        fontSize: 18,
        fontWeight: FontWeight(400),
      ),
    ),
  ),
);
