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
  
  void _openAddNewExpenseScreen () {
    showModalBottomSheet(context: context, builder: (ctx) => NewExpense(workingWithReturnValues));
  }

  void workingWithReturnValues(Expense expense) {
    setState(() {
      expenses.add(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense tracker'),
        actions: [IconButton(onPressed: _openAddNewExpenseScreen, icon: Icon(Icons.add))],
      ),
      body: Column(
        children: [
          const Text('The chart'),
          SizedBox(height: 5,),
          Expanded(child: ExpensesList(expenses: expenses)),
        ],
      ),
    );
  }
}
