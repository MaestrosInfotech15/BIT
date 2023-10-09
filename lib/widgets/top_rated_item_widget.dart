import 'package:book_indian_talents_app/components/custom_button_widget.dart';
import 'package:book_indian_talents_app/components/custom_text_widget.dart';
import 'package:book_indian_talents_app/components/neumorphism_widget.dart';
import 'package:book_indian_talents_app/helper/constants.dart';
import 'package:book_indian_talents_app/model/talents.dart';
import 'package:book_indian_talents_app/model/top_rated.dart';
import 'package:book_indian_talents_app/screens/artist_plan_screen.dart';
import 'package:book_indian_talents_app/screens/talent_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../components/custom_loader_widget.dart';

class TopRateItemWidget extends StatefulWidget {
  const TopRateItemWidget({
    super.key,required this.topRatedData,
  });
  final TalentData topRatedData;

  @override
  State<TopRateItemWidget> createState() => _TopRateItemWidgetState();
}

class _TopRateItemWidgetState extends State<TopRateItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 15.0, top: 2, bottom: 2),
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, TalentDetailScreen.id,
              arguments: widget.topRatedData);
        },
        child: NeumorphismWidget(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Row(
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
                          text: widget.topRatedData.rating??'',
                          textColor: Theme.of(context).primaryColor,
                          fontSize: 10.0,
                          fontWeight: FontWeight.w600,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 15.0),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: CachedNetworkImage(
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      imageUrl: widget.topRatedData.path!+(widget.topRatedData.img??''),
                      placeholder: (context, url) => const CustomLoaderWidget(),
                      errorWidget: (context, url, error) => Image.asset(
                        '$kLogoPath/boy.png',
                        width: 50,
                        height: 50,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15.0),
                  Image.asset(
                    '$kLogoPath/badge.png',
                    height: 20,
                  )
                ],
              ),
              const SizedBox(height: 5.0),
               CustomTextWidget(
                text: widget.topRatedData.nickName!,
                textColor: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 5.0),
              CustomTextWidget(
                text: widget.topRatedData.category!,
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
                    text: '₹${widget.topRatedData.fee}',
                    textColor: Theme.of(context).primaryColorLight,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              CustomButtonWidget(
                text: 'Book Now',
                onClick: () {
                  Navigator.pushNamed(context, ArtistPlanScreen.id,
                      arguments: widget.topRatedData);
                },
                fontSize: 12.0,
                radius: 25.0,
                width: 120.0,
                height: 35.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}