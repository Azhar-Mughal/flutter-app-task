import 'package:flutter/material.dart';
import 'package:flutter_task/screens/add_product_screen/provider/add_product_screen_provider.dart';
import 'package:flutter_task/screens/manage_products_screen/provider/manage_products_screen_provider.dart';
import 'package:flutter_task/screens/manage_products_screen/view/manage_products_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ManageProductsScreenProvider>(
          create: (context) => ManageProductsScreenProvider(),
        ),
        ChangeNotifierProvider<AddProductsScreenProvider>(
          create: (context) => AddProductsScreenProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Task',
        debugShowCheckedModeBanner: false,
        theme: _lightTheme(),
        darkTheme: _darkTheme(),
        home: const ManageProductsScreen(),
      ),
    );
  }
}

_lightTheme() {
  return ThemeData(
    scaffoldBackgroundColor: const Color(0xfff9f9f9),
    cardColor: Colors.white,
    primarySwatch: Colors.red,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xfffd7272)),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        ),
        fixedSize: MaterialStateProperty.all<Size>(const Size.fromHeight(50)),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xfff9f9f9),
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

_darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xff222222),
    cardColor: Colors.black,
    primarySwatch: Colors.red,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>((
          Set<MaterialState> states,
        ) {
          if (states.contains(MaterialState.disabled)) {
            return const Color(0xfff8bbd0);
          }
          return const Color(0xfffd7272);
        }),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        ),
        fixedSize: MaterialStateProperty.all<Size>(const Size.fromHeight(50)),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff222222),
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
    ),
  );
}
