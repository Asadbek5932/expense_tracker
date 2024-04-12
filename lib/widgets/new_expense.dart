import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  NewExpense(this.finishEnteringCategory, {Key? key}) : super(key: key);

  final void Function(Expense expense) finishEnteringCategory;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _textController = TextEditingController();
  final _numberController = TextEditingController();
  Category _selectedCategory = Category.leisure;
  DateTime? date;

  @override
  void dispose() {
    _textController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  void _showTheDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(context: context, builder: (ctx) =>
          CupertinoAlertDialog(
            title: Text('Invalid input'),
            content: Text('Make sure that all user inputs are correct.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Ok'),
              ),
            ],
          ));
    } else {
      showDialog(
        context: context,
        builder: (ctx) =>
            AlertDialog(
              title: Text('Invalid input'),
              content: Text('Make sure that all user inputs are correct.'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Ok'),
                ),
              ],
            ),
      );
    }
  }

  void _saveNewExpense() {
    final enteredNumber = double.tryParse(_numberController.text);
    if (_textController.text
        .trim()
        .isEmpty ||
        enteredNumber == null ||
        date == null) {
      _showTheDialog();
      return;
    }
    Expense expense = Expense(
        title: _textController.text,
        amount: double.tryParse(_numberController.text)!,
        date: date!,
        category: _selectedCategory);
    widget.finishEnteringCategory(expense);
    Navigator.pop(context);
  }

  void _showCalendar() async {
    var firstDate = DateTime.now();
    var lastDate = DateTime(firstDate.year - 1, firstDate.month, firstDate.day);
    var lastDate2 =
    DateTime(firstDate.year + 10, firstDate.month, firstDate.day);
    final result = await showDatePicker(
      context: context,
      initialDate: firstDate,
      firstDate: lastDate,
      lastDate: lastDate2,
    );
    setState(() {
      date = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _textController,
            maxLength: 50,
            decoration: InputDecoration(label: Text('Title')),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _numberController,
                  decoration: InputDecoration(
                    label: Text('Amount'),
                    prefixText: '\$ ',
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      date == null ? 'Selected date' : formatter.format(date!),
                    ),
                    IconButton(
                      onPressed: _showCalendar,
                      icon: Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (value) =>
                      DropdownMenuItem(
                        value: value,
                        child: Text(value.name.toUpperCase()),
                      ),
                )
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              SizedBox(
                width: 4,
              ),
              ElevatedButton(
                onPressed: _saveNewExpense,
                child: Text('Save Expense'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
