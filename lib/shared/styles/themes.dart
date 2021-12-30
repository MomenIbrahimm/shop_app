import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

var lightTheme = ThemeData(
    primarySwatch: Colors.lightBlue,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: Colors.lightBlue,
      ),
    ),
);