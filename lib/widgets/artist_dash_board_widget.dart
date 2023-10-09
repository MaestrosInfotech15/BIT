import 'package:flutter/material.dart';

import '../components/custom_text_widget.dart';
import '../model/artist_dash_item.dart';
import '../screens/update_artist_profile_screen.dart';
class ArtistDashboardWidget extends StatefulWidget {
  const ArtistDashboardWidget({
    super.key,
    required this.artistDashItem,
  });
  final ArtistDashItem artistDashItem;
  @override
  State<ArtistDashboardWidget> createState() => _ArtistDashboardWidgetState();
}
class _ArtistDashboardWidgetState extends State<ArtistDashboardWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(widget.artistDashItem.page=='contact'){
          getContactManageDialog();
          return;
        }
        Navigator.pushNamed(context, widget.artistDashItem.page!);
      },
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(4.0),
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: widget.artistDashItem.color!,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    widget.artistDashItem.icon,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextWidget(
                        text: widget.artistDashItem.title!,
                        textColor: Colors.black,
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w700,
                        fontSize: 12.0,
                      ),

                    ],
                  ),
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }
  void getContactManageDialog(){

    showDialog(
        context: context,
        builder: (context) =>
            ContectDetailsWidget())
        .then((value) {});
  }
}