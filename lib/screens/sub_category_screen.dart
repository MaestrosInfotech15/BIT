import 'package:book_indian_talents_app/components/custom_loader_widget.dart';
import 'package:book_indian_talents_app/components/custom_text_widget.dart';
import 'package:book_indian_talents_app/components/neumorphism_widget.dart';
import 'package:book_indian_talents_app/helper/constants.dart';
import 'package:book_indian_talents_app/model/categories.dart';
import 'package:book_indian_talents_app/model/sub_category.dart';
import 'package:book_indian_talents_app/network/api_helper.dart';
import 'package:book_indian_talents_app/screens/talent_list_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../helper/size_config.dart';

class SubCategoryScreen extends StatefulWidget {
  const SubCategoryScreen({super.key, required this.categoriesData});

  static const String id = 'sub_category_screen';

  final CategoryData categoriesData;

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  late Future<SubCategory> subFuture;

  Future<SubCategory> getSubCategory() {
    Map<String, dynamic> body = {"cat_id": widget.categoriesData.id};
    return ApiHelper.getSubcat(body);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subFuture = getSubCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: CustomTextWidget(
          text: widget.categoriesData.name!,
          textColor: Theme.of(context).hintColor,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: FutureBuilder<SubCategory>(
        future: subFuture,
        builder: (context, response) {
          if (response.connectionState == ConnectionState.waiting) {
            return const CustomLoaderWidget();
          }

          if (response.data!.apiStatus == false) {
            return const Center(
              child: CustomTextWidget(
                  text: 'No data found', textColor: Colors.red),
            );
          }
          List<SubCategoryData> subCategoryList = response.data!.data!;
          if (subCategoryList.isEmpty) {
            return const Center(
              child: CustomTextWidget(
                  text: 'No data found', textColor: Colors.red),
            );
          }
          return AlignedGridView.count(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            itemCount: subCategoryList.length,
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            itemBuilder: (context, index) {
              return SubCategoryWidget(subCategory: subCategoryList[index]);
            },
          );
        },
      ),
    );
  }
}

class SubCategoryWidget extends StatelessWidget {
  const SubCategoryWidget({super.key, required this.subCategory});

  final SubCategoryData subCategory;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, TalentListScreen.id,arguments: subCategory);
      },
      child: NeumorphismWidget(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            const SizedBox(height: 10.0),
            CachedNetworkImage(
              imageUrl:subCategory.path!+subCategory.image!,
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
                text: subCategory.subName!,
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
