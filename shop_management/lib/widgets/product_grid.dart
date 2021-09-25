import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:shop_management/providers/products_provider.dart';
import './product_item.dart';

class ProductGrid extends StatelessWidget {
  final showFavs;

  ProductGrid(this.showFavs);
  
  @override
  Widget build(BuildContext context) {
    final productData =Provider.of<ProductProvider>(context);
    final product = showFavs ? productData.favItems : productData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: product.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        // create: (c) => product[i],
        value: product[i] ,
        child: ProductItem(
          // product[i].id,
          // product[i].imageUrl,
          // product[i].title,
        ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}