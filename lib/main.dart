// ignore_for_file: prefer_const_constructors

import 'package:crud_array/screen/home/index.dart';
import 'package:crud_array/screen/karyawan/create.dart';
import 'package:crud_array/screen/karyawan/index.dart';
import 'package:crud_array/screen/karyawan/update.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.blue,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.black, // Ubah background menjadi hitam
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black), // Border hitam
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.black), // Border hitam saat aktif
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.black, width: 2), // Border hitam saat difokus
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
        ),
      ),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/karyawan': (context) => KaryawanPage(),
        '/karyawan/create': (context) => CreateKaryawanPage(),
        '/karyawan/update': (context) => UpdateKaryawanPage(),
      },
    );
  }
}
