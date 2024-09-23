import 'package:flutter/material.dart';
import 'package:gif_manager/pages/home_page.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(hintColor: Colors.white),
      home: const HomePage()
  )
  );
}
