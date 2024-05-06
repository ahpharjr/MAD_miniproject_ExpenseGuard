import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:expenseguard/data/expense_data.dart';
import 'home.dart';
import 'package:expenseguard/theme/theme_provider.dart'; // Import your theme related files

void main() async {
  // Initialize Hive
  await Hive.initFlutter();

  // Open the Hive box for expense data
  await Hive.openBox("expense_database_3");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ExpenseData()),
        ChangeNotifierProvider(
            create: (context) =>
                ThemeProvider()), // Include the ThemeProvider here
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeProvider
                .currentTheme, // Set the theme based on ThemeProvider
            home: Home(),
          );
        },
      ),
    );
  }
}
