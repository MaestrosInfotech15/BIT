import 'package:book_indian_talents_app/components/custom_button_widget.dart';
import 'package:book_indian_talents_app/components/custom_loader_widget.dart';
import 'package:book_indian_talents_app/components/custom_text_widget.dart';
import 'package:book_indian_talents_app/components/neumorphism_widget.dart';
import 'package:book_indian_talents_app/helper/constants.dart';
import 'package:book_indian_talents_app/helper/helper.dart';
import 'package:book_indian_talents_app/helper/session_manager.dart';
import 'package:book_indian_talents_app/model/talents.dart';
import 'package:book_indian_talents_app/network/api_helper.dart';
import 'package:book_indian_talents_app/screens/artist_plan_screen.dart';
import 'package:book_indian_talents_app/screens/talent_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/api_controller.dart';

class TalentItemWidget extends StatefulWidget {
  const TalentItemWidget({super.key, required this.datas});

  final TalentData datas;

  @override
  State<TalentItemWidget> createState() => _TalentItemWidgetState();
}

class _TalentItemWidgetState extends State<TalentItemWidget> {
  bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }
  @override
  Widget build(BuildContext context) {
    return NeumorphismWidget(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, TalentDetailScreen.id,
              arguments: widget.datas);
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
                        text: widget.datas.rating ?? '',
                        textColor: Theme.of(context).primaryColor,
                        fontSize: 10.0,
                        fontWeight: FontWeight.w600,
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 15.0),
                Flexible(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: '${widget.datas.path}${widget.datas.img}',
                      errorWidget: (context, url, error) => const Icon(
                        CupertinoIcons.profile_circled,
                        size: 40,
                      ),
                      width: 60.0,
                      height: 60.0,
                    ),
                  ),
                ),
                const SizedBox(width: 15.0),
                Visibility(
                  visible:widget.datas.favourite  !=null,
                  child: InkWell(
                    onTap: (){
                      if(widget.datas.favourite??false){
                        deleteFavorite(widget.datas.id!);
                      }else{
                        addFavorite();
                      }
                    },
                    child:  Icon(
                      Icons.favorite,
                      size: 20,
                      color: (widget.datas.favourite??false)?Colors.red : Colors.grey, // Change color based on favorite status
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10.0),
            CustomTextWidget(
              text: widget.datas.nickName??'',
              textColor: Colors.black,
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
            ),

            CustomTextWidget(
              text: widget.datas.category ?? '',
              textColor: Theme.of(context).hintColor,
              fontSize: 12.0,
            ),

            Visibility(
              visible: getTalenttype().isNotEmpty,
              child: Container(
                padding: EdgeInsets.only(left: 5,right: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: kAppBarColor
                ),
                child: CustomTextWidget(
                  text: getTalenttype(),
                  textColor:Colors.white,
                  fontSize: 12.0,
                ),
              ),
            ),

            // Row(
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //     CustomTextWidget(
            //       text: 'Starts at',
            //       textColor: Theme.of(context).hintColor,
            //       fontSize: 12.0,
            //     ),
            //     const SizedBox(width: 4.0),
            //     CustomTextWidget(
            //       text: "₹${widget.datas.fee ?? ''}",
            //       textColor: Theme.of(context).primaryColorLight,
            //       fontWeight: FontWeight.w600,
            //     ),
            //   ],
            // ),
            const SizedBox(height: 2.0),
            CustomButtonWidget(
              text: 'Book Now',
              onClick: () {
                Navigator.pushNamed(context, ArtistPlanScreen.id,
                    arguments: widget.datas);
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
  String getTalenttype(){

    if(widget.datas.profileType=='1'){
      return 'Silver';
    }
    if(widget.datas.profileType=='2'){
      return 'Gold';
    }
    if(widget.datas.profileType=='3'){
      return 'Diamond';
    }
    if(widget.datas.profileType=='4'){
      return 'Platinum';
    }

return'';
  }
  void addFavorite() {
    final apidata=Provider.of<ApiController>(context,listen: false);
    Map<String, String> body = {
      'user_id': SessionManager.getUserId(),
      'user_type': SessionManager.getLoginWith(),
      'fav_id': widget.datas.id!,
      'fav_type': 'ARTIST'
    };

    Helper.showLoaderDialog(context, message: 'Adding....');
    ApiHelper.addFavorite(body).then((value) {
      Navigator.pop(context);

      if (value.apiStatus!.toLowerCase() == 'true') {
        setState(() {
          isFavorite=true;
        });
        apidata.updateFavoriteStatus(widget.datas.name!,true);
        apidata.updateSearchStatus(widget.datas.name!,true);
        Helper.showSnackBar(context, 'Added Successfully', Colors.green);

      } else {
        Helper.showSnackBar(context, value.result ?? 'Something went wrong', Colors.red);
      }
    });
  }


  void deleteFavorite(String id) {
    final apidata=Provider.of<ApiController>(context,listen: false);
    Helper.showLoaderDialog(context, message: 'deleting.......');
    Map<String, String> body = {
      'fav_id': id,
      'user_id': SessionManager.getUserId(),
    };
    print(body);
    ApiHelper.favouriteDelete(body).then((value) {
      Navigator.pop(context);
      if (value.apiStatus!.toLowerCase() == 'true') {
        Helper.showToastMessage('Remove', Colors.red);
        setState(() {

        });
        apidata.updateFavoriteStatus(widget.datas.name!,false);
        apidata.updateSearchStatus(widget.datas.name!,false);
      } else {
        Helper.showToastMessage(value.result!, Colors.red);
      }
    });
  }

}
