import 'package:flutter/material.dart';

import 'MyPlace.dart';
import 'MyWidget.dart';
import 'guide.dart';
import 'CounterApp.dart';
import 'ChangeColorApp.dart';
import 'Login.dart';
import 'RegisterPage.dart';
import 'PhanHoiForm.dart';
import 'BmiScreen.dart';
import 'Loginout.dart';
import 'MyProduct.dart';
import 'Newsapi.dart';

import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Danh Sách Bài Đã Làm',
      theme: ThemeData(primarySwatch: Colors.blue),

      initialRoute: '/',

      routes: {
        '/': (context) => const HomeScreen(),

        '/myplace': (context) => const MyPlace(),
        '/mywidget': (context) => const MyWidget(),
        '/guide': (context) => const guide(),
        '/counter': (context) => const CounterApp(),
        '/changecolor': (context) => const ChangeColorApp(),
        '/loginform': (context) => const Login(),
        '/dangky': (context) => const RegisterPage(),
        '/phanhoi': (context) => const PhanHoiForm(),
        '/bmi': (context) => const BmiScreen(),
        '/myproduct': (context) => const MyProduct(),
        '/Newsapi': (context) => const NewsListScreen(),
        '/loginpage': (context) => const LoginPage(),
      },
    );
  }
}
