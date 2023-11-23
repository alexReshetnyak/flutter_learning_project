import 'dart:convert';

import 'package:fifth_app_shopping_list/data/categories.dart';
import 'package:fifth_app_shopping_list/models/grocery_item.dart';
import 'package:fifth_app_shopping_list/widgets/new_item.dart';
import 'package:flutter/material.dart';

// as http - prefixing the import with a prefix
import 'package:http/http.dart' as http;

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    // Uri.https - creates a Uri object from a URI string
    final uri = Uri.https(
      'flutter-app-18767-default-rtdb.firebaseio.com',
      'shopping-list.json', // can be any string with .json at the end
    );

    try {
      final response = await http.get(uri);

      if (response.statusCode >= 400) {
        setState(() {
          _error = 'Could not fetch items, please try again later.';
          _isLoading = false;
        });
      }

      if (response.body == 'null') {
        setState(() {
          _isLoading = false;
        });

        return;
      }

      final Map<String, dynamic> listData = json.decode(response.body);
      final List<GroceryItem> loadedItems = [];

      for (var item in listData.entries) {
        //  firstWhere - returns the first element that satisfies the given predicate
        final category = categories.entries.firstWhere(
          (element) => element.value.title == item.value['category'],
        );

        loadedItems.add(GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: int.parse(item.value['quantity']),
          category: category.value,
        ));
      }
      // json.decode(response.body).forEach((key, value) {
      //   _groceryItems.add(
      //     GroceryItem(
      //       id: key,
      //       name: value['name'],
      //       quantity: int.parse(value['quantity']), category: null,
      //     ),
      //   );
      // });

      setState(() {
        _groceryItems = loadedItems;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Something went wrong.';
        _isLoading = false;
      });
    }
  }

  void _addItem() async {
    print('Add Item');

    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );

    if (newItem == null) return;

    setState(() {
      _groceryItems.add(newItem);
    });
  }

  _onItemsDismiss(GroceryItem item) async {
    setState(() {
      _groceryItems.remove(item);
    });

    final uri = Uri.https(
      'flutter-app-18767-default-rtdb.firebaseio.com',
      'shopping-list/${item.id}.json', // can be any string with .json at the end
    );

    final res = await http.delete(uri);

    final int index = _groceryItems.indexOf(item);

    if (res.statusCode >= 400) {
      setState(() {
        _groceryItems.insert(index, item);
        _error = 'Could not delete item, please try again later.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = _groceryItems;
    Widget content = Center(child: Text('No items yet!'));

    if (_isLoading) {
      content = const Center(child: CircularProgressIndicator());
    }

    if (items.isNotEmpty) {
      content = ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];

          return Dismissible(
            key: ValueKey(item.id),
            onDismissed: (_) => _onItemsDismiss(item),
            child: ListTile(
              title: Text(item.name),
              subtitle: Text(item.category.title),
              leading: CircleAvatar(
                backgroundColor: item.category.color,
                child: Text(item.quantity.toString()),
              ),
              // onTap: () => onItemTap(item),
            ),
          );
        },
      );
    }

    if (_error != null) {
      content = Center(child: Text(_error!));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addItem,
          ),
        ],
      ),
      body: content,
    );
  }
}
