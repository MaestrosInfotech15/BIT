import 'package:book_indian_talents_app/model/authentication.dart';
import 'package:book_indian_talents_app/model/cat_sub_cat.dart';
import 'package:book_indian_talents_app/network/api_helper.dart';
import 'package:flutter/material.dart';

import '../model/artist_dash_item.dart';
import '../model/artist_info.dart';
import '../model/talents.dart';
import '../screens/artist_add_event_videos_screen.dart';
import '../screens/artist_bank_details_screen.dart';
import '../screens/artist_booking_history.dart';
import '../screens/artist_wallet_screen.dart';
import '../screens/show_artist_plan_screen.dart';
import '../screens/update_artist_basic_info_screen.dart';
import '../screens/update_artist_carousel_screen.dart';
import '../screens/update_availability_screen.dart';

class ApiController extends ChangeNotifier {
  Map<String, dynamic> signUpBody = {};

  void setSignUpBody(Map<String, dynamic> body) {
    signUpBody = body;
    notifyListeners();
  }

  String mode1 = '';
  String mode2 = '';

  void setMode1(String mode) {
    mode1 = mode;
    notifyListeners();
  }

  void setMode2(String mode) {
    mode2 = mode;
    notifyListeners();
  }

  String bookingType = '';

  void setPersonalBookingType(String type) {
    bookingType = type;
    notifyListeners();
  }

  List<CategoryList> catSubCatList = [];

  Future<void> getCatSubCat() async {
    catSubCatList.clear();
    CatSubCat catSubCat = await ApiHelper.getCatSubCat();

    if (catSubCat.apiStatus!.toLowerCase() == 'true') {
      catSubCatList = catSubCat.category!;
    }
    notifyListeners();
  }

  void updateSelectedCategory(CategoryList categoryList) {
    int index =
        catSubCatList.indexWhere((element) => element.id == categoryList.id);
    catSubCatList[index] = categoryList;
    notifyListeners();
  }

  List<String> catNameList = [];
  List<String> subCatNameList = [];

  void setUpdateCategory(List<String> catList, List<String> subCatList) {
    catNameList = catList;
    subCatNameList = subCatList;
    notifyListeners();
  }

  List<ArtistDashItem> artistDashList = [];

  Future<void> getDashboard() async {
    artistDashList.clear();
    ArtistInfo artistInfo = await ApiHelper.getArtistBasicInfo();
    if (artistInfo.apiStatus!.toLowerCase() == 'true') {
      ArtistDashItem artistDashItem = ArtistDashItem(

          title: 'Basic Charges',
          subtitle: '₹${artistInfo.data!.fee??'0'}',
          image: 'assets/images/rupess.png',
          color: Colors.blue.shade400,
          icon: Icons.currency_rupee_rounded,
          page: UpdateArtistBasicInfoScreen.id);
      artistDashList.add(artistDashItem);


      artistDashItem = ArtistDashItem(
          title: 'Add Carousel',
          subtitle: '',
          image: 'assets/images/add_carousel.png',
          color: Colors.purple.shade400,
          icon: Icons.view_carousel_rounded,
          page: UpdateArtistCarouselScreen.id);
      artistDashList.add(artistDashItem);

      artistDashItem = ArtistDashItem(
          title: 'All Plans',
          subtitle: '',
          image: 'assets/images/planning.png',
          color: Colors.red.shade400,
          icon: Icons.diamond_rounded,
          page: ShowArtistPlanScreen.id);
      artistDashList.add(artistDashItem);

      artistDashItem = ArtistDashItem(
          title: 'Add Events Photo/Video',
          subtitle: '',
          image: 'assets/images/all_event.png',
          color: Colors.yellow.shade700,
          icon: Icons.add_a_photo,
          page: ArtistAddEventVideoScreen.id);
      artistDashList.add(artistDashItem);

      artistDashItem = ArtistDashItem(
          title: 'Bank Details',
          subtitle: '',
          image: 'assets/images/bank.png',
          color: Colors.orange.shade400,
          icon: Icons.money,
          page: ArtistBankDetailsScreen.id);
      artistDashList.add(artistDashItem);

      artistDashItem = ArtistDashItem(
          title: 'Contact Details',
          subtitle: '',
          image: 'assets/images/call.png',
          color: Colors.brown.shade400,
          icon: Icons.contact_mail,
          page: 'contact');
      artistDashList.add(artistDashItem);

      artistDashItem =  ArtistDashItem(
          title: 'Available Date',
          subtitle: '',
          image: 'assets/images/availability.png',
          color: Colors.pink.shade400,
          icon: Icons.event_note_rounded,
          page: UpdateAvailabilityScreen.id);
      artistDashList.add(artistDashItem);

      artistDashItem =  ArtistDashItem(
          title: 'Withdraw Money',
          subtitle: '',
          image: 'assets/images/availability.png',
          color: Colors.deepPurple.shade400,
          icon: Icons.currency_rupee,
          page: ArtistWalletScreen.id);
      artistDashList.add(artistDashItem);

    }
    notifyListeners();
  }


  List<TalentData>talentDataList=[];
  Future <void> getTalentData(Map<String, dynamic> body)async{
    talentDataList.clear();
    body.remove('sub_name');
    body.remove('cat_name');
  Talent talent=await  ApiHelper.getTalent(body);
  if (talent.apiStatus == 'true'){
    talentDataList=talent.data??[];
  }
  notifyListeners();

  }


  List<TalentData>searchList=[];
  Future<void> searchArtist(Map<String, String> body)async{
    searchList.clear();

    Talent talent=await  ApiHelper.searchArtist(body);
    if (talent.apiStatus == 'true'){
      searchList=talent.data??[];
    }
    notifyListeners();
  }
  void updateSearchStatus(String productName,bool isfav) {
    final productIndex =
    searchList.indexWhere((product) => product.name == productName);
    if (productIndex != -1) {
      searchList[productIndex].favourite = isfav;
      notifyListeners(); // Notify listeners about the change
    }
  }
  void updateFavoriteStatus(String productName,bool isfav) {
    final productIndex =
    talentDataList.indexWhere((product) => product.name == productName);
    if (productIndex != -1) {
      talentDataList[productIndex].favourite = isfav;
      notifyListeners(); // Notify listeners about the change
    }
  }


}
