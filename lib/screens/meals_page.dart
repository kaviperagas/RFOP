import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rfop/main.dart';
import 'package:rfop/screens/table_number.dart';
import 'package:rfop/providers/meals.dart';
import 'package:rfop/providers/tables.dart';
import 'package:rfop/providers/cart.dart';
import 'package:rfop/widgets/badge.dart';
import 'package:rfop/widgets/meals_item.dart';
import 'package:rfop/screens/cart_page.dart';
import 'package:flutter_scroll_to_top/flutter_scroll_to_top.dart';

class MealsPage extends StatefulWidget {
  static const routeName = '/meals-page';

  const MealsPage({Key? key}) : super(key: key);

  @override
  State<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    AllMealsGrid(),
    MealMealsGrid(),
    AllMealsGrid(),
    SnackMealsGrid(),
    DrinkMealsGrid()
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      return;
    } else {
      setState(
        () {
          _selectedIndex = index;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _iconButton = FloatingActionButton.extended(
      backgroundColor: Colors.black,
      label: const Text(
        'Checkout',
        style: TextStyle(fontSize: 12),
      ),
      elevation: 10,
      shape: RoundedRectangleBorder(
          side: const BorderSide(width: 3, color: Colors.white),
          borderRadius: BorderRadius.circular(100)),
      icon: const Icon(
        Icons.shopping_cart,
      ),
      onPressed: () {
        Navigator.pushNamed(context, CartPage.routeName);
      },
    );
    final tableId = ModalRoute.of(context)?.settings.arguments as String;
    final tables =
        Provider.of<Tables>(context, listen: false).findById(tableId);
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/mae-mu-rgRbqFweGF0-unsplash.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text('Z Restaurant (${tables.number})'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Provider.of<Cart>(context, listen: false).clear();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TablePage()),
                );
              },
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: IconButton(
                  icon: const Icon(Icons.home),
                  onPressed: () {
                    Provider.of<Cart>(context, listen: false).clear();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WelcomePage()),
                    );
                  },
                ),
              ),
            ],
          ),
          body: Container(
            height: 610,
            width: 400,
            decoration: BoxDecoration(
              color: Colors.white60,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ScrollWrapper(
              promptAlignment: Alignment.bottomRight,
              builder: (context, properties) => Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 25),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          "Food Menu",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Expanded(child: _widgetOptions.elementAt(_selectedIndex)),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  label: 'All',
                  icon: Icon(
                    Icons.restaurant,
                    size: 20,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Meals',
                  icon: Icon(
                    Icons.set_meal,
                    size: 20,
                  ),
                ),
                BottomNavigationBarItem(
                  label: '',
                  icon: Icon(
                    Icons.restaurant,
                    size: 24.0,
                    color: Colors.transparent,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Snacks',
                  icon: Icon(
                    Icons.fastfood,
                    size: 20,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Drinks',
                  icon: Icon(
                    Icons.emoji_food_beverage,
                    size: 20,
                  ),
                ),
              ],
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white,
              onTap: _onItemTapped,
              elevation: 5,
            ),
          ),
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Consumer<Cart>(
            builder: (_, cart, ch) => cart.itemCount == 0
                ? _iconButton
                : Badge(
                    value: cart.itemCount.toString(),
                    color: Colors.redAccent,
                    child: ch as Widget,
                  ),
            child: _iconButton,
          ),
        ),
      ),
    );
  }
}

class AllMealsGrid extends StatelessWidget {
  const AllMealsGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mealsData = Provider.of<Meals>(context);
    final meals = mealsData.meals;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: meals.length,
      itemBuilder: (context, i) => MealsItem(meals[i].id, meals[i].name,
          meals[i].price, meals[i].imageUrl, meals[i].category),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 3,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
    );
  }
}

class MealMealsGrid extends StatelessWidget {
  const MealMealsGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mealsData = Provider.of<Meals>(context);
    final meals = mealsData.meal_meals;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: meals.length,
      itemBuilder: (context, i) => MealsItem(meals[i].id, meals[i].name,
          meals[i].price, meals[i].imageUrl, meals[i].category),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 3,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
    );
  }
}

class DrinkMealsGrid extends StatelessWidget {
  const DrinkMealsGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mealsData = Provider.of<Meals>(context);
    final meals = mealsData.drink_meals;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: meals.length,
      itemBuilder: (context, i) => MealsItem(meals[i].id, meals[i].name,
          meals[i].price, meals[i].imageUrl, meals[i].category),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 3,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
    );
  }
}

class SnackMealsGrid extends StatelessWidget {
  const SnackMealsGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mealsData = Provider.of<Meals>(context);
    final meals = mealsData.snack_meals;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: meals.length,
      itemBuilder: (context, i) => MealsItem(meals[i].id, meals[i].name,
          meals[i].price, meals[i].imageUrl, meals[i].category),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 3,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
    );
  }
}
