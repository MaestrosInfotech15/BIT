import 'package:book_indian_talents_app/components/custom_button_widget.dart';
import 'package:book_indian_talents_app/components/custom_loader_widget.dart';
import 'package:book_indian_talents_app/components/custom_text_widget.dart';
import 'package:book_indian_talents_app/helper/constants.dart';
import 'package:book_indian_talents_app/model/cat_sub_cat.dart';
import 'package:book_indian_talents_app/provider/api_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategorySubCategoryWidget extends StatefulWidget {
  const CategorySubCategoryWidget({super.key});

  @override
  State<CategorySubCategoryWidget> createState() =>
      _CategorySubCategoryWidgetState();
}

class _CategorySubCategoryWidgetState extends State<CategorySubCategoryWidget> {
  late Future _catFuture;

  Future<void> getCatSubCat() async {
    return Provider.of<ApiController>(context, listen: false).getCatSubCat();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _catFuture = getCatSubCat();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ApiController>(context);

    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height * 0.80,
      child: Column(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            padding: const EdgeInsets.only(left: 20.0),
            child: Row(
              children: [
                const Expanded(
                  child: CustomTextWidget(
                    text: 'Select Category/Sub Category',
                    textColor: Colors.white,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.clear,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
          const SizedBox(height: 15.0),
          Expanded(
            child: FutureBuilder(
              future: _catFuture,
              builder: (context, response) {
                if (response.connectionState == ConnectionState.waiting) {
                  return const CustomLoaderWidget();
                }

                if (data.catSubCatList.isEmpty) {
                  return const Center(
                      child: CustomTextWidget(
                          text: 'No category found', textColor: Colors.red));
                }
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  itemCount: data.catSubCatList.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextWidget(
                          text: data.catSubCatList[index].name ?? '',
                          textColor: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                        const SizedBox(height: 8.0),
                        Wrap(
                          children: List.generate(
                            data.catSubCatList[index].subcategory!.length,
                            (subIndex) => InkWell(
                              child: Container(
                                margin: const EdgeInsets.only(
                                    right: 5.0, bottom: 5.0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                    color: data.catSubCatList[index]
                                            .subcategory![subIndex].isSelected!
                                        ? kAppColor
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(25.0),
                                    border: Border.all(
                                        color: Colors.grey.shade400)),
                                child: CustomTextWidget(
                                  text: data.catSubCatList[index]
                                      .subcategory![subIndex].subName!,
                                  textColor:
                                      Theme.of(context).primaryColorLight,
                                  fontSize: 12.0,
                                ),
                              ),
                              onTap: () {
                                selectSubCategory(data.catSubCatList[index]
                                    .subcategory![subIndex]);
                              },
                            ),
                          ),
                        )
                      ],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(color: Colors.grey.shade200),
                );
              },
            ),
          ),
          const SizedBox(height: 15.0),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: CustomButtonWidget(
              text: 'Save',
              onClick: () {
                check();
              },
            ),
          )
        ],
      ),
    );
  }

  void selectSubCategory(SubCategoryList subCategoryList) {
    final data = Provider.of<ApiController>(context, listen: false);

    for (var cat in data.catSubCatList) {
      List<SubCategoryList> subList = [];

      for (var subCat in cat.subcategory!) {
        if (subCat == subCategoryList) {
          SubCategoryList updateSub = SubCategoryList(
              subName: subCat.subName,
              id: subCat.id,
              isSelected: !subCat.isSelected!);
          subList.add(updateSub);
        } else {
          subList.add(subCat);
        }
      }
      CategoryList updateCatList = CategoryList(
          id: cat.id, subcategory: subList, name: cat.name, isCat: false);

      data.updateSelectedCategory(updateCatList);
    }
  }

  void check() {
    final data = Provider.of<ApiController>(context, listen: false);

    List<String> catIds = [];
    List<String> subCatIds = [];
    List<String> catNames = [];
    List<String> subCatNames = [];
    Map<String, List<String>> groupedCourts = {};

    for (var cat in data.catSubCatList) {
      for (var subCat in cat.subcategory!) {
        if (subCat.isSelected!) {
          if (!catIds.contains(cat.id!)) {
            catIds.add(cat.id!);
            catNames.add(cat.name!);
          }
          subCatIds.add(subCat.id!);
          subCatNames.add(subCat.subName!);

          if (groupedCourts.containsKey(cat.id)) {
            groupedCourts[cat.id]!.add(subCat.id!);
          } else {
            groupedCourts[cat.id!] = [subCat.id!];
          }
        }
      }
    }

    String cId = '';
    String subId = '';

    for (var entry in groupedCourts.entries) {
      cId += '${entry.key},';
      subId += '${entry.value.join(',')}|';
    }

    cId = cId.substring(0, cId.length - 1);
    subId = subId.substring(0, subId.length - 1);

    data.setUpdateCategory(catNames, subCatNames);

    Map<String, String> body = {
      'cat_id': cId,
      'subcat_id': subId,
    };

    Navigator.pop(context, body);
  }
}
