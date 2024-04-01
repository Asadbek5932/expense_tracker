import "package:uuid/uuid.dart";

class Expense {

  Expense( {required this.title, required this.amount, required this.date});

  final String id;
  final String title;
  final String amount;
  final DateTime date;
}