import 'package:hive_flutter/hive_flutter.dart';
import 'package:expenseguard/models/expense_item.dart';

class HiveDataBase {
  final _myBox = Hive.box("expense_database_3");

  void saveData(List<ExpenseItem> allExpense) {
    List<List<dynamic>> allExpenseFormatted = [];

    for (var expense in allExpense) {
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime,
        expense.category,
      ];
      allExpenseFormatted.add(expenseFormatted);
    }
    _myBox.put("ALL_EXPENSES", allExpenseFormatted);
  }

  List<ExpenseItem> readData() {
    List savedExpense = _myBox.get("ALL_EXPENSES") ?? [];
    List<ExpenseItem> allExpense = [];

    for (int i = 0; i < savedExpense.length; i++) {
      String name = savedExpense[i][0];
      String amount = savedExpense[i][1];
      DateTime dateTime = savedExpense[i][2];
      String category = savedExpense[i][3];

      ExpenseItem expense = ExpenseItem(
          name: name, amount: amount, dateTime: dateTime, category: category);

      allExpense.add(expense);
    }

    return allExpense;
  }

  // Method to save budget amount to the database
  Future<void> saveBudget(double budgetAmount) async {
    await _myBox.put('BUDGET_AMOUNT', budgetAmount);
  }

  // Method to retrieve budget amount from the database
  double getBudget() {
    return _myBox.get('BUDGET_AMOUNT', defaultValue: 0.0);
  }
}
