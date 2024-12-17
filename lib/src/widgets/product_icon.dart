import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_apps/src/model/category.dart';
import 'package:flutter_ecommerce_apps/src/themes/light_color.dart';
import 'package:flutter_ecommerce_apps/src/themes/theme.dart';
import 'package:flutter_ecommerce_apps/src/widgets/title_text.dart';
import 'package:flutter_ecommerce_apps/src/widgets/extentions.dart';

class ProductIcon extends StatelessWidget {
  final ValueChanged<Category> onSelected;
  final Category model;

  // Constructor with required nullable parameters
  ProductIcon({
    Key? key, // Nullable key for null safety
    required this.model, // Ensure model is required
    required this.onSelected, // Ensure onSelected callback is required
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // If the model's id is null, return an empty container
    if (model.id == null) {
      return Container(width: 5); // Can be adjusted for a more appropriate fallback
    }

    // Main container for the ProductIcon widget
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Container(
        padding: AppTheme.hPadding,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: model.isSelected ? LightColor.background : Colors.transparent,
          border: Border.all(
            color: model.isSelected ? LightColor.orange : LightColor.grey,
            width: model.isSelected ? 2 : 1,
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: model.isSelected ? Color(0xfffbf2ef) : Colors.white,
              blurRadius: 10,
              spreadRadius: 5,
              offset: Offset(5, 5),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            // Check if the image path is not null before displaying
            if (model.image != null && model.image!.isNotEmpty)
              Image.asset(model.image!),
            // Check if the name is not null and display TitleText
            if (model.name != null && model.name!.isNotEmpty)
              TitleText(
                text: model.name!,
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
          ],
        ),
      ).ripple(
            () {
          onSelected(model);
        },
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}
