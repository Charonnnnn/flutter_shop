import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'dart:convert';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
        elevation: 0.0,
      ),
      body:Center(child: Text('分类'),)
    );
  }
}