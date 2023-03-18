import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide Element;
import 'package:intl/intl.dart';
import 'package:iwrqk/l10n.dart';

TextSpan _parseHtmlCode(String text) {
  List<TextSpan> spans = [];
  RegExp urlRegex = RegExp(
      r"(https?://(?:www\.|(?!www))[^\s\.]+\.[^\s]{2,}|www\.[^\s]+\.[^\s]{2,})");

  List<RegExpMatch> matches = urlRegex.allMatches(text).toList();
  int lastMatchEnd = 0;
  for (RegExpMatch match in matches) {
    String? linkText = match.group(0);
    int matchStart = match.start;

    // Add any text before the link.
    if (matchStart > lastMatchEnd) {
      spans.add(
        TextSpan(
          text: text.substring(lastMatchEnd, matchStart),
        ),
      );
    }

    // Add the link.
    spans.add(
      TextSpan(
        text: linkText,
        style: TextStyle(
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
        recognizer: TapGestureRecognizer()..onTap = () {},
      ),
    );

    // Update the last match end position.
    lastMatchEnd = match.end;
  }

  // Add any remaining text after the last match.
  if (lastMatchEnd < text.length) {
    spans.add(
      TextSpan(
        text: text.substring(lastMatchEnd),
      ),
    );
  }

  return TextSpan(children: spans);
}

String getDisplayDate(BuildContext context, DateTime dateTime) {
  Duration difference = DateTime.now().difference(dateTime);

  if (difference.inSeconds < 60) {
    return L10n.of(context)
        .time_seconds_ago
        .replaceFirst("\$s", "${difference.inSeconds}");
  } else if (difference.inMinutes < 60) {
    return L10n.of(context)
        .time_minutes_ago
        .replaceFirst("\$s", "${difference.inMinutes}");
  } else if (difference.inHours < 24) {
    return L10n.of(context)
        .time_hours_ago
        .replaceFirst("\$s", "${difference.inHours}");
  } else if (difference.inDays < 10) {
    return L10n.of(context)
        .time_days_ago
        .replaceFirst("\$s", "${difference.inDays}");
  } else {
    return DateFormat.yMd(L10n.of(context).localeName).format(dateTime);
  }
}

String getDisplayTime(BuildContext context, DateTime dateTime) {
  Duration difference = DateTime.now().difference(dateTime);

  if (difference.inSeconds < 60) {
    return L10n.of(context)
        .time_seconds_ago
        .replaceFirst("\$s", "${difference.inSeconds}");
  } else if (difference.inMinutes < 60) {
    return L10n.of(context)
        .time_minutes_ago
        .replaceFirst("\$s", "${difference.inMinutes}");
  } else if (difference.inHours < 24) {
    return L10n.of(context)
        .time_hours_ago
        .replaceFirst("\$s", "${difference.inHours}");
  } else if (difference.inDays < 10) {
    return L10n.of(context)
        .time_days_ago
        .replaceFirst("\$s", "${difference.inDays}");
  } else {
    return DateFormat.yMd(L10n.of(context).localeName)
        .add_Hms()
        .format(dateTime);
  }
}

String compactBigNumber(BuildContext context, int number) {
  return NumberFormat.compact(locale: L10n.of(context).localeName)
      .format(number);
}

String formatNumberWithCommas(BuildContext context, int number) {
  return NumberFormat("#,###").format(number);
}
