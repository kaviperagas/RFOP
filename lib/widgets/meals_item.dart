import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rfop/providers/cart.dart';
import 'package:rfop/screens/meals_page.dart';
import 'package:rfop/widgets/badge.dart';

class MealsItem extends StatelessWidget {
  final String id;
  final String name;
  final String price;
  final String imageUrl;
  final String category;

  const MealsItem(this.id, this.name, this.price, this.imageUrl, this.category, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    final _iconButton = IconButton(
        icon: const Icon(
          Icons.add,
        ),
        onPressed: () {
          cart.addItem(id, price, name, imageUrl);
        });
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        footer: Container(
          padding: const EdgeInsets.all(0),
          color: Colors.black45,
          height: 90,
          child: GridTileBar(
            title: Text(
              name,
              maxLines: 3,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'RM ${double.parse(price).toStringAsFixed(2)}',
              maxLines: 2,
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            trailing: Row(
              children: [
                IconButton(
                  visualDensity:
                      const VisualDensity(horizontal: -4.0, vertical: -4.0),
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    cart.reduceItem(id, price, name, imageUrl);
                  },
                ),
                Consumer<Cart>(
                  builder: (_, cart, ch) => cart.itemQuantity(id) == 0
                      ? _iconButton
                      : Badge(
                          value: cart.itemQuantity(id).toString(),
                          color: Colors.redAccent,
                          child: ch as Widget,
                        ),
                  child: _iconButton,
                ),
              ],
            ),
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(MealsPage.routeName, arguments: id);
          },
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                SizedBox(
                    height: 60,
                    child: Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress))),
            errorWidget: (context, url, error) => Image.asset(
                'assets/eiliv-sonas-aceron-w0JzqJZYX_E-unsplash.jpg',
                fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
