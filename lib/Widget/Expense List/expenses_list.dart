import 'package:expenses/Widget/Expense%20List/expense_item.dart';
import 'package:expenses/model/model_expense.dart';
import 'package:flutter/material.dart';

class expenseList extends StatelessWidget {
  expenseList({super.key, required this.expense, required this.removeExpense});
  final void Function(Expense expense) removeExpense;
  final List<Expense> expense;
  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: expense.length,
      itemBuilder: (context, index) => Dismissible(
        background: Container(
          color: Theme.of(context).colorScheme.error,
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
        ),
        onDismissed: (direction) {
          removeExpense(
            expense[index],
          );
        },
        key: ValueKey(
          ExpenseItem(expense[index]),
        ),
        child: ExpenseItem(expense[index]),
      ),
    );
  }
}
