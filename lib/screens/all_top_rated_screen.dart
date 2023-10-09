import 'package:book_indian_talents_app/components/custom_loader_widget.dart';
import 'package:book_indian_talents_app/components/custom_text_widget.dart';
import 'package:book_indian_talents_app/helper/constants.dart';
import 'package:book_indian_talents_app/model/talents.dart';
import 'package:book_indian_talents_app/network/api_helper.dart';
import 'package:book_indian_talents_app/widgets/talent_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class AllTopRatedScreen extends StatefulWidget {
  static const String id = 'all_top_rated_screen';

  const AllTopRatedScreen({super.key});

  @override
  State<AllTopRatedScreen> createState() => _AllTopRatedScreenState();
}

class _AllTopRatedScreenState extends State<AllTopRatedScreen> {
  late Future<Talent> topRatedFuture;

  Future<Talent> getTopRated() async {
    return ApiHelper.getTopRated();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    topRatedFuture = getTopRated();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: CustomTextWidget(
          text: 'All Top Rated',
          textColor: Theme.of(context).hintColor,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: FutureBuilder<Talent>(
          future: topRatedFuture,
          builder: (context, response) {
            if (response.connectionState == ConnectionState.waiting) {
              return const CustomLoaderWidget();
            }
            if (response.data!.apiStatus == 'false') {
              return const Center(
                child: CustomTextWidget(
                    text: 'No Artist Found', textColor: Colors.red),
              );
            }
            List<TalentData> talentlist = response.data!.data!;

            if (talentlist.isEmpty) {
              return const Center(
                child: CustomTextWidget(
                    text: 'No Artist Found', textColor: Colors.red),
              );
            }
            return AlignedGridView.count(
              padding: const EdgeInsets.symmetric(
                  horizontal: 15.0, vertical: 15.0),
              itemCount: talentlist.length,
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              itemBuilder: (context, index) {
                return TalentItemWidget(datas: talentlist[index]);
              },
            );

          }),
    );
  }
}
