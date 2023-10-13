import 'package:expenses/Widget/Expense%20List/expenses_list.dart';
import 'package:expenses/Widget/charts/chart.dart';
import 'package:expenses/Widget/new_expense.dart';
import 'package:expenses/model/model_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  Expenses({super.key});
  @override
  _ExpenseState createState() => _ExpenseState();
}

class _ExpenseState extends State<Expenses> {
  final List<Expense> registerExpenses = [
    Expense(
        title: "Gym",
        amount: 700,
        date: DateTime.now(),
        caterogy: Caterogy.sport),
    Expense(
        title: "Food",
        amount: 100,
        date: DateTime.now(),
        caterogy: Caterogy.food),
    Expense(
        title: "Movie",
        amount: 32,
        date: DateTime.now(),
        caterogy: Caterogy.leisure),
  ];

  void _openAddExpense() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        addExpense: _addExpense,
      ),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      registerExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = registerExpenses.indexOf(expense);
    setState(() {
      registerExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Expense deleted'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                registerExpenses.insert(expenseIndex, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text("No Expense"),
    );

    if (registerExpenses.isNotEmpty) {
      mainContent = expenseList(
        expense: registerExpenses,
        removeExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Tracker"),
        actions: [
          IconButton(onPressed: _openAddExpense, icon: const Icon(Icons.add))
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(
                  expenses: registerExpenses,
                ),
                Expanded(child: mainContent)
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(
                    expenses: registerExpenses,
                  ),
                ),
                Expanded(child: mainContent)
              ],
            ),
    );
  }
}
