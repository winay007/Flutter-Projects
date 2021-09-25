import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_product_screen.dart';
import '../providers/products_provider.dart';
import '../widgets/user_product_Item.dart';
import '../widgets/app_drawer.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

 Future<void> _refreshProducts(BuildContext context) async {
   await Provider.of<ProductProvider>(context,listen: false).fetchAndsetProducts(true);
 }

  @override
  Widget build(BuildContext context) {
    // final productdata = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapshot) => 
        snapshot.connectionState == ConnectionState.waiting 
        ? Center(child: CircularProgressIndicator(),)
        : RefreshIndicator(
          onRefresh: () => _refreshProducts(context) ,
          child: Consumer<ProductProvider>(
            builder: (ctx,productdata , _)  => Padding(
              padding: EdgeInsets.all(8),
              child: ListView.builder(
                itemCount: productdata.items.length,
                itemBuilder: (_, i) => Column(children: [
                  UserProductItem(
                    productdata.items[i].title,
                    productdata.items[i].imageUrl,
                    productdata.items[i].id,
                  ),
                  Divider(),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
