import 'package:book_indian_talents_app/components/custom_button_widget.dart';
import 'package:book_indian_talents_app/components/custom_loader_widget.dart';
import 'package:book_indian_talents_app/components/custom_text_widget.dart';
import 'package:book_indian_talents_app/components/neumorphism_widget.dart';
import 'package:book_indian_talents_app/components/search_input_widget.dart';
import 'package:book_indian_talents_app/helper/constants.dart';
import 'package:book_indian_talents_app/helper/permission_helper.dart';
import 'package:book_indian_talents_app/helper/session_manager.dart';
import 'package:book_indian_talents_app/helper/size_config.dart';
import 'package:book_indian_talents_app/model/home.dart';
import 'package:book_indian_talents_app/model/most_popular.dart';
import 'package:book_indian_talents_app/model/talents.dart';
import 'package:book_indian_talents_app/model/top_rated.dart';
import 'package:book_indian_talents_app/network/api_helper.dart';
import 'package:book_indian_talents_app/screens/all_top_rated_screen.dart';
import 'package:book_indian_talents_app/screens/notification_screen.dart';
import 'package:book_indian_talents_app/screens/search_screen.dart';
import 'package:book_indian_talents_app/widgets/home_item_widget.dart';
import 'package:book_indian_talents_app/widgets/most_popular_widget.dart';
import 'package:book_indian_talents_app/widgets/top_rated_item_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../model/categories.dart';
import '../model/show_profile.dart';
import '../provider/app_controller.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({super.key});



  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  late Future<Category> categoriesfuture;
  late Future<Talent> mostPopularfuture;
  late Future<Talent> topratedfuture;
  bool isProfile = false;
  String imagePath = '';
  String imageUri = '';
  Future<Category> getCategories() async {
    return ApiHelper.getCategories();
  }

  Future<Talent> getMostPopular() async {
    return ApiHelper.getMostPopular();
  }

  Future<Talent> getTopRated() async {
    return ApiHelper.getTopRated();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoriesfuture = getCategories();
    mostPopularfuture = getMostPopular();
    topratedfuture = getTopRated();
    getProfile();

    print(SessionManager.getProfileImage()+'Home');
  }

  void getProfile() {
    setState(() {
      isProfile = true;
    });
    ApiHelper.getProfile().then((value) {
      setState(() {
        isProfile = false;
      });
      if (value.apiStatus!.toLowerCase() == 'true') {
        ShowProfileData showProfileData = value.data!;
        imagePath = showProfileData.images ?? '';
        imageUri = value.path!;

        SessionManager.setProfileImage(imageUri + imagePath);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<AppController>(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: CachedNetworkImage(
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                imageUrl: data.profileImage,

                errorWidget: (context, url, error) => Image.asset(
                  '$kLogoPath/boy.png',
                  width: 75,
                  height: 75,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                  text: 'Hi... ${SessionManager.getUserName()}',
                  textColor: Theme.of(context).hintColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.phone_android_rounded,
                      size: 12,
                      color: Colors.black,
                    ),
                    CustomTextWidget(
                      text: '${SessionManager.getMobile()}',
                      textColor: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 10.0,
                    )
                  ],
                )
              ],
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () async {
                Navigator.pushNamed(context, NotificationScreen.id);
              },
              icon: const Icon(
                Icons.circle_notifications_rounded,
                color: kAppColor,
                size: 35.0,
              ))
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, top: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SearchBarWidget(
                    onClick: () {
                      Navigator.pushNamed(context, SearchScreen.id);
                    },
                    onFilterClick: () {},
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextWidget(
                    text: 'Welcome',
                    textColor: Theme.of(context).primaryColor,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w600,
                  ),
                  CustomTextWidget(
                    text: 'What are you looking for?',
                    textColor: Theme.of(context).hintColor,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 20.0),
                  FutureBuilder<Category>(
                    future: categoriesfuture,
                    builder: (context, response) {
                      if (response.connectionState == ConnectionState.waiting) {
                        return Container();
                      }
                      if (response.data!.apiStatus!.toLowerCase() == 'false') {
                        return Center(
                          child: CustomTextWidget(
                              text: response.data!.result!,
                              textColor: Colors.red),
                        );
                      }
                      List<CategoryData> categorieslist = response.data!.data!;

                      return AlignedGridView.count(
                       shrinkWrap: true,
                      //  physics: const NeverScrollableScrollPhysics(),
                        itemCount: categorieslist.length,
                        crossAxisCount: 3,

                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,

                        itemBuilder: (context, index) {
                          return HomeItemWidget(
                            home: categorieslist[index],
                          );
                        },
                      );

                      /* return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:categorieslist.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            mainAxisExtent: SizeConfig.screenHeight()*15.1),
                        itemBuilder: (context, index) {
                          return HomeItemWidget(
                            home: categorieslist[index],
                          );
                        },
                      );*/
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
              decoration: BoxDecoration(
                color: kAppBarColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[300]!,
                    blurRadius: 10.0,
                    offset: const Offset(4.0, 4.0),
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    blurRadius: 10.0,
                    offset: Offset(-4.0, -4.0),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomTextWidget(
                    text: 'Most Popular',
                    textColor: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 10.0),
                  FutureBuilder<Talent>(
                    future: mostPopularfuture,
                    builder: (context, response) {
                      if (response.connectionState == ConnectionState.waiting) {
                        return  Container();
                      }
                      if (response.data!.apiStatus!.toLowerCase() == 'false') {
                        return const Center(
                          child: CustomTextWidget(
                              text: 'No Most Popular', textColor: Colors.red),
                        );
                      }
                      List<TalentData> mostPopularlist = response.data!.data!;

                      if (mostPopularlist.isEmpty) {
                        return const Center(
                          child: CustomTextWidget(
                              text: 'No Most Popular', textColor: Colors.red),
                        );
                      }
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            mostPopularlist.length,
                            (index) => MostPopularWidget(
                                mostPopularData: mostPopularlist[index]),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 5.0),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  const Expanded(
                    child: CustomTextWidget(
                      text: 'Top Rated Talented',
                      textColor: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AllTopRatedScreen.id);
                    },
                    child: CustomTextWidget(
                      text: 'View All',
                      textColor: Theme.of(context).primaryColor,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            FutureBuilder<Talent>(
                future: topratedfuture,
                builder: (context, response) {
                  if (response.connectionState == ConnectionState.waiting) {
                    return  Container();
                  }
                  if (response.data!.apiStatus!.toLowerCase() == 'false') {
                    return const Center(
                      child: CustomTextWidget(
                          text: 'No Top Rated', textColor: Colors.red),
                    );
                  }
                  List<TalentData> topRatedlist = response.data!.data!;

                  if (topRatedlist.isEmpty) {
                    return const Center(
                      child: CustomTextWidget(
                          text: 'No Top Rated', textColor: Colors.red),
                    );
                  }

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Row(
                      children: List.generate(
                        topRatedlist.length,
                        (index) => TopRateItemWidget(
                            topRatedData: topRatedlist[index]),
                      ),
                    ),
                  );
                }),
            const SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }
}
