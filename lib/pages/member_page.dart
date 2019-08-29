import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/counter.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
        elevation: 0.0,
      ),
      body:Center(
        child: Provide<Counter>(
          builder: (context,child,counter){
            return Text('${counter.value}');
          },
        ),
      )
    );
  }
}