import 'package:expenses/model/model_expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  ExpenseItem(this.expense, {super.key});
  final Expense expense;
  @override
  Widget build(context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text('\TL ${expense.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Row(
                  children: [
                    Icon(caterogoryIcon[expense.caterogy]),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                        '${expense.formattedDate}'), // TODO: add date to the model and use it here instead of string representation for now...
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
