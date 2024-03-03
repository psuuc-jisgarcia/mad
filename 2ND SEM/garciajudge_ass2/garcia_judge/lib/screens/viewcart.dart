import 'package:flutter/material.dart';
import 'package:garcia_judge/providers/cartprovider.dart';
import 'package:provider/provider.dart';

class ViewCartScreen extends StatefulWidget {
  const ViewCartScreen({Key? key}) : super(key: key);

  @override
  _ViewCartScreenState createState() => _ViewCartScreenState();
}

class _ViewCartScreenState extends State<ViewCartScreen> {
  late List<bool> _selectedItems;

  @override
  void initState() {
    super.initState();
    final cartItemsProvider = Provider.of<CartItems>(context, listen: false);
    _selectedItems = List.generate(cartItemsProvider.totalNoItems, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: Consumer<CartItems>(
        builder: ((context, cartItems, child) {
          return ListView.builder(
            itemBuilder: (_, index) {
              final item = cartItems.items[index];
              return Card(
                child: ListTile(
                  leading: Checkbox(
                    value: _selectedItems[index],
                    onChanged: (value) {
                      setState(() {
                        _selectedItems[index] = value!;
                      });
                    },
                  ),
                  title: Text(item.productCode),
                  subtitle: Text('Quantity: ${item.quantity}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          Provider.of<CartItems>(context, listen: false)
                              .decreaseQuantity(index);
                        },
                        icon: Icon(Icons.remove),
                      ),
                      
                    ],
                  ),
                ),
              );
            },
            itemCount: cartItems.totalNoItems,
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {         
          List<int> indicesToDelete = [];
          for (int i = 0; i < _selectedItems.length; i++) {
            if (_selectedItems[i] == true) {
              indicesToDelete.add(i);
            }
          }
          Provider.of<CartItems>(context, listen: false)
              .removeMultipleItems(indicesToDelete);
          setState(() {
            _selectedItems = List.generate(_selectedItems.length, (_) => false);
          });
        },
        child: Icon(Icons.delete),
      ),
    );
  }
}
