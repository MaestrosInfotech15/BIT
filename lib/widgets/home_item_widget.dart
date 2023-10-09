import 'package:book_indian_talents_app/components/custom_loader_widget.dart';
import 'package:book_indian_talents_app/components/custom_text_widget.dart';
import 'package:book_indian_talents_app/components/neumorphism_widget.dart';
import 'package:book_indian_talents_app/helper/constants.dart';
import 'package:book_indian_talents_app/helper/size_config.dart';
import 'package:book_indian_talents_app/model/categories.dart';
import 'package:book_indian_talents_app/model/home.dart';
import 'package:book_indian_talents_app/screens/sub_category_screen.dart';
import 'package:book_indian_talents_app/screens/talent_list_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomeItemWidget extends StatelessWidget {
  const HomeItemWidget({super.key, required this.home});

  final CategoryData home;

  @override
  Widget build(BuildContext context) {
    return NeumorphismWidget(
      padding: EdgeInsets.zero,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, SubCategoryScreen.id, arguments: home);
        },
        child: Column(
          children: [
            const SizedBox(height: 10.0),
            CachedNetworkImage(
              imageUrl:home.path!+home.image!,
              errorWidget: (context, url, error) => const Icon(Icons.error),
              height: SizeConfig.screenHeight() * 10.8,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 0.1),
              decoration: const BoxDecoration(
                  color: kAppBarColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )),
              width: double.infinity,
              child: CustomTextWidget(
                text: home.name!,
                maxLine: 1,
                textColor: Colors.black,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w700,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
