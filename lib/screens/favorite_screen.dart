import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../components/custom_button_widget.dart';
import '../components/custom_loader_widget.dart';
import '../components/custom_text_widget.dart';
import '../components/neumorphism_widget.dart';
import '../helper/constants.dart';
import '../helper/helper.dart';
import '../helper/size_config.dart';
import '../model/show_favourite.dart';
import '../network/api_helper.dart';
import '../widgets/favorite_Item_widget.dart';

class FavoriteScreen extends StatefulWidget {
  static const String id = 'favorite_screen';

  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late Future<ShowFavourite> favouritefuture;

  Future<ShowFavourite> getFavourite() async {
    return ApiHelper.getFavourite();
  }

  _FavoriteScreenState();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favouritefuture = getFavourite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: CustomTextWidget(
          text: 'Favorite',
          textColor: Theme.of(context).hintColor,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 15.0),
          Expanded(
              child: FutureBuilder<ShowFavourite>(
                  future: favouritefuture,
                  builder: (context, response) {
                    if (response.connectionState == ConnectionState.waiting) {
                      return const CustomLoaderWidget();
                    }
                    if (response.data!.apiStatus!.toLowerCase() == 'false') {
                      return const Center(
                        child: CustomTextWidget(
                            text: 'No Favorite Found', textColor: Colors.red),
                      );
                    }
                    List<ShowFavouriteData> favouriteList =
                        response.data!.data!;
                    if (favouriteList.isEmpty) {
                      return const Center(
                        child: CustomTextWidget(
                            text: 'No Favorite Found', textColor: Colors.red),
                      );
                    }
                    return AlignedGridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      itemCount: favouriteList.length,
                      itemBuilder: (context, index) {
                        return FavoriteItemWidget(
                            showfavouriteData: favouriteList[index],
                          onTap: (){
                              deleteFavorite(favouriteList[index].id!);
                          },
                        );
                      },
                    );
                  })),
        ],
      ),
    );
  }

  void deleteFavorite(String id) {
    Helper.showLoaderDialog(context, message: 'deleting.......');
    Map<String, String> body = {
      'fav_id': id,
    };
    print(body);
    ApiHelper.deleteFavourite(body).then((value) {
      Navigator.pop(context);
      if (value.apiStatus!.toLowerCase() == 'true') {
        Helper.showToastMessage('Successfully Deleted', Colors.green);
        setState(() {
          favouritefuture = getFavourite();
        });
      } else {
        Helper.showToastMessage(value.result!, Colors.red);
      }
    });
  }
}
