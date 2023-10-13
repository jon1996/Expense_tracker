import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formater = DateFormat.yMd();

enum Caterogy {
  food,
  travel,
  leisure,
  work,
  sport,
  rent,
  assurences,
  car,
  clothes
}

const caterogoryIcon = {
  Caterogy.food: Icons.lunch_dining,
  Caterogy.travel: Icons.flight_takeoff,
  Caterogy.leisure: Icons.movie,
  Caterogy.work: Icons.work,
  Caterogy.sport: Icons.fitness_center,
  Caterogy.rent: Icons.house,
  Caterogy.assurences: Icons.assured_workload,
  Caterogy.clothes: Icons.store,
  Caterogy.car: Icons.car_rental,
};

const uuid = Uuid();

class Expense {
  final String ID;
  final String title;
  final double amount;
  final DateTime date;
  final Caterogy caterogy;
  String get formattedDate {
    return formater.format(date);
  }

  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.caterogy})
      : ID = uuid.v4();
}

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expenses});
  final Caterogy category;
  final List<Expense> expenses;

  ExpenseBucket.forCategory(List<Expense> allExpense, this.category)
      : expenses = allExpense
            .where((expense) => expense.caterogy == category)
            .toList();

  double get totalExpense {
    double sum = 0;
    for (var expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
