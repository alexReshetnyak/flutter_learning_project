import 'package:flutter/material.dart';
import 'package:third_app/widgets/chart/chart.dart';
import 'package:third_app/widgets/expenses_list/expenses_list.dart';
import 'package:third_app/models/expense.dart';
import 'package:third_app/widgets/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpanses = [
    Expense(
      title: 'Pizza at work',
      amount: 22.22,
      date: DateTime.now(),
      category: Category.work,
    )
  ];

  void _openAddExpenseOverlay() {
    // context is a property of State<T> class
    // open a modal bottom
    showModalBottomSheet(
        context: context,
        isScrollControlled: true, // make the modal bottom sheet full screen
        builder: (ctx) {
          return NewExpense(
            onAddExpense: _addExpense,
          );
        });
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpanses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpanses.indexOf(expense);

    setState(() {
      _registeredExpanses.remove(expense); // remove the expense from the list
    });

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 5),
        content: Text('${expense.title} expense removed!'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpanses.insert(expenseIndex, expense);
            });
          },
        )));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );

    if (_registeredExpanses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpanses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpanses),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
