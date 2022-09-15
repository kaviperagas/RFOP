import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rfop/providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String mealId;
  final String price;
  final int quantity;
  final String name;
  final String imageUrl;

  const CartItem(
      this.id, this.mealId, this.name, this.quantity, this.price, this.imageUrl,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Dismissible(
        key: ValueKey(id),
        background: Container(
          color: Theme.of(context).errorColor,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          child: const Icon(Icons.delete, color: Colors.white, size: 40),
        ),
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction) {
          return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              title: const Text('Are you sure?'),
              content:
                  const Text('Do you want to remove the item from the cart?'),
              actions: <Widget>[
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 3, color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text('No'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    }),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 3, color: Colors.white),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text('Yes'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            ),
          );
        },
        onDismissed: (direction) {
          Provider.of<Cart>(context, listen: false).removeItem(mealId);
        },
        child: quantity == 0
            ? const Center(
                child: SizedBox(
                  height: 0,
                ),
              )
            : Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                  child: ListTile(
                    horizontalTitleGap: 25,
                    leading: SizedBox(
                      width: 60,
                      height: 60,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          imageUrl: imageUrl,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/eiliv-sonas-aceron-w0JzqJZYX_E-unsplash.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      '$name \n(RM $price)',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    subtitle: Text(
                        'Total: RM${((double.parse(price)) * Provider.of<Cart>(context, listen: false).itemQuantity(mealId)).toStringAsFixed(2)}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          visualDensity: const VisualDensity(
                              horizontal: -4.0, vertical: -4.0),
                          padding: EdgeInsets.zero,
                          iconSize: 16,
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            Provider.of<Cart>(context, listen: false)
                                .reduceItem(mealId, price, name, imageUrl);
                          },
                        ),
                        Flexible(
                          child: Text(
                            '${Provider.of<Cart>(context).itemQuantity(mealId).toString()} x',
                          ),
                        ),
                        IconButton(
                          visualDensity: const VisualDensity(
                              horizontal: -4.0, vertical: -4.0),
                          padding: EdgeInsets.zero,
                          iconSize: 16,
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            Provider.of<Cart>(context, listen: false)
                                .addItem(mealId, price, name, imageUrl);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
