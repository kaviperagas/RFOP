import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tables.dart';
import '../screens/meals_page.dart';

class TableItem extends StatelessWidget {
  final String id;
  final String number;
  final String imageUrl;

  const TableItem(this.id, this.number, this.imageUrl, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tableData = Provider.of<Tables>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(
            number,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        child: GestureDetector(
          onTap: () {
            tableData.saveTableNum(number);
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
                'assets/istockphoto-1011317092-170667a.jpg',
                fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
