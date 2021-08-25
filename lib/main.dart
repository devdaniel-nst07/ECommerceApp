import 'package:ecommerce_app/inner_screens/brands_navigation_rail.dart';
import 'package:ecommerce_app/inner_screens/categories_feeds.dart';
import 'package:ecommerce_app/inner_screens/product_detail.dart';
import 'package:ecommerce_app/provider/cart_provider.dart';
import 'package:ecommerce_app/provider/favs_provider.dart';
import 'package:ecommerce_app/provider/products_provider.dart';
import 'package:ecommerce_app/screens/auth/login.dart';
import 'package:ecommerce_app/screens/auth/sign_up.dart';
import 'package:ecommerce_app/screens/bottom_bar.dart';
import 'package:ecommerce_app/consts/theme_data.dart';
import 'package:ecommerce_app/provider/dark_theme_provider.dart';
import 'package:ecommerce_app/screens/carts.dart';
import 'package:ecommerce_app/screens/feeds.dart';
import 'package:ecommerce_app/screens/landing_page.dart';
import 'package:ecommerce_app/screens/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreferences.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return themeChangeProvider;
        }),
        ChangeNotifierProvider(
          create: (_) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_)=>CartProvider(),
        ),
        ChangeNotifierProvider(
            create: (_) => FavsProvider(),)
      ],
      child: Consumer<DarkThemeProvider>(builder: (context, themData, child) {
        return MaterialApp(
          title: 'ECommerce App',
          theme: Styles.themData(themeChangeProvider.darkTheme, context),
          home: LandingPage(),
          //initialRoute: '/',
          routes: {
            BrandNavigationRailScreen.routeName: (ctx)=>
              BrandNavigationRailScreen(),
            FeedsScreen.routeName: (ctx)=>
                FeedsScreen(),
            CartScreen.routeName: (ctx)=>
                CartScreen(),
            WishlistScreen.routeName: (ctx)=>
                WishlistScreen(),
            ProductDetails.routeName: (ctx)=>
                ProductDetails(),
            CategoriesFeedsScreen.routeName: (ctx)=>
                CategoriesFeedsScreen(),
            LoginScreen.routeName: (ctx) =>
                LoginScreen(),
            SignupScreen.routeName: (ctx) =>
                SignupScreen(),
          },
        );
      }),
    );
  }
}
