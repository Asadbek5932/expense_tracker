import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> expenses = [
    Expense(
        title: 'Home',
        amount: 19.38,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Case',
        amount: 20.76,
        date: DateTime.now(),
        category: Category.leisure),
    Expense(
        title: 'Spagetti',
        amount: 23.38,
        date: DateTime.now(),
        category: Category.food),
  ];

  void deleteExpense(Expense expense) {
    final index = expenses.indexOf(expense);
    setState(() {
      expenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 3),
      content: Text('Expense deleted'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          setState(() {
            expenses.insert(index, expense);
          });
        },
      ),
    ));
  }

  void _openAddNewExpenseScreen() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(workingWithReturnValues));
  }

  void workingWithReturnValues(Expense expense) {
    setState(() {
      expenses.add(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    Widget mainContent = Center(
      child: Text('Enter the list of expenses'),
    );

    if (expenses.isNotEmpty) {
      mainContent = ExpensesList(expenses: expenses, onDismiss: deleteExpense);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense tracker'),
        actions: [
          IconButton(onPressed: _openAddNewExpenseScreen, icon: Icon(Icons.add))
        ],
      ),
      body: width <= 414
          ? Column(
              children: [
                const Text('The chart'),
                SizedBox(
                  height: 5,
                ),
                Expanded(child: mainContent),
              ],
            )
          : Row(
              children: [
                const Text('The chart'),
                SizedBox(
                  height: 5,
                ),
                Expanded(child: mainContent),
              ],
            ),
    );
  }
}
