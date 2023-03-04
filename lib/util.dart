import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide Element;
import 'package:html/dom.dart';
import 'package:html/parser.dart';

TextSpan parseHtmlCode(String htmlCode) {
  final document = parse(htmlCode);

  List<InlineSpan> children = [];

  for (var node in document.body!.nodes) {
    print(node);
    if (node.nodeType == Node.TEXT_NODE) {
      children.add(TextSpan(
        text: node.text,
      ));
    } else if (node.nodeType == Node.ELEMENT_NODE) {
      Element element = node as Element;
      switch (element.localName) {
        case 'a':
          final link = node.attributes['href'];
          children.add(TextSpan(
            text: element.text,
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()..onTap = () {},
          ));
          break;
      }
    }
  }

  return TextSpan(children: children);
}
