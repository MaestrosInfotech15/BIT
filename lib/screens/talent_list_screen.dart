import 'package:book_indian_talents_app/components/custom_button_widget.dart';
import 'package:book_indian_talents_app/components/custom_loader_widget.dart';
import 'package:book_indian_talents_app/components/custom_text_widget.dart';
import 'package:book_indian_talents_app/components/neumorphism_widget.dart';
import 'package:book_indian_talents_app/components/search_input_widget.dart';
import 'package:book_indian_talents_app/helper/constants.dart';
import 'package:book_indian_talents_app/helper/session_manager.dart';
import 'package:book_indian_talents_app/helper/size_config.dart';
import 'package:book_indian_talents_app/model/sub_category.dart';
import 'package:book_indian_talents_app/model/talents.dart';
import 'package:book_indian_talents_app/provider/api_controller.dart';
import 'package:book_indian_talents_app/provider/app_controller.dart';
import 'package:book_indian_talents_app/screens/artist_plan_screen.dart';
import 'package:book_indian_talents_app/screens/search_screen.dart';
import 'package:book_indian_talents_app/screens/talent_detail_screen.dart';
import 'package:book_indian_talents_app/widgets/filter_sheet_widget.dart';
import 'package:book_indian_talents_app/widgets/talent_list_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../model/categories.dart';
import '../network/api_helper.dart';

class TalentListScreen extends StatefulWidget {
  static const String id = 'talent_list_screen';
  final SubCategoryData data;

  const TalentListScreen({super.key, required this.data});

  @override
  State<TalentListScreen> createState() => _TalentScreenState();
}

class _TalentScreenState extends State<TalentListScreen> {
  late Future talentfuture;

  Future<void> getTalent(Map<String, dynamic> body) async {
    print(body);
     return Provider.of<ApiController>(context,listen: false).getTalentData(body);
  }

  String appBarTitle = '';
 Map<String,dynamic>tampbody={};
  Map<String, dynamic> filterBody = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AppController>(context, listen: false).setFilter({});
    Map<String, dynamic> body = {
      'cat_id': widget.data.catId,
      "subcat_id": widget.data.id,
      'id': SessionManager.getUserId(),
      'type': SessionManager.getLoginWith(),
      'user_id':SessionManager.getUserId(),
      'rating':'0'
    };
    tampbody=body;
    talentfuture = getTalent(body);
    appBarTitle = widget.data.subName!;}
  @override
  Widget build(BuildContext context) {
    final apidata=Provider.of<ApiController>(context);
    final data=Provider.of<AppController>(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: CustomTextWidget(
          text: appBarTitle,
          textColor: Theme.of(context).hintColor,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SearchBarWidget(
              onClick: () {
                Navigator.pushNamed(context, SearchScreen.id);
              },
              onFilterClick: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return FilterSheetWidget(data: widget.data,);
                  },
                ).then((value) {
                  if (value != null) {
                    filterBody = value as Map<String, dynamic>;
                    setState(() {
                      appBarTitle = filterBody['sub_name'];
                      // filterBody.remove('sub_name');
                      // filterBody.remove('cat_name');
                      talentfuture = getTalent(filterBody);
                    });
                  }
                });
              },
            ),
          ),
          const SizedBox(height: 15.0),
          Visibility(
            visible: data.filterBody.isNotEmpty,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Visibility(
                    visible: data.filterBody['cat_name'] != null,
                    child: AppliedFilterWidget(
                      title: data.filterBody['cat_name'] ?? '',
                      color: Colors.grey,
                    ),
                  ),
                  Visibility(
                    visible: data.filterBody['sub_name'] != null,
                    child: AppliedFilterWidget(
                        title: data.filterBody['sub_name'] ?? '',
                        color: Colors.grey),
                  ),
                  Visibility(
                    visible: data.filterBody['rating'] != null,
                    child: AppliedFilterWidget(
                      title: 'Rating: ${data.filterBody['rating'] ?? ''}',
                      color: Colors.grey,
                    ),
                  ),
                  Visibility(
                    visible: data.filterBody['fee'] != null,
                    child: AppliedFilterWidget(
                      title: 'Price ${data.filterBody['fee'] ?? ''}',
                      color: Colors.grey,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        data.filterBody.clear();
                        Map<String, dynamic> body = {
                          'cat_id': widget.data.catId,
                          "subcat_id": widget.data.id,
                          'id': SessionManager.getUserId(),
                          'type': SessionManager.getLoginWith()
                        };
                        talentfuture = getTalent(tampbody);
                      });
                    },
                    child: const AppliedFilterWidget(
                      title: 'Remove',
                      color: kAppBarColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: talentfuture,
                builder: (context, response) {
                  if (response.connectionState == ConnectionState.waiting) {
                    return const CustomLoaderWidget();
                  }

                  if (apidata.talentDataList.isEmpty) {
                    return const Center(
                      child: CustomTextWidget(
                          text: 'No Artist Found', textColor: Colors.red),
                    );
                  }
                  return AlignedGridView.count(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 15.0),
                    itemCount: apidata.talentDataList.length,
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    itemBuilder: (context, index) {
                      return TalentItemWidget(datas: apidata.talentDataList[index]);
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class AppliedFilterWidget extends StatelessWidget {
  const AppliedFilterWidget({
    super.key,
    required this.title,
    required this.color,
  });

  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      margin: const EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: CustomTextWidget(
        text: title,
        fontSize: 12.0,
        fontWeight: FontWeight.w600,
        textColor: Colors.white,
      ),
    );
  }
}
