import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_apps/src/model/data.dart';
import 'package:flutter_ecommerce_apps/src/themes/light_color.dart';
import 'package:flutter_ecommerce_apps/src/themes/theme.dart';
import 'package:flutter_ecommerce_apps/src/widgets/title_text.dart';
import 'package:flutter_ecommerce_apps/src/widgets/extentions.dart';

class ProductDetailPage extends StatefulWidget {
  ProductDetailPage({Key? key}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: controller, curve: Curves.easeInToLinear));
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool isLiked = true;

  // App Bar Widget
  Widget _appBar() {
    return Padding(
      padding: AppTheme.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
            size: 15,
            padding: 12,
            isOutLine: true,
            onPressed: () => Navigator.of(context).pop(),
          ),
          _icon(
            isLiked ? Icons.favorite : Icons.favorite_border,
            color: isLiked ? LightColor.red : LightColor.lightGrey,
            size: 15,
            padding: 12,
            isOutLine: false,
            onPressed: () {
              setState(() {
                isLiked = !isLiked;
              });
            },
          ),
        ],
      ),
    );
  }

  // Icon Widget
  Widget _icon(
      IconData icon, {
        Color color = LightColor.iconColor,
        double size = 20,
        double padding = 10,
        bool isOutLine = false,
        Function? onPressed,
      }) {
    return Container(
      height: 40,
      width: 40,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        border: Border.all(
          color: LightColor.iconColor,
          style: isOutLine ? BorderStyle.solid : BorderStyle.none,
        ),
        borderRadius: BorderRadius.all(Radius.circular(13)),
        color: isOutLine ? Colors.transparent : Theme.of(context).scaffoldBackgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0xfff8f8f8),
            blurRadius: 5,
            spreadRadius: 10,
            offset: Offset(5, 5),
          ),
        ],
      ),
      child: Icon(icon, color: color, size: size),
    ).ripple(() {
      if (onPressed != null) {
        onPressed();
      }
    }, borderRadius: BorderRadius.all(Radius.circular(13)));
  }

  // Product Image Widget
  Widget _productImage() {
    return AnimatedBuilder(
      builder: (context, child) {
        return AnimatedOpacity(
          duration: Duration(milliseconds: 500),
          opacity: animation.value,
          child: child,
        );
      },
      animation: animation,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          TitleText(
            text: "AIP",
            fontSize: 160,
            color: LightColor.lightGrey,
          ),
          Image.asset('assets/show_1.png')
        ],
      ),
    );
  }

  // Category Widget (Thumbnails)
  Widget _categoryWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0),
      width: AppTheme.fullWidth(context),
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: AppData.showThumbnailList.map((x) => _thumbnail(x)).toList(),
      ),
    );
  }

  // Thumbnail Widget
  Widget _thumbnail(String image) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => AnimatedOpacity(
        opacity: animation.value,
        duration: Duration(milliseconds: 500),
        child: child,
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: 40,
          width: 50,
          decoration: BoxDecoration(
            border: Border.all(
              color: LightColor.grey,
            ),
            borderRadius: BorderRadius.all(Radius.circular(13)),
          ),
          child: Image.asset(image),
        ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(13))),
      ),
    );
  }

  // Detail Widget (Draggable Scrollable Sheet)
  Widget _detailWidget() {
    return DraggableScrollableSheet(
      maxChildSize: .8,
      initialChildSize: .53,
      minChildSize: .53,
      builder: (context, scrollController) {
        return Container(
          padding: AppTheme.padding.copyWith(bottom: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 5),
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                        color: LightColor.iconColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                SizedBox(height: 10),
                _productInfo(),
                SizedBox(height: 20),
                _availableSize(),
                SizedBox(height: 20),
                _availableColor(),
                SizedBox(height: 20),
                _description(),
              ],
            ),
          ),
        );
      },
    );
  }

  // Product Info (Name, Price, Rating)
  Widget _productInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TitleText(text: "NIKE AIR MAX 200", fontSize: 25),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Row(
              children: <Widget>[
                TitleText(text: "\$ ", fontSize: 18, color: LightColor.red),
                TitleText(text: "240", fontSize: 25),
              ],
            ),
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < 4
                      ? Icons.star
                      : Icons.star_border,
                  color: LightColor.yellowColor,
                  size: 17,
                );
              }),
            ),
          ],
        ),
      ],
    );
  }

  // Available Size Widget
  Widget _availableSize() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleText(text: "Available Size", fontSize: 14),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _sizeWidget("US 6"),
            _sizeWidget("US 7", isSelected: true),
            _sizeWidget("US 8"),
            _sizeWidget("US 9"),
          ],
        ),
      ],
    );
  }

  // Size Widget
  Widget _sizeWidget(String text, {bool isSelected = false}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
            color: LightColor.iconColor,
            style: !isSelected ? BorderStyle.solid : BorderStyle.none),
        borderRadius: BorderRadius.all(Radius.circular(13)),
        color: isSelected
            ? LightColor.orange
            : Theme.of(context).scaffoldBackgroundColor,
      ),
      child: TitleText(
        text: text,
        fontSize: 16,
        color: isSelected
            ? LightColor.background
            : LightColor.titleTextColor,
      ),
    ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(13)));
  }

  // Available Color Widget
  Widget _availableColor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleText(text: "Available Colors", fontSize: 14),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _colorWidget(LightColor.yellowColor, isSelected: true),
            SizedBox(width: 30),
            _colorWidget(LightColor.lightBlue),
            SizedBox(width: 30),
            _colorWidget(LightColor.black),
            SizedBox(width: 30),
            _colorWidget(LightColor.red),
            SizedBox(width: 30),
            _colorWidget(LightColor.skyBlue),
          ],
        ),
      ],
    );
  }

  // Color Widget
  Widget _colorWidget(Color color, {bool isSelected = false}) {
    return CircleAvatar(
      radius: 12,
      backgroundColor: color.withAlpha(150),
      child: isSelected
          ? Icon(Icons.check_circle, color: color, size: 18)
          : CircleAvatar(radius: 7, backgroundColor: color),
    );
  }

  // Description Widget
  Widget _description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleText(text: "Description", fontSize: 14),
        SizedBox(height: 20),
        Text(AppData.description),
      ],
    );
  }

  // Floating Action Button
  FloatingActionButton _flotingButton() {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: LightColor.orange,
      child: Icon(
        Icons.shopping_basket,
        color: Theme.of(context).floatingActionButtonTheme.backgroundColor ?? LightColor.orange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _flotingButton(),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xfffbfbfb),
                Color(0xfff7f7f7),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  _appBar(),
                  _productImage(),
                  _categoryWidget(),
                ],
              ),
              _detailWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
