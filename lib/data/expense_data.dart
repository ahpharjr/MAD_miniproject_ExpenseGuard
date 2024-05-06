import 'package:expenseguard/data/hive_database.dart';
import 'package:expenseguard/datetime/date_time_helper.dart';
import 'package:expenseguard/models/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseData extends ChangeNotifier {
  List<ExpenseItem> overallExpenseList = [];
  double budgetAmount = 0; // Variable to store the budget amount

  final db = HiveDataBase();

  List<ExpenseItem> getAllExpenseList() {
    return overallExpenseList;
  }

  void prepareData() {
    if (db.readData().isNotEmpty) {
      overallExpenseList = db.readData();
    }
    // Retrieve budget amount from database during initialization
    budgetAmount = db.getBudget();
  }

  void addNewExpense(ExpenseItem newExpense) {
    overallExpenseList.insert(0, newExpense);
    notifyListeners();
    db.saveData(overallExpenseList);
  }

  void deleteExpense(ExpenseItem expense) {
    overallExpenseList.remove(expense);
    notifyListeners();
    db.saveData(overallExpenseList);
  }

  String getDayName(DateTime dateTime) {
    // Remainder of the week day number divided by 7 gives the index
    List<String> days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return days[dateTime.weekday % 7];
  }

  DateTime startOfWeekDate() {
    DateTime? startOfWeek;
    DateTime today = DateTime.now();

    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek!;
  }

  Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {};

    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }

    return dailyExpenseSummary;
  }

  // Method to save budget amount to the database
  Future<void> saveBudget(double amount) async {
    budgetAmount = amount;
    await db.saveBudget(amount);

    notifyListeners();
  }
}
