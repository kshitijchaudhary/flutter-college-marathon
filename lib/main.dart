import 'package:flutter/material.dart';
import 'package:project1_iremember/ui/pages/add.dart';
import './ui/pages/home.dart';
import 'ui/pages/home.dart';

void main() => runApp(IRememberApp());

class IRememberApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //TODO 1. Build MaterialApp and link home page
    return MaterialApp(
      home: HomePage(),
      routes:{
        "add": (_) => AddPage(),
      },
      
    );
  }
}
