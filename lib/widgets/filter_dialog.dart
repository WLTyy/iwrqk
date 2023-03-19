import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iwrqk/l10n.dart';

import '../common/classes.dart';

class FilterDialog extends StatefulWidget {
  final void Function(String? rating, int? year, int? month) onFilterApplied;
  final FilterSetting? lastFilterSetting;

  const FilterDialog(
      {super.key, required this.onFilterApplied, this.lastFilterSetting});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  final _yearButtonKey = GlobalKey();
  final _monthButtonKey = GlobalKey();
  final _ratingButtonKey = GlobalKey();
  int? _selectedYear;
  int? _selectedMonth;
  String? _selectedRatingType;

  String _getRatingLocalName(BuildContext context, String ratingType) {
    String result = "";
    switch (ratingType) {
      case RatingType.all:
        result = L10n.of(context).filter_all;
        break;
      case RatingType.general:
        result = L10n.of(context).filter_general;
        break;
      case RatingType.ecchi:
        result = L10n.of(context).filter_ecchi;
        break;
    }
    return result;
  }

  void _showYearMenu(BuildContext context) {
    final button =
        _yearButtonKey.currentContext?.findRenderObject() as RenderBox;
    final position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(
          Offset(0, button.size.height),
          ancestor: context.findRenderObject(),
        ),
        button.localToGlobal(Offset(button.size.width, button.size.height),
            ancestor: context.findRenderObject()),
      ),
      Offset.zero & (context.size ?? Size.zero),
    );
    showMenu<int?>(
      context: context,
      position: position,
      items: List.generate(
        DateTime.now().year - 2013 + 1,
        (index) {
          if (index == 0) {
            return PopupMenuItem<int?>(
              value: null,
              child: Text(
                L10n.of(context).filter_select_year,
                style: TextStyle(color: Colors.grey),
              ),
            );
          }
          final year = 2013 + index;
          return PopupMenuItem<int?>(
            value: year,
            child: Text(
              year.toString(),
              style: TextStyle(color: Colors.grey),
            ),
          );
        },
      ),
    ).then((int? year) {
      setState(() {
        _selectedYear = year;
      });
    });
  }

  void _showMonthMenu(BuildContext context) {
    final button =
        _monthButtonKey.currentContext?.findRenderObject() as RenderBox;
    final position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(
          Offset(0, button.size.height),
          ancestor: context.findRenderObject(),
        ),
        button.localToGlobal(Offset(button.size.width, button.size.height),
            ancestor: context.findRenderObject()),
      ),
      Offset.zero & (context.size ?? Size.zero),
    );
    showMenu<int?>(
      context: context,
      position: position,
      items: List.generate(
        DateTime.now().year.toString() == _selectedYear
            ? DateTime.now().month
            : 12 + 1,
        (index) {
          if (index == 0) {
            return PopupMenuItem<int?>(
              value: null,
              child: Text(
                L10n.of(context).filter_select_month,
                style: TextStyle(color: Colors.grey),
              ),
            );
          }
          return PopupMenuItem<int?>(
            value: index,
            child: Text(
              DateFormat('MMM', L10n.of(context).localeName)
                  .format(DateTime(2000, index)),
              style: TextStyle(color: Colors.grey),
            ),
          );
        },
      ),
    ).then((int? month) {
      setState(() {
        _selectedMonth = month;
      });
    });
  }

  void _showRatingMenu(BuildContext context) {
    final button =
        _ratingButtonKey.currentContext?.findRenderObject() as RenderBox;
    final position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(
          Offset(0, button.size.height),
          ancestor: context.findRenderObject(),
        ),
        button.localToGlobal(Offset(button.size.width, button.size.height),
            ancestor: context.findRenderObject()),
      ),
      Offset.zero & (context.size ?? Size.zero),
    );
    showMenu<String>(
        context: context,
        initialValue: RatingType.all,
        position: position,
        items: [
          PopupMenuItem<String>(
            value: RatingType.all,
            child: Text(
              _getRatingLocalName(context, RatingType.all),
              style: TextStyle(color: Colors.grey),
            ),
          ),
          PopupMenuItem<String>(
            value: RatingType.general,
            child: Text(
              _getRatingLocalName(context, RatingType.general),
              style: TextStyle(color: Colors.grey),
            ),
          ),
          PopupMenuItem<String>(
            value: RatingType.ecchi,
            child: Text(
              _getRatingLocalName(context, RatingType.ecchi),
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ]).then((String? rating) {
      if (rating != null) {
        setState(() {
          _selectedRatingType = rating;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.lastFilterSetting != null) {
      _selectedRatingType = widget.lastFilterSetting!.ratingType;
      _selectedYear = widget.lastFilterSetting!.year;
      _selectedMonth = widget.lastFilterSetting!.month;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).canvasColor,
      title: Text(L10n.of(context).filter),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(L10n.of(context).filter_by_rating),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                key: _ratingButtonKey,
                onTap: () {
                  _showRatingMenu(context);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(vertical: 7.5, horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).cardColor,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _selectedRatingType != null
                            ? _getRatingLocalName(context, _selectedRatingType!)
                            : L10n.of(context).filter_select_rating,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        CupertinoIcons.chevron_down,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(L10n.of(context).filter_by_date),
            ),
            ButtonBar(
              buttonPadding: EdgeInsets.zero,
              children: [
                GestureDetector(
                  key: _yearButtonKey,
                  onTap: () {
                    _showYearMenu(context);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding:
                        EdgeInsets.symmetric(vertical: 7.5, horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).cardColor,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _selectedYear != null
                              ? _selectedYear.toString()
                              : L10n.of(context).filter_select_year,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          CupertinoIcons.chevron_down,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: _selectedYear != null,
                  child: GestureDetector(
                    key: _monthButtonKey,
                    onTap: () {
                      _showMonthMenu(context);
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                      padding:
                          EdgeInsets.symmetric(vertical: 7.5, horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).cardColor,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _selectedMonth != null
                                ? DateFormat('MMM', L10n.of(context).localeName)
                                    .format(DateTime(2000, _selectedMonth! + 1))
                                : L10n.of(context).filter_select_month,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            CupertinoIcons.chevron_down,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      contentPadding: EdgeInsets.fromLTRB(25, 15, 25, 0),
      actionsAlignment: MainAxisAlignment.end,
      actionsPadding: EdgeInsets.fromLTRB(15, 0, 15, 10),
      actions: [
        ElevatedButton(
          onPressed: () {
            widget.onFilterApplied.call(_selectedRatingType, _selectedYear,
                _selectedMonth != null ? _selectedMonth! + 1 : null);
            Navigator.pop(context);
          },
          child: Text(L10n.of(context).apply),
        ),
      ],
    );
  }
}
