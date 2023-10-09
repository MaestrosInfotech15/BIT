import 'package:book_indian_talents_app/components/custom_button_widget.dart';
import 'package:book_indian_talents_app/components/custom_loader_widget.dart';
import 'package:book_indian_talents_app/components/custom_text_widget.dart';
import 'package:book_indian_talents_app/helper/constants.dart';
import 'package:book_indian_talents_app/helper/helper.dart';
import 'package:book_indian_talents_app/helper/session_manager.dart';
import 'package:book_indian_talents_app/model/categories.dart';
import 'package:book_indian_talents_app/model/sub_category.dart';
import 'package:book_indian_talents_app/network/api_helper.dart';
import 'package:book_indian_talents_app/provider/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterSheetWidget extends StatefulWidget {
  const FilterSheetWidget({super.key, required this.data});

  final SubCategoryData data;

  @override
  State<FilterSheetWidget> createState() => _FilterSheetWidgetState();
}

class _FilterSheetWidgetState extends State<FilterSheetWidget> {
  late Future<Category> categoriesfuture;
  late Future<SubCategory> subFuture;

  final List<double> values = [50, 100, 200, 300, 400, 500, 1000, 2000];

  double priceValue = 100;
  int rating = 0;

  CategoryData? selectedCategory = CategoryData(name: '');
  SubCategoryData? selectedSubCategory = SubCategoryData(subName: '');
  List<SubCategoryData> subCatList = [];
  bool isSubSearch = false;

  Future<Category> getCategories() async {
    return ApiHelper.getCategories();
  }

  void getSubCategory(String catId) {
    setState(() {
      isSubSearch = true;
    });
    Map<String, dynamic> body = {"cat_id": catId};
    ApiHelper.getSubcat(body).then((value) {
      setState(() {
        isSubSearch = false;
      });
      if (value.apiStatus!.toLowerCase() == 'true') {
        subCatList = value.data ?? [];
      }
    });
  }

