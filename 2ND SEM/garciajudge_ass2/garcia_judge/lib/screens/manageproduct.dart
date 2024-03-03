
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:garcia_judge/models/product.dart';
import 'package:garcia_judge/providers/productprovider.dart';
import 'package:provider/provider.dart';

class ManageProductScreen extends StatefulWidget {
  ManageProductScreen({Key? key, this.index});

  final int? index;

  @override
  State<ManageProductScreen> createState() => _ManageProductScreenState();
}

class _ManageProductScreenState extends State<ManageProductScreen> {
  final TextEditingController codeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      // Get the item
      final provider = Provider.of<Products>(context, listen: false);
      final product = provider.item(widget.index!);
      if (product != null) {
        codeController.text = product.productCode;
        nameController.text = product.nameDesc;
        priceController.text = product.price.toString();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.index == null ? 'Add Product' : 'Edit Product'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: [
            TextField(
              controller: codeController,
              readOnly: widget.index != null,
              decoration: InputDecoration(
                labelText: 'Product Code',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name/Desc',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Price',
                border: OutlineInputBorder(),
              ),
            ),
            const Gap(12),
            ElevatedButton(
              onPressed: () {
                if (codeController.text.isEmpty ||
                    nameController.text.isEmpty ||
                    priceController.text.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Validation Error'),
                      content: Text('Please fill in all fields.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                  return; 
                }

                
                double price;
                try {
                  price = double.parse(priceController.text);
                } catch (_) {
          
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Validation Error'),
                      content: Text('Please enter a valid price.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                  return; 
                }

                final provider = Provider.of<Products>(context, listen: false);
                final product = Product(
                  productCode: codeController.text,
                  nameDesc: nameController.text,
                  price: price,
                );
                if (widget.index == null) {
                  provider.add(product);
                } else {
                  provider.edit(product, widget.index!);
                }

                Navigator.of(context).pop();
              },
              child: Text(widget.index == null ? 'ADD' : 'EDIT'),
            ),
          ],
        ),
      ),
    );
  }
}
