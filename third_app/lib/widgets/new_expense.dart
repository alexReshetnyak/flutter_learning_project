import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:third_app/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<StatefulWidget> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  // var _enteredTitle = '';

  // void _saveTitleValue(String value) {
  //   _enteredTitle = value;
  // }

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context, // context is a property of State<T> class
      initialDate: now,
      // firstDate: DateTime.now().subtract(const Duration(days: 7)),
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialog() {
    AlertDialog builder(ctx) {
      return AlertDialog(
        title: const Text('Invalid input'),
        content: const Text('Please enter a valid title and amount!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: const Text('Okay'),
          ),
        ],
      );
    }

    if (Platform.isIOS) {
      showCupertinoDialog(context: context, builder: builder);
      return;
    }

    showDialog(context: context, builder: builder);
  }

  void _submitExpenseData() {
    // tryParse returns null if it fails to parse the number
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      _showDialog();
      return;
    }

    widget.onAddExpense(Expense(
      title: _titleController.text.trim(),
      amount: enteredAmount,
      date: _selectedDate!,
      category: _selectedCategory,
    ));

    Navigator.pop(context); // close the modal
  }

  // like onDestroy in Angular
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    final titleField = TextField(
      // onChanged: _saveTitleValue,
      controller: _titleController,
      maxLength: 50,
      decoration: const InputDecoration(labelText: 'Title'),
    );
    // TextField(
    //   decoration: const InputDecoration(labelText: 'Amount'),
    // ),
    // TextField(
    //   decoration: const InputDecoration(labelText: 'Date'),
    // ),

    final amountFiled = TextField(
      controller: _amountController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        prefixText: '\$',
        labelText: 'Amount',
      ),
    );

    final datePickerSelect = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          _selectedDate == null
              ? 'No Date Chosen!'
              : formatter.format(
                  _selectedDate!, // !: non-null assertion operator
                ),
        ),
        IconButton(
          icon: const Icon(Icons.calendar_month),
          onPressed: _presentDatePicker,
        ),
      ],
    );

    final categorySelect = DropdownButton(
      value: _selectedCategory,
      items: Category.values.map((category) {
        return DropdownMenuItem(
          value: category,
          child: Row(
            children: [
              Icon(categoryIcons[category]),
              const SizedBox(width: 8),
              Text(category.name.toUpperCase()),
            ],
          ),
        );
      }).toList(),
      onChanged: (value) {
        if (value == null) {
          return;
        }
        setState(() {
          _selectedCategory = value;
        });
      },
    );

    final cancelButton = TextButton(
      child: const Text('Cancel'),
      onPressed: () {
        _titleController.clear();
        Navigator.pop(context); // close the modal
      },
    );

    final saveButton = ElevatedButton(
      onPressed: () {
        _submitExpenseData();
      },
      child: const Text('Save Expense'),
    );

    return LayoutBuilder(builder: (ctx, constraints) {
      // constraints contains the width and height of the widget
      final width = constraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: titleField),
                      const SizedBox(width: 24),
                      Expanded(child: amountFiled),
                    ],
                  )
                else
                  titleField,
                if (width >= 600)
                  Row(
                    children: [
                      categorySelect,
                      const SizedBox(width: 24),
                      Expanded(child: datePickerSelect),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(child: amountFiled),
                      const SizedBox(width: 16),
                      // expanded to take the remaining space
                      Expanded(child: datePickerSelect),
                    ],
                  ),
                const SizedBox(height: 16),
                if (width >= 600)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      cancelButton,
                      const SizedBox(width: 16),
                      saveButton,
                    ],
                  )
                else
                  Row(
                    children: [
                      categorySelect,
                      const Spacer(), // take the remaining space
                      cancelButton,
                      saveButton,
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
