import 'dart:io';

import 'package:expenses/model/model_expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class NewExpense extends StatefulWidget {
  NewExpense({super.key, required this.addExpense});
  final void Function(Expense expense) addExpense;
  @override
  _NewExpenseState createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Caterogy _selectedCategory = Caterogy.sport;
  void _presentDatePicker() async {
    final initialDate = DateTime.now();
    final firstDate =
        DateTime(initialDate.year - 1, initialDate.month, initialDate.day);
    final lastDate = initialDate;
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
                title: const Text("Invalid input"),
                content: const Text(
                    "Please make sure your title, amount, date and category was entered"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text("Okay"),
                  ),
                ],
              ));
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid input"),
          content: const Text(
              "Please make sure your title, amount, date and category was entered"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text("Okay"),
            ),
          ],
        ),
      );
    }
  }

  void _submitExpenseDate() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount < 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      _showDialog();
      return;
    }
    widget.addExpense(
      Expense(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          caterogy: _selectedCategory),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();

    super.dispose();
  }

  @override
  Widget build(context) {
    final keyBoardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, Constraints) {
      final Width = Constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 48, 16, keyBoardSpace + 16),
            child: Column(children: [
              if (Width >= 600)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _titleController,
                        maxLength: 50,
                        decoration: const InputDecoration(
                          labelText: "Title",
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          prefixText: "\TL ",
                          labelText: "Amount",
                        ),
                      ),
                    ),
                  ],
                )
              else
                TextField(
                  controller: _titleController,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    labelText: "Title",
                  ),
                ),
              if (Width >= 600)
                Row(
                  children: [
                    DropdownButton(
                        value: _selectedCategory,
                        items: Caterogy.values
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(category.name.toUpperCase()),
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
                          print(value);
                        }),
                    const SizedBox(
                      width: 24,
                    ),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(_selectedDate == null
                            ? 'No selected date'
                            : formater.format(_selectedDate!)),
                        IconButton(
                            onPressed: _presentDatePicker,
                            icon: const Icon(Icons.calendar_month))
                      ],
                    ))
                  ],
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          prefixText: "\TL ",
                          labelText: "Amount",
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(_selectedDate == null
                            ? 'No selected date'
                            : formater.format(_selectedDate!)),
                        IconButton(
                            onPressed: _presentDatePicker,
                            icon: const Icon(Icons.calendar_month))
                      ],
                    ))
                  ],
                ),
              const SizedBox(
                height: 16,
              ),
              if (Width >= 600)
                Row(
                  children: [
                    const Spacer(),
                    ElevatedButton(
                      onPressed: _submitExpenseDate,
                      child: const Text("Save Expense"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    )
                  ],
                )
              else
                Row(
                  children: [
                    DropdownButton(
                        value: _selectedCategory,
                        items: Caterogy.values
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(category.name.toUpperCase()),
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
                          print(value);
                        }),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: _submitExpenseDate,
                      child: const Text("Save Expense"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    )
                  ],
                )
            ]),
          ),
        ),
      );
    });
  }
}
