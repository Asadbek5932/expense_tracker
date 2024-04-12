import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expense.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text('\$${expense.amount.toStringAsFixed(2)}'),
                    Spacer(),
                    Row(
                      children: [
                        Icon(icons[expense.category]),
                        SizedBox(
                          width: 8,
                        ),
                        Text('${expense.formattedDate}')
                      ],
                    )
                  ],
                )
              ],
            )));
  }
}
