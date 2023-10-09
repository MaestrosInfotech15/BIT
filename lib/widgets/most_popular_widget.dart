import 'package:book_indian_talents_app/components/custom_text_widget.dart';
import 'package:book_indian_talents_app/helper/constants.dart';
import 'package:book_indian_talents_app/model/most_popular.dart';
import 'package:book_indian_talents_app/model/talents.dart';
import 'package:book_indian_talents_app/screens/talent_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../components/custom_loader_widget.dart';
class MostPopularWidget extends StatefulWidget {
  const MostPopularWidget({
    super.key,required this.mostPopularData,
  });
  final TalentData mostPopularData;
  @override
  State<MostPopularWidget> createState() => _MostPopularWidgetState();
}
class _MostPopularWidgetState extends State<MostPopularWidget> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, TalentDetailScreen.id,
            arguments: widget.mostPopularData);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CachedNetworkImage(
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                imageUrl: widget.mostPopularData.path!+(widget.mostPopularData.img??''),
                errorWidget: (context, url, error) => Image.asset(
                  '$kLogoPath/logo.png',
                  width: 75,
                  height: 75,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            CustomTextWidget(
              text: widget.mostPopularData.nickName??'',
              textColor: Theme.of(context).primaryColorLight,
              fontWeight: FontWeight.w600,
            )
          ],
        ),
      ),
    );
  }
}