  final List<double> testing = [50, 100, 200, 300, 400, 500, 1000, 2000];
  int selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoriesfuture = getCategories();
    selectedCategory = CategoryData(name: widget.data.categoryName!,id: widget.data.catId);
    selectedSubCategory =widget.data; //SubCategoryData(subName: widget.data.subName!);
    getSubCategory(
        widget.data.catId ?? '');
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.80,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15.0),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      children: [
                        const Expanded(
                          child: CustomTextWidget(
                            text: 'Search Filter',
                            textColor: kAppColor,
                            fontSize: 16.0,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.cancel_outlined,
                              color: Colors.grey,
                            ))
                      ],
                    ),
                  ),
                  const Divider(
                    color: kAppBarColor,
                    thickness: 0.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextWidget(
                          text: 'Categories',
                          fontSize: 16.0,
                          textColor: Theme.of(context).primaryColorLight,
                        ),
                        const SizedBox(height: 15.0),
                        FutureBuilder<Category>(
                          future: categoriesfuture,
                          builder: (context, response) {
                            if (response.connectionState ==
                                ConnectionState.waiting) {
                              return const CustomLoaderWidget();
                            }

                            if (response.data!.apiStatus!.toLowerCase() ==
                                'false') {
                              return const Center(
                                child: CustomTextWidget(
                                    text: 'No Category Found',
                                    textColor: Colors.red),
                              );
                            }
                            List<CategoryData> categorieslist =
                                response.data!.data!;

                            if (categorieslist.isEmpty) {
                              return const Center(
                                child: CustomTextWidget(
                                    text: 'No Category Found',
                                    textColor: Colors.red),
                              );
                            }
                            return Wrap(
                              children: List.generate(
                                categorieslist.length,
                                (index) => InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedCategory = categorieslist[index];
                                      getSubCategory(
                                          selectedCategory!.id ?? '');
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 5.0),
                                    margin: const EdgeInsets.only(
                                        right: 8.0, bottom: 8.0),
                                    decoration: BoxDecoration(
                                      color: selectedCategory!.name ==
                                              categorieslist[index].name
                                          ? kAppBarColor
                                          : Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: CustomTextWidget(
                                      text: categorieslist[index].name ?? '',
                                      textColor: selectedCategory!.name ==
                                              categorieslist[index].name
                                          ? Colors.white
                                          : Theme.of(context).primaryColorLight,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  isSubSearch
                      ? CustomLoaderWidget()
                      : Visibility(
                          visible: subCatList.isNotEmpty,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextWidget(
                                  text: 'Sub Categories',
                                  fontSize: 16.0,
                                  textColor:
                                      Theme.of(context).primaryColorLight,
                                ),
                                const SizedBox(height: 15.0),
                                Wrap(
                                  children: List.generate(
                                    subCatList.length,
                                    (index) => InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedSubCategory =
                                              subCatList[index];
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0, vertical: 5.0),
                                        margin: const EdgeInsets.only(
                                            right: 8.0, bottom: 8.0),
                                        decoration: BoxDecoration(
                                            color: selectedSubCategory!
                                                        .subName ==
                                                    subCatList[index].subName
                                                ? kAppBarColor
                                                : Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        child: CustomTextWidget(
                                          text: subCatList[index].subName ?? '',
                                          textColor:
                                              selectedSubCategory!.subName ==
                                                      subCatList[index].subName
                                                  ? Colors.white
                                                  : Theme.of(context)
                                                      .primaryColorLight,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                  const SizedBox(height: 15.0),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0),
                    color: Colors.red.shade100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextWidget(
                          text: 'Rating',
                          fontSize: 16.0,
                          textColor: Theme.of(context).primaryColorLight,
                        ),
                        const SizedBox(height: 15.0),
                        Row(
                          children: [
                            Expanded(
                                child: FilterRatingWidget(
                              rating: '5',
                              color: rating == 5 ? kAppBarColor : Colors.white,
                              onTap: () {
                                setState(() {
                                  rating = 5;
                                });
                              },
                            )),
                            const SizedBox(width: 10.0),
                            Expanded(
                                child: FilterRatingWidget(
                              rating: '4',
                              color: rating == 4 ? kAppBarColor : Colors.white,
                              onTap: () {
                                setState(() {
                                  rating = 4;
                                });
                              },
                            )),
                            const SizedBox(width: 10.0),
                            Expanded(
                                child: FilterRatingWidget(
                              rating: '3',
                              color: rating == 3 ? kAppBarColor : Colors.white,
                              onTap: () {
                                setState(() {
                                  rating = 3;
                                });
                              },
                            )),
                            const SizedBox(width: 10.0),
                            Expanded(
                                child: FilterRatingWidget(
                              rating: '2',
                              color: rating == 2 ? kAppBarColor : Colors.white,
                              onTap: () {
                                setState(() {
                                  rating = 2;
                                });
                              },
                            )),
                            const SizedBox(width: 10.0),
                            Expanded(
                                child: FilterRatingWidget(
                              rating: '1',
                              color: rating == 1 ? kAppBarColor : Colors.white,
                              onTap: () {
                                setState(() {
                                  rating = 1;
                                });
                              },
                            )),
                          ],
                        ),
                        const SizedBox(height: 15.0),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextWidget(
                          text: 'Price',
                          fontSize: 16.0,
                          textColor: Theme.of(context).primaryColorLight,
                        ),
                        const SizedBox(height: 15.0),
                        SliderTheme(
                          data: SliderThemeData(
                            overlayShape: SliderComponentShape.noThumb,
                            showValueIndicator: ShowValueIndicator.always,
                            trackHeight: 10,
                            trackShape: const RoundedRectSliderTrackShape(),
                          ),
                          child: Slider(
                            activeColor: kAppBarColor,
                            thumbColor: kAppColor,
                            inactiveColor: Colors.grey.shade200,
                            label: testing[selectedIndex].toString(),
                            value: selectedIndex.toDouble(),
                            divisions: testing.length - 1,
                            onChanged: (value) {
                              setState(() {
                                selectedIndex = value.toInt();
                              });
                            },
                            max: testing.length - 1,
                            min: 0,
                          ),
                        ),
                        Row(
                          children: [
                            CustomTextWidget(
                              text: '₹50',
                              textColor: Theme.of(context).primaryColorLight,
                              fontSize: 15.0,
                            ),
                            const Spacer(),
                            CustomTextWidget(
                              text: '₹2000',
                              textColor: Theme.of(context).primaryColorLight,
                              fontSize: 15.0,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15.0),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            decoration: const BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5.0,
              ),
            ]),
            child: Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: const CustomTextWidget(
                    text: 'Clear Filter',
                    textColor: Colors.black87,
                    fontSize: 16.0,
                  ),
                ),
                const Spacer(),
                CustomButtonWidget(
                  text: 'Apply',
                  onClick: () {
                    searchFilter();
                  },
                  width: 120,
                  radius: 25.0,
                  height: 45.0,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void searchFilter() {
    if (selectedCategory!.name!.isNotEmpty) {
      if (selectedSubCategory!.subName!.isEmpty) {
        Helper.showToastMessage('Select Sub Category', Colors.red);
        return;
      }
    }
    Map<String, dynamic> body = {
      'cat_id': '${selectedCategory!.id}',
      "subcat_id": '${selectedSubCategory!.id}',
      //  'fee': '${testing[selectedIndex].toInt()}',
      'id': SessionManager.getUserId(),
      'type': SessionManager.getLoginWith(),
      'rating':rating.toString(),
      'cat_name': selectedSubCategory!.categoryName,
      'sub_name': selectedSubCategory!.subName,
      'user_id': SessionManager.getUserId()
    };

    Map<String, dynamic> filterbody = {
      'fee': '${testing[selectedIndex].toInt()}',
      'rating': rating.toString(),
      'cat_name': selectedSubCategory!.categoryName,
      'sub_name': selectedSubCategory!.subName,
    };
    Provider.of<AppController>(context, listen: false).setFilter(filterbody);
    Navigator.pop(context, body);
    print('BODY $body');
  }
}

class FilterRatingWidget extends StatelessWidget {
  const FilterRatingWidget({
    super.key,
    required this.color,
    required this.rating,
    required this.onTap,
  });

  final String rating;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: Colors.grey)),
        child: Column(
          children: [
            const Icon(
              Icons.star,
              color: Colors.black54,
              size: 20,
            ),
            const SizedBox(height: 5.0),
            CustomTextWidget(
              text: rating,
              textColor: Colors.black54,
              fontWeight: FontWeight.w600,
            )
          ],
        ),
      ),
    );
  }
}
