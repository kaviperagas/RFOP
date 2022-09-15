import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rfop/main.dart';
import 'package:rfop/widgets/table_item.dart';
import 'package:rfop/providers/tables.dart';
import '../login.dart';
import 'package:flutter_scroll_to_top/flutter_scroll_to_top.dart';

class TablePage extends StatelessWidget {
  const TablePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            title: const Text('Z Restaurant'),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginPage()),
                  );
                }),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: IconButton(
                    icon: const Icon(Icons.home),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WelcomePage()),
                      );
                    }),
              ),
            ],
          ),
          body: Container(
              height: 660,
              width: 400,
              decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.circular(15),
              ),
              child: ScrollWrapper(
                promptAlignment: Alignment.bottomRight,
                builder: (context, properties) => Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Column(
                    children: const [
                      Text(
                        "Table Number",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Expanded(child: TablesGrid()),
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

class TablesGrid extends StatelessWidget {
  const TablesGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tablesData = Provider.of<Tables>(context);
    final tables = tablesData.tables;
    return GridView.builder(
      padding: const EdgeInsets.all(25),
      itemCount: tables.length,
      itemBuilder: (context, i) =>
          TableItem(tables[i].id, tables[i].number, tables[i].imageUrl),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 3,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
    );
  }
}
