import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rfop/providers/orders.dart' show Orders;
import 'package:rfop/widgets/order_item.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import '../providers/tables.dart';
import '../providers/user.dart' show User;

class OrdersPage extends StatefulWidget {
  static const routeName = '/orders';
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    final userData = Provider.of<User>(context);
    final tableData = Provider.of<Tables>(context, listen: false);
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
            automaticallyImplyLeading: false,
          ),
          body: Center(
            child: Container(
              height: 660,
              width: 400,
              decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Column(
                  children: [
                    const Text(
                      "Your Order",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: 'Name : ',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: userData.getName,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: 'Phone Number : ',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: userData.getContact,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: 'Table Number : ',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: tableData.getTablenum,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: orderData.orders.length,
                        itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: const EdgeInsets.all(15),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text('Payment Choice: ',
                                style: TextStyle(fontSize: 15)),
                            const SizedBox(width: 10),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.blueAccent,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        width: 3, color: Colors.white),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => WillPopScope(
                                      onWillPop: () async => false,
                                      child: AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        title: const Text('Are you sure?'),
                                        content: RichText(
                                          text: const TextSpan(
                                            text:
                                                'Are you sure to continue to pay at counter?',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                            children: [
                                              TextSpan(
                                                text:
                                                    '\n[Note: You cannot change the payment method anymore.]',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor: Colors.white,
                                                backgroundColor:
                                                    Colors.redAccent,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                      width: 3,
                                                      color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                              ),
                                              child: const Text('No'),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(false);
                                              }),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              backgroundColor:
                                                  Colors.blueAccent,
                                              shape: RoundedRectangleBorder(
                                                side: const BorderSide(
                                                    width: 3,
                                                    color: Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                            child: const Text('Yes'),
                                            onPressed: () {
                                              final url = Uri.parse(
                                                  'https://rfop-e4378-default-rtdb.firebaseio.com/Orders.json');
                                              http.post(url,
                                                  body: json.encode({
                                                    "Name": userData.getName,
                                                    "Phone Number":
                                                        userData.getContact,
                                                    "Table Number":
                                                        tableData.getTablenum,
                                                    "Date & Time": orderData
                                                        .orders
                                                        .map((e) => DateFormat(
                                                                'dd/MM/yyyy - hh:mm')
                                                            .format(e.dateTime))
                                                        .toString(),
                                                    "Total": orderData.orders
                                                        .map((e) =>
                                                            'RM ${e.amount.toStringAsFixed(2)}')
                                                        .toString(),
                                                    "Meals":
                                                        orderData.listOrder()
                                                  }));
                                              showDialog(
                                                context: context,
                                                builder: (ctx) => WillPopScope(
                                                  onWillPop: () async => false,
                                                  child: AlertDialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    title: const Text(
                                                        'Thank You!'),
                                                    content: RichText(
                                                      text: const TextSpan(
                                                        text:
                                                            'Your payment can be done at the counter later.',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                        ),
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                '\n[Note: You can make the payment by referring to your table number.]',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 14,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          foregroundColor:
                                                              Colors.white,
                                                          backgroundColor:
                                                              Colors.blueAccent,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            side:
                                                                const BorderSide(
                                                                    width: 3,
                                                                    color: Colors
                                                                        .white),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                          ),
                                                        ),
                                                        child:
                                                            const Text('Okay'),
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const WelcomePage()),
                                                          );
                                                          Provider.of<Orders>(
                                                                  context,
                                                                  listen: false)
                                                              .clear();
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                child: const Text('Pay Cash',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15))),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.blueAccent,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        width: 3, color: Colors.white),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => WillPopScope(
                                      onWillPop: () async => false,
                                      child: AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        title: const Text('Are you sure?'),
                                        content: RichText(
                                          text: const TextSpan(
                                            text:
                                                'Are you sure to continue to pay online?',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                            children: [
                                              TextSpan(
                                                text:
                                                    '\n[Note: You cannot change the payment method anymore.]',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor: Colors.white,
                                                backgroundColor:
                                                    Colors.redAccent,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                      width: 3,
                                                      color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                              ),
                                              child: const Text('No'),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(false);
                                              }),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              backgroundColor:
                                                  Colors.blueAccent,
                                              shape: RoundedRectangleBorder(
                                                side: const BorderSide(
                                                    width: 3,
                                                    color: Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                            child: const Text('Yes'),
                                            onPressed: () {
                                              final url = Uri.parse(
                                                  'https://rfop-e4378-default-rtdb.firebaseio.com/Orders.json');
                                              http.post(url,
                                                  body: json.encode({
                                                    "Name": userData.getName,
                                                    "Phone Number":
                                                        userData.getContact,
                                                    "Table Number":
                                                        tableData.getTablenum,
                                                    "Date & Time": orderData
                                                        .orders
                                                        .map((e) => DateFormat(
                                                                'dd/MM/yyyy - hh:mm')
                                                            .format(e.dateTime))
                                                        .toString(),
                                                    "Total": orderData.orders
                                                        .map((e) =>
                                                            'RM ${e.amount.toStringAsFixed(2)}')
                                                        .toString(),
                                                    "Meals":
                                                        orderData.listOrder()
                                                  }));
                                              showDialog(
                                                context: context,
                                                builder: (ctx) => WillPopScope(
                                                  onWillPop: () async => false,
                                                  child: AlertDialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    title: const Text(
                                                        'Thank You!'),
                                                    content: RichText(
                                                      text: const TextSpan(
                                                        text:
                                                            'Your payment is done.',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          foregroundColor:
                                                              Colors.white,
                                                          backgroundColor:
                                                              Colors.blueAccent,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            side:
                                                                const BorderSide(
                                                                    width: 3,
                                                                    color: Colors
                                                                        .white),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                          ),
                                                        ),
                                                        child:
                                                            const Text('Okay'),
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const WelcomePage()),
                                                          );
                                                          Provider.of<Orders>(
                                                                  context,
                                                                  listen: false)
                                                              .clear();
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                child: const Text('Pay Online',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15))),
                          ],
                        ),
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
