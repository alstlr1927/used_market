import 'package:flutter/material.dart';

class BodyTextLight extends StatelessWidget {
  double size;
  String string;
  Color? color;
  int? maxLines;

  BodyTextLight(
      {required this.string,
      required this.size,
      this.color,
      this.maxLines,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(string,
        maxLines: maxLines,
        style: TextStyle(
            fontSize: size,
            color: color,
            fontWeight: FontWeight.w300,
            fontFamily: 'DefaultFont'));
  }
}

class BodyTextRegular extends StatelessWidget {
  double size;
  String string;
  Color? color;
  int? maxLines;

  BodyTextRegular(
      {required this.string,
      required this.size,
      this.color,
      this.maxLines,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(string,
        maxLines: maxLines,
        style: TextStyle(
            fontSize: size,
            color: color,
            fontWeight: FontWeight.w400,
            fontFamily: 'DefaultFont'));
  }
}

class BodyTextMedium extends StatelessWidget {
  double size;
  String string;
  Color? color;
  int? maxLines;
  bool? lineThrough;

  BodyTextMedium(
      {required this.string,
      required this.size,
      this.color,
      this.maxLines,
      this.lineThrough,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(string,
        maxLines: maxLines,
        style: TextStyle(
            fontSize: size,
            color: color,
            decoration: lineThrough == true ? TextDecoration.lineThrough : null,
            fontWeight: FontWeight.w500,
            fontFamily: 'DefaultFont'));
  }
}

class BodyTextBold extends StatelessWidget {
  double size;
  String string;
  Color? color;
  int? maxLines;

  BodyTextBold(
      {required this.string,
      required this.size,
      this.color,
      this.maxLines,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(string,
        maxLines: maxLines,
        style: TextStyle(
            fontSize: size,
            color: color,
            fontWeight: FontWeight.w700,
            fontFamily: 'DefaultFont'));
  }
}

class BodyTextEBold extends StatelessWidget {
  double size;
  String string;
  Color? color;
  int? maxLines;

  BodyTextEBold(
      {required this.string,
      required this.size,
      this.color,
      this.maxLines,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(string,
        maxLines: maxLines,
        style: TextStyle(
            fontSize: size,
            color: color,
            fontWeight: FontWeight.w800,
            fontFamily: 'DefaultFont'));
  }
}
