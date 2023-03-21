import 'package:flutter/cupertino.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class IwrMarkdown extends StatelessWidget {
  final String data;
  final bool selectable;
  final EdgeInsets padding;

  const IwrMarkdown(
      {super.key,
      required this.data,
      this.selectable = false,
      this.padding = EdgeInsets.zero});

  @override
  Widget build(BuildContext context) {
    return Markdown(
      selectable: selectable,
      onTapLink: (text, href, title) {},
      padding: padding,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      data: data,
    );
  }
}
