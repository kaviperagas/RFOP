import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rfop/login.dart';
import 'package:rfop/providers/cart.dart';
import 'package:rfop/providers/meals.dart';
import 'package:rfop/providers/orders.dart';
import 'package:rfop/providers/user.dart';
import 'package:rfop/screens/cart_page.dart';
import 'package:rfop/screens/meals_page.dart';
import 'package:rfop/providers/tables.dart';
import 'package:rfop/screens/orders_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<User>(
          create: (ctx) => User(),
        ),
        ChangeNotifierProvider<Tables>(
          create: (ctx) => Tables(),
        ),
        ChangeNotifierProvider<Meals>(
          create: (ctx) => Meals(),
        ),
        ChangeNotifierProvider<Cart>(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider<Orders>(
          create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
          title: 'RFOP System',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: const WelcomePage(),
          routes: {
            MealsPage.routeName: (ctx) => const MealsPage(),
            CartPage.routeName: (ctx) => const CartPage(),
            OrdersPage.routeName: (ctx) => const OrdersPage(),
          }),
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
        home: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/mae-mu-rgRbqFweGF0-unsplash.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              title: const Text('RFOP System'),
            ),
            body: Center(
              child: Container(
                height: 300,
                width: 375,
                decoration: BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Welcome To Z Restaurant!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 3, color: Colors.white),
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        },
                        child: const Text('Continue'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
