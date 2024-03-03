import 'package:flutter/material.dart';
import 'package:garcia_judge/models/cartitem.dart';
import 'package:garcia_judge/models/product.dart';
import 'package:garcia_judge/providers/cartprovider.dart';
import 'package:garcia_judge/providers/productprovider.dart';
import 'package:garcia_judge/screens/manageproduct.dart';
import 'package:garcia_judge/screens/viewcart.dart';
import 'package:provider/provider.dart';

class ViewProductsScreen extends StatelessWidget {
  ViewProductsScreen({Key? key});

  void openAddScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ManageProductScreen(),
      ),
    );
  }

  void openEditScreen(BuildContext context, List<Product> productList, int index) {
    if (productList.isNotEmpty && index >= 0 && index < productList.length) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ManageProductScreen(
            index: index,
          ),
        ),
      );
    } else {
      print('Invalid index or empty list');
    }
  }

  void changeFavorite(BuildContext context, int index) {
    Provider.of<Products>(context, listen: false).toggleFavorite(index);
  }

  void openShoppingCart(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => ViewCartScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Products'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () => openAddScreen(context),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Consumer<Products>(
        builder: (_, provider, child) {
          return FutureBuilder(
            future: provider.items,
            builder: (context, AsyncSnapshot<List<Product>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.data == null || snapshot.data!.isEmpty) {
                return Center(
                  child: Text('No records found'),
                );
              }
              var productList = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: productList.length,
                itemBuilder: (_, index) {
                  final product = productList[index];
                  return Dismissible(
                    key: Key(product.productCode.toString()),
                    direction: DismissDirection.startToEnd,
                    confirmDismiss: (direction) async {
                      return await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Confirm"),
                            content: Text(
                              "Are you sure you want to delete ${product.nameDesc}?"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                  Navigator.of(context).pop(false),
                                child: Text("CANCEL"),
                              ),
                              TextButton(
                                onPressed: () =>
                                  Navigator.of(context).pop(true),
                                child: Text("DELETE"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    onDismissed: (direction) {
                      // Get the index of the dismissed item
                      int dismissedIndex = productList.indexWhere((item) => item == product);
                      Provider.of<Products>(context, listen: false).removeProduct(dismissedIndex);
                    },
                    background: Container(
                      color: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () => openEditScreen(context, productList, index),
                      child: Card(
                        child: ListTile(
                          leading: IconButton(
                            onPressed: () => changeFavorite(context, index),
                            icon: Icon(product.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_outline),
                          ),
                          title: Text(product.nameDesc),
                          trailing: IconButton(
                            onPressed: () {
                              Provider.of<CartItems>(context, listen: false)
                                .add(CartItem(
                                  productCode: product.productCode,
                                ));
                            },
                            icon: Icon(Icons.shopping_cart),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openShoppingCart(context),
        child: Icon(Icons.shopping_cart_checkout),
      ),
    );
  }
}
