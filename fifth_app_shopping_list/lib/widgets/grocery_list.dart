import 'package:fifth_app_shopping_list/models/grocery_item.dart';
import 'package:fifth_app_shopping_list/widgets/new_item.dart';
import 'package:flutter/material.dart';

class GroceryList extends StatefulWidget {
  // const GroceryList({
  //   Key? key,
  //   required this.items,
  //   required this.onItemTap,
  //   required this.onItemDismiss,
  // }) : super(key: key);

  // final List<GroceryItem> items;
  // final void Function(GroceryItem item) onItemTap;
  // final void Function(GroceryItem item) onItemDismiss;

  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryItems = [];

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

  _onItemsDismiss(GroceryItem item) {
    setState(() {
      _groceryItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    final items = _groceryItems;
    Widget content = Center(child: Text('No items yet!'));

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
