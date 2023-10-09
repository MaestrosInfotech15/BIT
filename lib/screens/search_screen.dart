import 'package:book_indian_talents_app/components/custom_loader_widget.dart';
import 'package:book_indian_talents_app/components/custom_text_widget.dart';
import 'package:book_indian_talents_app/components/search_input_widget.dart';
import 'package:book_indian_talents_app/helper/session_manager.dart';
import 'package:book_indian_talents_app/model/talents.dart';
import 'package:book_indian_talents_app/network/api_helper.dart';
import 'package:book_indian_talents_app/widgets/talent_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../provider/api_controller.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  static const String id = 'search_screen';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late Future searchFuture;

  // Future<Talent> searchArtist(String search)async{
  //   Map<String,String> body = {
  //     'name':search,
  //     'id':SessionManager.getUserId(),
  //
  //     'type':SessionManager.getLoginWith()
  //   };
  //
  //   return ApiHelper.searchArtist(body);
  // }
  Future<void> searchArtist(String search) async {
    Map<String, String> body = {
      'name': search,
      'id': SessionManager.getUserId(),
      'type': SessionManager.getLoginWith()
    };
    return Provider.of<ApiController>(context, listen: false)
        .searchArtist(body);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    searchFuture = searchArtist('a');
  }

  @override
  Widget build(BuildContext context) {
    final apiData = Provider.of<ApiController>(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: SafeArea(
              child: SearchInputWidget(
                hint: 'Search..',
                onSearchText: (search) {
                  // if(search){
                  //
                  // }
                  setState(() {
                    searchFuture = searchArtist(search);
                  });
                },
                isEnable: true,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: CustomTextWidget(
                text: 'Mostly Search',
                textColor: Colors.black,
                fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: FutureBuilder(
                future: searchFuture,
                builder: (context, response) {
                  if (response.connectionState == ConnectionState.waiting) {
                    return const CustomLoaderWidget();
                  }
                  if (apiData.searchList.isEmpty) {
                    return const Center(
                      child: CustomTextWidget(
                          text: 'No Artist Found', textColor: Colors.red),
                    );
                  }
                  return AlignedGridView.count(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 15.0),
                    itemCount: apiData.searchList.length,
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    itemBuilder: (context, index) {
                      return TalentItemWidget(datas: apiData.searchList[index]);
                    },
                  );
                }),
          )
        ],
      ),
    );
  }
}
