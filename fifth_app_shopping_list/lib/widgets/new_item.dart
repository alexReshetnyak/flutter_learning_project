import 'dart:convert';

import 'package:fifth_app_shopping_list/data/categories.dart';
import 'package:fifth_app_shopping_list/models/category.dart';
import 'package:fifth_app_shopping_list/models/grocery_item.dart';
import 'package:flutter/material.dart';

// as http - prefixing the import with a prefix
import 'package:http/http.dart' as http;

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  _NewItemState createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  // GlobalKey - a key that is unique across the entire app
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredQuantity = 1;
  var _selectedCategory = categories[Categories.vegetables]!;
  var _isSending = false;

  void _saveItem() async {
    // .validate() - returns true if all the fields are valid
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSending = true;
    });

    // .save() - calls the onSaved() method on all the form fields
    _formKey.currentState!.save();

    // Uri.https - creates a Uri object from a URI string
    final uri = Uri.https(
      'flutter-app-18767-default-rtdb.firebaseio.com',
      'shopping-list.json', // can be any string with .json at the end
    );

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'name': _enteredName,
        'quantity': _enteredQuantity.toString(),
        'category': _selectedCategory.title,
      }),
    );

    if (!context.mounted) return;

    final Map<String, dynamic> resData = json.decode(response.body);

    Navigator.of(context).pop(GroceryItem(
      id: resData['name'],
      name: _enteredName,
      quantity: _enteredQuantity,
      category: _selectedCategory,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a New Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: Form(
            // we need to pass the key to the Form widget so that we can
            // access it later
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  maxLength: 50,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 1 ||
                        value.trim().length > 50) {
                      return 'Must be between 1 and 50 characters long.';
                    }

                    return null;
                  },
                  onSaved: (value) {
                    _enteredName = value!;
                    // save the value
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Expanded - takes up all the remaining space
                    Expanded(
                      child: TextFormField(
                        decoration:
                            const InputDecoration(label: Text('Quantity')),
                        keyboardType: TextInputType.number,
                        initialValue: _enteredQuantity.toString(),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              int.tryParse(value) == null ||
                              int.tryParse(value)! <= 0) {
                            return 'Must be a number greater than 0.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _enteredQuantity = int.parse(value!);
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonFormField(
                        value: _selectedCategory,
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value!;
                          });
                        },
                        decoration:
                            const InputDecoration(labelText: 'Category'),
                        items: [
                          for (final category in categories.entries)
                            DropdownMenuItem(
                              // value - the key of the map entry
                              value: category.value,
                              child: Row(
                                children: [
                                  Container(
                                    height: 16,
                                    width: 16,
                                    color: category.value.color,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(category.value.title),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _isSending
                          ? null // disable the button if we are sending the data
                          : () {
                              // .reset() - resets the form to its initial state
                              _formKey.currentState!.reset();
                            },
                      child: const Text('Reset'),
                    ),
                    ElevatedButton(
                      onPressed: _isSending ? null : _saveItem,
                      child: _isSending
                          ? const SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(),
                            )
                          : const Text('Add Item'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
