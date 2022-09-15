import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rfop/providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;

  const OrderItem(this.order, {Key? key}) : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('RM ${(widget.order.amount).toStringAsFixed(2)}'),
            subtitle: Text(
                DateFormat('dd/MM/yyyy (hh:mm)').format(widget.order.dateTime)),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(
                  () {
                    _expanded = !_expanded;
                  },
                );
              },
            ),
          ),
          if (_expanded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: 370,
              child: ListView(
                children: widget.order.meals
                    .map(
                      (meals) => meals.quantity == 0
                          ? const SizedBox(height: 0)
                          : Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 4),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                                child: ListTile(
                                  leading: SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: ClipOval(
                                      child: CachedNetworkImage(
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                        imageUrl: meals.imageUrl,
                                        placeholder: (context, url) =>
                                            const Center(
                                                child:
                                                    CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                          'assets/eiliv-sonas-aceron-w0JzqJZYX_E-unsplash.jpg',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                      '${meals.name} \n(RM ${meals.price})',
                                      overflow: TextOverflow.ellipsis),
                                  subtitle: Text(
                                      'Total: RM${((double.parse(meals.price)) * meals.quantity).toStringAsFixed(2)}'),
                                  trailing: Text('${meals.quantity} x'),
                                ),
                              ),
                            ),
                    )
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
