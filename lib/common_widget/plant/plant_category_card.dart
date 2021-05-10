import 'package:cached_network_image/cached_network_image.dart';
import 'package:floradb/common_widget/text_with_border.dart';
import 'package:floradb/model/plant/plant_category.dart';
import 'package:floradb/res/app_color.dart';
import 'package:floradb/site_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class PlantCategoryCard extends StatelessWidget {
  PlantCategoryCard({required this.plantCategory});

  final PlantCategory plantCategory;

  static PlantCategoryCard buildInstance(PlantCategory plantCategory) {
    return PlantCategoryCard(plantCategory: plantCategory);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(SiteNavigation.PLANTCATEGORYDETAIL,
          arguments: plantCategory.id),
      child: Card(
        color: Colors.transparent,
        elevation: 6.0,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: CachedNetworkImage(
                width: 220,
                height: 220,
                imageUrl: plantCategory.imageURLs.first,
                placeholder: (context, url) => Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: CircularProgressIndicator().centered()),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
            //Image(image: CachedNetworkImageProvider(plantCategory.imageURL)),
            TextWithBorder(
                    text: plantCategory.vietnameseName,
                    size: 20.0,
                    strokeWidth: 1.2,
                    fontWeight: FontWeight.w700,
                    fillColor: AppColor.scaffoldBackgroundColor,
                    borderColor: Colors.black)
                .p(4.0),
          ],
        ),
      ).pOnly(top: 4.0),
    );
  }
}
