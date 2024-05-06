// ignore_for_file: camel_case_types

import 'package:expenseguard/component/expense.tile.dart';
import 'package:expenseguard/data/expense_data.dart';
import 'package:expenseguard/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class transaction extends StatefulWidget {
  const transaction({super.key});

  @override
  State<transaction> createState() => _transactionState();
}

class _transactionState extends State<transaction> {
  // delete expense
  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          // ignore: prefer_const_constructors
          title: Text('Transaction History'),
          backgroundColor: Theme.of(context).colorScheme.background,
          centerTitle: true,
          // backgroundColor: const Color.fromARGB(255, 173, 243, 226),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 22,
          ),
        ),
        body: SafeArea(
          child: ListView.builder(
            // physics: const NeverScrollableScrollPhysics(),
            itemCount: value.getAllExpenseList().length,
            itemBuilder: (context, index) => ExpenseTile(
              name: value.getAllExpenseList()[index].name,
              amount: value.getAllExpenseList()[index].amount,
              dateTime: value.getAllExpenseList()[index].dateTime,
              category: value.getAllExpenseList()[index].category,
              deleteTapped: (p0) =>
                  deleteExpense(value.getAllExpenseList()[index]),
            ),
          ),
        ),
      ),
    );
  }
}
