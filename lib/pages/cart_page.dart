import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/counter.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('HomePage'),
          elevation: 0.0,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Number(),
              MyButton(),
            ],
          ),
        ));
  }
}

class Number extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 200.0),
        child: Provide<Counter>(
          builder: (context, child, counter) {
            return Text(
              '${counter.value}',
              style: TextStyle(fontSize: 100.0),
            );
          },
        ));
  }
}

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 200.0),
      child: RaisedButton(
        onPressed: () {
          Provide.value<Counter>(context).increment();
        },
        child: Text('ADD'),
      ),
    );
  }
}
