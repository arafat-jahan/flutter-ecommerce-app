import 'package:flutter/material.dart';

import 'package:flutter_ecommerce_apps/src/model/product.dart';
import 'package:flutter_ecommerce_apps/src/themes/light_color.dart';
import 'package:flutter_ecommerce_apps/src/widgets/title_text.dart';
import 'package:flutter_ecommerce_apps/src/widgets/extentions.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final ValueChanged<Product> onSelected;

  ProductCard({
    Key? key, // Nullable key
    required this.product, // Ensuring the product is required
    required this.onSelected, // Ensuring the onSelected callback is required
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: LightColor.background,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Color(0xfff8f8f8), blurRadius: 15, spreadRadius: 10),
        ],
      ),
      margin: EdgeInsets.symmetric(vertical: !product.isSelected ? 20 : 0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              left: 0,
              top: 0,
              child: IconButton(
                icon: Icon(
                  product.isLiked ? Icons.favorite : Icons.favorite_border,
                  color: product.isLiked ? LightColor.red : LightColor.iconColor,
                ),
                onPressed: () {
                  // Toggling the 'isLiked' state
                  onSelected(product.copyWith(isLiked: !product.isLiked));
                },
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(height: product.isSelected ? 15 : 0),
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: LightColor.orange.withAlpha(40),
                      ),
                      // Check if product.image is valid before displaying the image
                      product.image.isNotEmpty
                          ? Image.asset(product.image)
                          : Container(), // Placeholder for missing image
                    ],
                  ),
                ),
                TitleText(
                  text: product.name,
                  fontSize: product.isSelected ? 16 : 14,
                ),
                TitleText(
                  text: product.category,
                  fontSize: product.isSelected ? 14 : 12,
                  color: LightColor.orange,
                ),
                TitleText(
                  text: product.price.toString(),
                  fontSize: product.isSelected ? 18 : 16,
                ),
              ],
            ),
          ],
        ),
      ).ripple(() {
        Navigator.of(context).pushNamed('/detail');
        onSelected(product);
      }, borderRadius: BorderRadius.all(Radius.circular(20))),
    );
  }
}

