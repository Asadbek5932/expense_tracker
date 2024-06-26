import "package:uuid/uuid.dart";
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

const uuid = Uuid();

enum Category { food, leisure, travel, work }

final formatter = DateFormat.yMd();

const icons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.work: Icons.work,
  Category.leisure: Icons.movie
};

class Expense {

  Expense(
      {required this.title, required this.amount, required this.date, required this.category})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}