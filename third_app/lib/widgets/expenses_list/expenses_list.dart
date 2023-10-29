import 'package:flutter/material.dart';
import 'package:third_app/models/expense.dart';
import 'package:third_app/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    // ListView is a scrollable list of widgets arranged linearly.
    return ListView.builder(
      itemBuilder: ((context, index) {
        // Dismissible is a widget that can be dismissed by dragging in the indicated direction.
        return Dismissible(
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.7),
            margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal,
            ),
          ),
          key: ValueKey(expenses[index].id), // key is required for Dismissible
          onDismissed: (direction) {
            onRemoveExpense(expenses[index]);
          },
          child: ExpenseItem(expenses[index]),
        );
      }),
      itemCount: expenses.length,
    );
  }
}
