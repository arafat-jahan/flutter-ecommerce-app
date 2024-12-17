import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_apps/src/model/data.dart';
import 'package:flutter_ecommerce_apps/src/themes/light_color.dart';
import 'package:flutter_ecommerce_apps/src/themes/theme.dart';
import 'package:flutter_ecommerce_apps/src/widgets/product_card.dart';
import 'package:flutter_ecommerce_apps/src/widgets/product_icon.dart';
import 'package:flutter_ecommerce_apps/src/widgets/extentions.dart';

class MyHomePage extends StatefulWidget {
  final String? title; // Nullable title for null-safety

  const MyHomePage({Key? key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Updated _icon method to use scaffoldBackgroundColor
  Widget _icon(IconData icon, {Color color = LightColor.iconColor}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(13)),
        color: Theme.of(context).scaffoldBackgroundColor, // Fixed here
        boxShadow: AppTheme.shadow,
      ),
      child: Icon(
        icon,
        color: color,
      ),
    ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(13)));
  }

  Widget _categoryWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: AppTheme.fullWidth(context),
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: AppData.categoryList
            .map(
              (category) => ProductIcon(
            model: category,
            onSelected: (model) {
              setState(() {
                for (var item in AppData.categoryList) {
                  item.isSelected = false;
                }
                model.isSelected = true;
              });
            },
          ),
        )
            .toList(),
      ),
    );
  }

  Widget _productWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: AppTheme.fullWidth(context),
      height: AppTheme.fullWidth(context) * .7,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 4 / 3,
          mainAxisSpacing: 30,
          crossAxisSpacing: 20,
        ),
        padding: EdgeInsets.only(left: 20),
        scrollDirection: Axis.horizontal,
        itemCount: AppData.productList.length,
        itemBuilder: (context, index) {
          final product = AppData.productList[index];
          return ProductCard(
            product: product,
            onSelected: (model) {
              setState(() {
                for (var item in AppData.productList) {
                  item.isSelected = false;
                }
                model.isSelected = true;
              });
            },
          );
        },
      ),
    );
  }

  Widget _search() {
    return Container(
      margin: AppTheme.padding,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: LightColor.lightGrey.withAlpha(100),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search Products",
                  hintStyle: TextStyle(fontSize: 12),
                  contentPadding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 0,
                    top: 5,
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.black54),
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          _icon(Icons.filter_list, color: Colors.black54),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 210,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        dragStartBehavior: DragStartBehavior.down,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _search(),
            _categoryWidget(),
            _productWidget(),
          ],
        ),
      ),
    );
  }
}
