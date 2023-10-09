import 'package:book_indian_talents_app/model/talents.dart';
import 'package:book_indian_talents_app/screens/artist_plan_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/custom_button_widget.dart';
import '../components/custom_loader_widget.dart';
import '../components/custom_text_widget.dart';
import '../components/neumorphism_widget.dart';
import '../helper/constants.dart';
import '../model/show_favourite.dart';
import '../screens/talent_detail_screen.dart';

class FavoriteItemWidget extends StatefulWidget {
  const FavoriteItemWidget({
    super.key,
    required this.showfavouriteData,
    required this.onTap,
  });

  final ShowFavouriteData showfavouriteData;
  final VoidCallback onTap;

  @override
  State<FavoriteItemWidget> createState() => _FavoriteItemWidgetState();
}

class _FavoriteItemWidgetState extends State<FavoriteItemWidget> {
  @override
  Widget build(BuildContext context) {
    return NeumorphismWidget(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: InkWell(
        onTap: () {
          navigateToScreen(widget.showfavouriteData, 'detail');
        },
        child: Column(
          children: [
            const SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.0)),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 10,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 5.0),
                      CustomTextWidget(
                        text: widget.showfavouriteData.rating ?? '',
                        textColor: Theme.of(context).primaryColor,
                        fontSize: 10.0,
                        fontWeight: FontWeight.w600,
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 15.0),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: CachedNetworkImage(
                      width: 75,
                      height: 75,
                      fit: BoxFit.cover,
                      imageUrl: widget.showfavouriteData.path! +
                          (widget.showfavouriteData.img ?? ''),
                      placeholder: (context, url) => const CustomLoaderWidget(),
                      errorWidget: (context, url, error) => Image.asset(
                        '$kLogoPath/boy.png',
                        width: 75,
                        height: 75,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15.0),
                InkWell(
                  onTap: widget.onTap,
                  child: const Icon(Icons.favorite, color: Colors.red),
                )
              ],
            ),
            const SizedBox(height: 10.0),
            CustomTextWidget(
              text: widget.showfavouriteData.name!,
              textColor: Colors.black,
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 5.0),
            CustomTextWidget(
              text: 'Dancer',
              textColor: Theme.of(context).hintColor,
              fontSize: 12.0,
            ),
            const SizedBox(height: 5.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextWidget(
                  text: 'Starts at',
                  textColor: Theme.of(context).hintColor,
                  fontSize: 12.0,
                ),
                const SizedBox(width: 7.0),
                CustomTextWidget(
                  text: '₹${widget.showfavouriteData.fee}',
                  textColor: Theme.of(context).primaryColorLight,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            const SizedBox(height: 5.0),
            CustomButtonWidget(
              text: 'Book Now',
              onClick: () {
                navigateToScreen(widget.showfavouriteData, 'book');
              },
              fontSize: 12.0,
              radius: 25.0,
              width: 120.0,
              height: 35.0,
            )
          ],
        ),
      ),
    );
  }

  void navigateToScreen(ShowFavouriteData data, String type) {
    TalentData talentData = TalentData(
        email: data.email,
        name: data.name,
        id: data.artistId,
        category: data.category,
        catId: data.catId,
        fee: data.fee,
        img: data.img,
        path: data.path,
        rating: data.rating,
        subcategory: data.subCategory,
        subcatId: data.subcatId);

    if (type == 'detail') {
      Navigator.pushNamed(context, TalentDetailScreen.id,
          arguments: talentData);
    } else {
      Navigator.pushNamed(context, ArtistPlanScreen.id, arguments: talentData);
    }
  }
}
