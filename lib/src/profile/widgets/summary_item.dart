import 'package:flutter/material.dart';

class SummaryItem extends StatelessWidget {
  const SummaryItem({Key key, @required this.label, @required this.data})
      : super(key: key);

  final String label;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Text(label),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Text(data),
      )],
    );
  }
}
