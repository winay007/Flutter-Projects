import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_management/screens/splash_screen.dart';
import './providers/auth.dart';
import './screens/user_product_screen.dart';
import './screens/cart_screen.dart';
import './providers/cart.dart';

import './screens/product_detail_screen.dart';
import './screens/product_overview_screen.dart';
import 'providers/products_provider.dart';
import '/providers/orders.dart';
import './screens/order_screen.dart';
import './screens/edit_product_screen.dart'; 
import './screens/auth_screen.dart';
import './helpers/custom_route.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: Auth()),
          ChangeNotifierProxyProvider<Auth, ProductProvider>(
              create: (_) => ProductProvider('', '',[],),
              update: (ctx, auth, previousProducts) {
                return ProductProvider(
                    auth.token,
                    auth.uderId,
                    previousProducts.items == null
                        ? []
                        : previousProducts.items);
              }),
          ChangeNotifierProvider.value(value: Cart()),
          ChangeNotifierProxyProvider<Auth, Order>(
            create: (_) => Order('', '',[]),
              update: (ctx, auth, previousOrder) => Order(
                  auth.token,
                   auth.uderId,
                   previousOrder == null ? [] : previousOrder.order) 
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) =>
           MaterialApp(
            title: 'MyShop',
            theme: ThemeData(
              pageTransitionsTheme: PageTransitionsTheme(builders: {
                TargetPlatform.android : CustomPageTransitionBuilder(),
              }),
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
            ),
            home: auth.isAuth ? ProductOverview() :
            FutureBuilder(future: auth.tryAutoLogin(),builder: (ctx,authResultSnapshot) =>  
            authResultSnapshot.connectionState ==  ConnectionState.waiting 
            ? SplashScreen() 
            : AuthScreen(),
            ),
            routes: {
              ProductDetail.routeName: (ctx) => ProductDetail(),
              CartScreen.routrname: (ctx) => CartScreen(),
              OrdersScreen.routemane: (ctx) => OrdersScreen(),
              UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
              EditProductScreen.routeName: (ctx) => EditProductScreen(),
            },
          ),
        ));
  }
}
