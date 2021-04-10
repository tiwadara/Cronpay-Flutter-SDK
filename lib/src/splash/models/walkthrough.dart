import 'package:flutter/material.dart';

class WalkThrough {
  IconData icon;
  String image;
  String title;
  String subtitle;
  String description;
  Widget extraWidget;

  WalkThrough(
      {this.icon, this.image, this.subtitle, this.title, this.description, this.extraWidget}) {
    if (extraWidget == null) {
      extraWidget = new Container();
    }
  }
}