import 'dart:convert';

import 'package:book_indian_talents_app/helper/session_manager.dart';
import 'package:book_indian_talents_app/model/aboutus.dart';
import 'package:book_indian_talents_app/model/add_address.dart';
import 'package:book_indian_talents_app/model/add_plan.dart';
import 'package:book_indian_talents_app/model/apply_offer.dart';
import 'package:book_indian_talents_app/model/artist_detail.dart';
import 'package:book_indian_talents_app/model/artist_history.dart';
import 'package:book_indian_talents_app/model/artist_info.dart';
import 'package:book_indian_talents_app/model/artist_notification.dart';
import 'package:book_indian_talents_app/model/authentication.dart';
import 'package:book_indian_talents_app/model/bank_details.dart';
import 'package:book_indian_talents_app/model/booking.dart';
import 'package:book_indian_talents_app/model/booking_history.dart';
import 'package:book_indian_talents_app/model/cat_sub_cat.dart';
import 'package:book_indian_talents_app/model/check_login.dart';
import 'package:book_indian_talents_app/model/login.dart';
import 'package:book_indian_talents_app/model/most_popular.dart';
import 'package:book_indian_talents_app/model/offers.dart';
import 'package:book_indian_talents_app/model/refer_code.dart';
import 'package:book_indian_talents_app/model/show_addplan.dart';
import 'package:book_indian_talents_app/model/show_address.dart';
import 'package:book_indian_talents_app/model/show_carousel.dart';
import 'package:book_indian_talents_app/model/show_favourite.dart';
import 'package:book_indian_talents_app/model/show_profile.dart';
import 'package:book_indian_talents_app/model/show_rating.dart';
import 'package:book_indian_talents_app/model/support_chat.dart';
import 'package:book_indian_talents_app/model/top_rated.dart';
import 'package:book_indian_talents_app/model/upload_carousel.dart';
import 'package:book_indian_talents_app/model/user_notification.dart';
import 'package:book_indian_talents_app/model/wallet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';

import '../model/artist_wallet.dart';
import '../model/booking_count.dart';
import '../model/categories.dart';
import '../model/refer_code.dart';
import '../model/show_artist_slote.dart';
import '../model/show_contact_details.dart';
import '../model/sub_category.dart';
import '../model/talents.dart';
import '../model/total_wallet.dart';
import '../model/user_notification.dart';
import '../model/verify_otp.dart';
import '../model/artist_notification.dart';
import '../model/wallet.dart';
import 'api_network.dart';

class ApiHelper {
  static GoogleSignIn googleSign = GoogleSignIn();

  static Future<Authentication> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return Authentication(
          status: false,
          message: 'Google login failed',
          userId: '',
        );
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      return Authentication(
          status: true,
          message: 'Google login success',
          userId: userCredential.user!.email,
          username: userCredential.user!.displayName,
          image: userCredential.user!.photoURL);
    } catch (e) {
      return Authentication(
          status: false, message: e.toString(), userId: '', username: '');
    }
  }

  static Future<bool> logout(String loginType) async {
    try {
      if (loginType.toLowerCase() == 'google') {
        await googleSign.signOut();
      }

      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<Login> login(Map<String, String> body) async {
    final url = Uri.parse(ApiNetwork.login);
    try {
      final response = await post(
        url,
        body: body,
      );

      print(jsonDecode(response.body));

      if (response.statusCode == 200) {
        return Login.fromJson(jsonDecode(response.body));
      } else {
        return Login(apiStatus: 'false');
      }
    } catch (e) {
      return Login(apiStatus: 'false');
    }
  }

  static Future<Verifyotp> verifyOtp(Map<String, String> body) async {
    final url = Uri.parse(ApiNetwork.verifyOTp);
    try {
      final response = await post(
        url,
        body: jsonEncode(body),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        return Verifyotp.fromJson(jsonDecode(response.body));
      } else {
        return Verifyotp(status: false);
      }
    } catch (e) {
      return Verifyotp(status: false);
    }
  }

  static Future<Login> signup(Map<String, String> body) async {
    final url = Uri.parse(ApiNetwork.signUp);
    try {
      final response = await post(
        url,
        body: jsonEncode(body),
        headers: {"Content-Type": "application/json"},
      );

      print(jsonDecode(response.body));

      if (response.statusCode == 200) {
        return Login.fromJson(jsonDecode(response.body));
      } else {
        return Login(apiStatus: 'false');
      }
    } catch (e) {
      return Login(apiStatus: 'false');
    }
  }

  static Future<Login> register(Map<String, dynamic> body) async {
    print(body);
    final url = Uri.parse(ApiNetwork.userRegister);
    try {
      final response = await post(
        url,
        body: body,
      );

      print(jsonDecode(response.body));

      if (response.statusCode == 200) {
        return Login.fromJson(jsonDecode(response.body));
      } else {
        return Login(apiStatus: 'false');
      }
    } catch (e) {
      print('REIGSTER EX $e');
      return Login(apiStatus: 'false');
    }
  }

  static Future<Verifyotp> verifyRegister(Map<String, String> body) async {
    final url = Uri.parse(ApiNetwork.registerVerify);
    try {
      final response = await post(
        url,
        body: jsonEncode(body),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        return Verifyotp.fromJson(jsonDecode(response.body));
      } else {
        return Verifyotp(status: false);
      }
    } catch (e) {
      return Verifyotp(status: false);
    }
  }

  static Future<Category> getCategories() async {
    final url = Uri.parse(ApiNetwork.getCategories);
    try {
      final response = await get(
        url,
        headers: {"Content-Type": "application/json"},
      );
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        return Category.fromJson(jsonDecode(response.body));
      } else {
        return Category(apiStatus: 'false', result: 'data not Found');
      }
    } catch (e) {
      print(e);
      return Category(apiStatus: 'false', result: 'Something went wrong');
    }
  }

  static Future<Talent> getTalent(Map<String, dynamic> body) async {
    print(body);
    final url = Uri.parse(ApiNetwork.getTalent);
    try {
      final response = await post(url, body: body);

      print(jsonDecode(response.body));

      if (response.statusCode == 200) {
        return Talent.fromJson(jsonDecode(response.body));
      } else {
        return Talent(apiStatus: 'false', result: 'data not Found');
      }
    } catch (e) {
      print(e);
      return Talent(apiStatus: 'false', result: 'Something went wrong');
    }
  }

  static Future<SubCategory> getSubcat(Map<String, dynamic> body) async {
    final url = Uri.parse(ApiNetwork.getSubCategories);

    print(body);
    try {
      final response = await post(
        url,
        body: body,
      );
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        return SubCategory.fromJson(jsonDecode(response.body));
      } else {
        return SubCategory(apiStatus: 'false', result: 'data not found');
      }
    } catch (e) {
      print(e);
      return SubCategory(apiStatus: 'false', result: 'Something went wrong');
    }
  }

  static Future<Login> artistRegister(Map<String, dynamic> body) async {
    final url = Uri.parse(ApiNetwork.registerArtist);
    try {
      final response = await post(
        url,
        body: body,
      );

      print(jsonDecode(response.body));

      if (response.statusCode == 200) {
        return Login.fromJson(jsonDecode(response.body));
      } else {
        return Login(apiStatus: 'false');
      }
    } catch (e) {
      return Login(apiStatus: 'false');
    }
  }

  static Future<AddPlan> addPlan(Map<String, dynamic> body) async {
    final url = Uri.parse(ApiNetwork.addPlan);
    try {
      final response = await post(
        url,
        body: body,
      );
      if (response.statusCode == 200) {
        return AddPlan.fromJson(jsonDecode(response.body));
      } else {
        return AddPlan(apiStatus: 'false');
      }
    } catch (e) {
      return AddPlan(apiStatus: 'false');
    }
  }

  static Future<ShowAddPlan> showPlan(String artistId) async {
    final url = Uri.parse(ApiNetwork.showPlan);
    try {
      Map<String, dynamic> body = {
        'id': artistId,
      };
      final response = await post(body: body, url);

      if (response.statusCode == 200) {
        return ShowAddPlan.fromJson(jsonDecode(response.body));
      } else {
        return ShowAddPlan(apiStatus: 'false', result: 'data not Found');
      }
    } catch (e) {
      print(e);
      return ShowAddPlan(apiStatus: 'false', result: 'Something went wrong');
    }
  }

  static Future<ShowProfile> updateProfile(
      Map<String, String> body, String imagePath) async {
    final url = Uri.parse(ApiNetwork.updateProfile);
    try {
      var request = MultipartRequest('POST', url);
      if (imagePath.isNotEmpty) {
        request.files.add(await MultipartFile.fromPath('image', imagePath));
      }

      request.fields.addAll(body);

      StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var resp = await response.stream.bytesToString();
        print(resp);
        return ShowProfile.fromJson(jsonDecode(resp));
      } else {
        return ShowProfile(
            result: 'Check your internet connection', apiStatus: "false");
      }
    } catch (e) {
      return ShowProfile(apiStatus: 'false');
    }
  }

  static Future<ShowProfile> getProfile() async {
    final url = Uri.parse(ApiNetwork.getProfile);
    try {
      print(SessionManager.getUserId());
      Map<String, dynamic> body = {
        'id': SessionManager.getUserId(),
        'type': SessionManager.getLoginWith()
      };
      print(body);

      final response = await post(body: body, url);
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        return ShowProfile.fromJson(jsonDecode(response.body));
      } else {
        return ShowProfile(apiStatus: 'false', result: 'data not Found');
      }
    } catch (e) {
      print(e);
      return ShowProfile(apiStatus: 'false', result: 'Something went wrong');
    }
  }

  static Future<Login> deleteArtistPlan(Map<String, String> body) async {
    final url = Uri.parse(ApiNetwork.deleteArtistPlan);
    try {
      final response = await post(
        url,
        body: body,
      );

      print(jsonDecode(response.body));

      if (response.statusCode == 200) {
        return Login.fromJson(jsonDecode(response.body));
      } else {
        return Login(apiStatus: 'false');
      }
    } catch (e) {
      return Login(apiStatus: 'false');
    }
  }

  static Future<ArtistInfo> getArtistBasicInfo() async {
    final url = Uri.parse(ApiNetwork.artistBasicInfo);
    try {
      Map<String, dynamic> body = {'id': SessionManager.getUserId()};

      final response = await post(body: body, url);
      if (response.statusCode == 200) {
        return ArtistInfo.fromJson(jsonDecode(response.body));
      } else {
        return ArtistInfo(apiStatus: 'false', result: 'data not Found');
      }
    } catch (e) {
      print(e);
      return ArtistInfo(apiStatus: 'false', result: 'Something went wrong');
    }
  }

  static Future<Login> updateArtistBasicInfo(Map<String, String> body) async {
    final url = Uri.parse(ApiNetwork.updateArtistBasicInfo);
    try {
      final response = await post(url, body: body);

      print(body);

      if (response.statusCode == 200) {
        return Login.fromJson(jsonDecode(response.body));
      } else {
        return Login(apiStatus: 'false');
      }
    } catch (e) {
      print(e);
      return Login(apiStatus: 'false');
    }
  }

  static Future<UploadCarousel> uploadCarouselImage(String imagePath) async {
    final url = Uri.parse(ApiNetwork.uploadCarouselImage);
    try {
      var request = MultipartRequest('POST', url);
      if (imagePath.isNotEmpty) {
        request.files.add(await MultipartFile.fromPath('images', imagePath));
      }

      StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var resp = await response.stream.bytesToString();
        return UploadCarousel.fromJson(jsonDecode(resp));
      } else {
        return UploadCarousel(apiStatus: "false");
      }
    } catch (e) {
      return UploadCarousel(apiStatus: 'false');
    }
  }

  static Future<Login> submitCarouselImages(Map<String, String> body) async {
    final url = Uri.parse(ApiNetwork.submitCarouselImage);
    try {
      final response = await post(url, body: body);

      print(jsonDecode(response.body));

      if (response.statusCode == 200) {
        return Login.fromJson(jsonDecode(response.body));
      } else {
        return Login(apiStatus: 'false');
      }
    } catch (e) {
      return Login(apiStatus: 'false');
    }
  }

  static Future<ShowCarousel> getCarouselImages() async {
    final url = Uri.parse(ApiNetwork.showCarouselImage);
    try {
      Map<String, dynamic> body = {'id': SessionManager.getUserId()};

      final response = await post(body: body, url);
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        return ShowCarousel.fromJson(jsonDecode(response.body));
      } else {
        return ShowCarousel(apiStatus: 'false', result: 'data not Found');
      }
    } catch (e) {
      print(e);
      return ShowCarousel(apiStatus: 'false', result: 'Something went wrong');
    }
  }

  static Future<ArtistDetail> getArtistDetail(String artistId) async {
    final url = Uri.parse(ApiNetwork.showArtistDetail);
    try {
      Map<String, dynamic> body = {
        'id': artistId,
        'user_id': SessionManager.getUserId(),
      };

      final response = await post(body: body, url);

      if (response.statusCode == 200) {
        return ArtistDetail.fromJson(jsonDecode(response.body));
      } else {
        return ArtistDetail(apiStatus: 'false', result: 'data not Found');
      }
    } catch (e) {
      print(e);
      return ArtistDetail(apiStatus: 'false', result: 'Something went wrong');
    }
  }

  static Future<Login> addEventImageVideos(
      Map<String, String> body, String imagePath) async {
    final url = Uri.parse(ApiNetwork.addEventImageVideo);
    try {
      var request = MultipartRequest('POST', url);
      if (imagePath.isNotEmpty) {
        request.files.add(await MultipartFile.fromPath('images', imagePath));
      }

      request.fields.addAll(body);

      StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var resp = await response.stream.bytesToString();
        return Login.fromJson(jsonDecode(resp));
      } else {
        return Login(
            result: 'Check your internet connection', apiStatus: "false");
      }
    } catch (e) {
      return Login(apiStatus: 'false');
    }
  }

  static Future<AboutUs> getAboutus() async {
    final url = Uri.parse(ApiNetwork.aboutus);
    try {
      final response = await get(
        url,
        headers: {"Content-Type": "application/json"},
      );
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        return AboutUs.fromJson(jsonDecode(response.body));
      } else {
        return AboutUs(apiStatus: 'false', result: 'data not Found');
      }
    } catch (e) {
      print(e);
      return AboutUs(apiStatus: 'false', result: 'Something want Wrong');
    }
  }

  static Future<AboutUs> getTermsServices() async {
    final url = Uri.parse(ApiNetwork.termServices);
    try {
      final response = await get(
        url,
        headers: {"Content-Type": "application/json"},
      );
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        return AboutUs.fromJson(jsonDecode(response.body));
      } else {
        return AboutUs(apiStatus: 'false', result: 'data not Found');
      }
    } catch (e) {
      print(e);
      return AboutUs(apiStatus: 'false', result: 'Something want Wrong');
    }
  }

  static Future<AboutUs> getprivacyPolicy() async {
    final url = Uri.parse(ApiNetwork.privacyPolicy);
    try {
      final response = await get(
        url,
        headers: {"Content-Type": "application/json"},
      );
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        return AboutUs.fromJson(jsonDecode(response.body));
      } else {
        return AboutUs(apiStatus: 'false', result: 'data not Found');
      }
    } catch (e) {
      print(e);
      return AboutUs(apiStatus: 'false', result: 'Something want Wrong');
    }
  }

  static Future<AddAddress> addAddress(Map<String, dynamic> body) async {
    final url = Uri.parse(ApiNetwork.addAddress);
    try {
      final response = await post(
        url,
        body: body,
      );
      if (response.statusCode == 200) {
        return AddAddress.fromJson(jsonDecode(response.body));
      } else {
        return AddAddress(apiStatus: 'false');
      }
    } catch (e) {
      return AddAddress(apiStatus: 'false');
    }
  }

  static Future<AddAddress> updateAddress(Map<String, dynamic> body) async {
    final url = Uri.parse(ApiNetwork.updateAddress);
    try {
      final response = await post(
        url,
        body: body,
      );
      if (response.statusCode == 200) {
        return AddAddress.fromJson(jsonDecode(response.body));
      } else {
        return AddAddress(apiStatus: 'false');
      }
    } catch (e) {
      return AddAddress(apiStatus: 'false');
    }
  }

  static Future<AddAddress> updateArtistPlans(Map<String, dynamic> body) async {
    final url = Uri.parse(ApiNetwork.updateArtistPlans);
    try {
      final response = await post(
        url,
        body: body,
      );
      if (response.statusCode == 200) {
        return AddAddress.fromJson(jsonDecode(response.body));
      } else {
        return AddAddress(apiStatus: 'false');
      }
    } catch (e) {
      return AddAddress(apiStatus: 'false');
    }
  }

  static Future<Login> deleteAddress(Map<String, String> body) async {
    final url = Uri.parse(ApiNetwork.deleteAddress);
    try {
      final response = await post(
        url,
        body: body,
      );
      if (response.statusCode == 200) {
        return Login.fromJson(jsonDecode(response.body));
      } else {
        return Login(apiStatus: 'false');
      }
    } catch (e) {
      return Login(apiStatus: 'false');
    }
  }

  static Future<ShowAddress> showAddress() async {
    final url = Uri.parse(ApiNetwork.showAddress);
    try {
      Map<String, dynamic> body = {
        'id': SessionManager.getUserId(),
        'type': SessionManager.getLoginWith(),
      };
      final response = await post(body: body, url);
      if (response.statusCode == 200) {
        return ShowAddress.fromJson(jsonDecode(response.body));
      } else {
        return ShowAddress(apiStatus: 'false', result: 'data not Found');
      }
    } catch (e) {
      print(e);
      return ShowAddress(apiStatus: 'false', result: 'Something want Wrong');
    }
  }

  static Future<Booking> booking(Map<String, String> body) async {
    final url = Uri.parse(ApiNetwork.booking);
    try {
      final response = await post(url, body: body);

      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        return Booking.fromJson(jsonDecode(response.body));
      } else {
        return Booking(apiStatus: 'false');
      }
    } catch (e) {
      return Booking(apiStatus: 'false');
    }
  }

  static Future<Booking> bookingUpdate(Map<String, String> body) async {
    final url = Uri.parse(ApiNetwork.updateBooking);
    try {
      final response = await post(url, body: body);
      if (response.statusCode == 200) {
        return Booking.fromJson(jsonDecode(response.body));
      } else {
        return Booking(apiStatus: 'false');
      }
    } catch (e) {
      return Booking(apiStatus: 'false');
    }
  }

  static Future<Offers> showOffers() async {
    final url = Uri.parse(ApiNetwork.offers);
    try {
      final response = await post(url);
      if (response.statusCode == 200) {
        return Offers.fromJson(jsonDecode(response.body));
      } else {
        return Offers(apiStatus: 'false');
      }
    } catch (e) {
      return Offers(apiStatus: 'false');
    }
  }

  static Future<ApplyOffer> applyOffer(Map<String, String> body) async {
    final url = Uri.parse(ApiNetwork.applyOffers);
    try {
      final response = await post(url, body: body);
      if (response.statusCode == 200) {
        return ApplyOffer.fromJson(jsonDecode(response.body));
      } else {
        return ApplyOffer(apiStatus: 'false');
      }
    } catch (e) {
      return ApplyOffer(apiStatus: 'false');
    }
  }

  static Future<BookingHistory> getHistory(String statusType) async {
    final url = Uri.parse(ApiNetwork.history);
    try {
      Map<String, dynamic> body = {
        'id': SessionManager.getUserId(),
        'booking_status': statusType,
        'type': SessionManager.getLoginWith()
      };
      print(body);
      final response = await post(body: body, url);
      if (response.statusCode == 200) {
        return BookingHistory.fromJson(jsonDecode(response.body));
      } else {
        return BookingHistory(apiStatus: 'false');
      }
    } catch (e) {
      return BookingHistory(apiStatus: 'false');
    }
  }

  static Future<ShowFavourite> getFavourite() async {
    final url = Uri.parse(ApiNetwork.showfavourite);
    try {
      Map<String, dynamic> body = {
        'user_id': SessionManager.getUserId(),
        'user_type': SessionManager.getLoginWith()
      };
      final response = await post(body: body, url);
      if (response.statusCode == 200) {
        return ShowFavourite.fromJson(jsonDecode(response.body));
      } else {
        return ShowFavourite(apiStatus: 'false');
      }
    } catch (e) {
      return ShowFavourite(apiStatus: 'false');
    }
  }

  static Future<Login> addFavorite(Map<String, String> body) async {
    final url = Uri.parse(ApiNetwork.addFavorite);
    try {
      final response = await post(url, body: body);
      if (response.statusCode == 200) {
        return Login.fromJson(jsonDecode(response.body));
      } else {
        return Login(apiStatus: 'false');
      }
    } catch (e) {
      return Login(apiStatus: 'false');
    }
  }

  static Future<ShowRating> getRating() async {
    final url = Uri.parse(ApiNetwork.viewReview);
    try {
      Map<String, dynamic> body = {
        'id': SessionManager.getUserId(),
        'type': SessionManager.getLoginWith()
      };
      final response = await post(body: body, url);
      if (response.statusCode == 200) {
        return ShowRating.fromJson(jsonDecode(response.body));
      } else {
        return ShowRating(apiStatus: 'false');
      }
    } catch (e) {
      return ShowRating(apiStatus: 'false');
    }
  }

  static Future<Talent> getMostPopular() async {
    final url = Uri.parse(ApiNetwork.mostPopular);
    try {
      final response = await post(url);
      if (response.statusCode == 200) {
        return Talent.fromJson(jsonDecode(response.body));
      } else {
        return Talent(apiStatus: 'false');
      }
    } catch (e) {
      return Talent(apiStatus: 'false');
    }
  }

  static Future<Talent> getTopRated() async {
    final url = Uri.parse(ApiNetwork.topRated);
    try {
      final response = await post(url);
      if (response.statusCode == 200) {
        return Talent.fromJson(jsonDecode(response.body));
      } else {
        return Talent(apiStatus: 'false');
      }
    } catch (e) {
      return Talent(apiStatus: 'false');
    }
  }

  static Future<Login> deleteFavourite(Map<String, String> body) async {
    final url = Uri.parse(ApiNetwork.deleteFavourite);
    try {
      final response = await post(
        url,
        body: body,
      );
      if (response.statusCode == 200) {
        return Login.fromJson(jsonDecode(response.body));
      } else {
        return Login(apiStatus: 'false');
      }
    } catch (e) {
      return Login(apiStatus: 'false');
    }
  }

  static Future<Login> favouriteDelete(Map<String, String> body) async {
    final url = Uri.parse(ApiNetwork.favouriteDelete);
    try {
      final response = await post(
        url,
        body: body,
      );
      if (response.statusCode == 200) {
        return Login.fromJson(jsonDecode(response.body));
      } else {
        return Login(apiStatus: 'false');
      }
    } catch (e) {
      return Login(apiStatus: 'false');
    }
  }

  static Future<Login> deleteArtistVidio(Map<String, String> body) async {
    final url = Uri.parse(ApiNetwork.deleteArtistVidio);
    try {
      final response = await post(
        url,
        body: body,
      );
      if (response.statusCode == 200) {
        return Login.fromJson(jsonDecode(response.body));
      } else {
        return Login(apiStatus: 'false');
      }
    } catch (e) {
      return Login(apiStatus: 'false');
    }
  }

  static Future<Login> cancelBooking(Map<String, String> body) async {
    final url = Uri.parse(ApiNetwork.cancelBooking);
    try {
      final response = await post(
        url,
        body: body,
      );
      if (response.statusCode == 200) {
        return Login.fromJson(jsonDecode(response.body));
      } else {
        return Login(apiStatus: 'false');
      }
    } catch (e) {
      return Login(apiStatus: 'false');
    }
  }

  static Future<ArtistHistory> artistBooking(String statusType) async {
    final url = Uri.parse(ApiNetwork.artistBooking);
    try {
      Map<String, dynamic> body = {
        'artist_id': SessionManager.getUserId(),
        'booking_type': statusType
      };
      final response = await post(body: body, url);
      if (response.statusCode == 200) {
        return ArtistHistory.fromJson(jsonDecode(response.body));
      } else {
        return ArtistHistory(apiStatus: 'false');
      }
    } catch (e) {
      return ArtistHistory(apiStatus: 'false');
    }
  }

  static Future<Talent> searchArtist(Map<String, String> body) async {
    final url = Uri.parse(ApiNetwork.searchArtist);
    try {
      final response = await post(url, body: body);
      if (response.statusCode == 200) {
        return Talent.fromJson(jsonDecode(response.body));
      } else {
        return Talent(apiStatus: 'false');
      }
    } catch (e) {
      return Talent(apiStatus: 'false');
    }
  }

  static Future<CheckLogin> checkLogin(Map<String, String> body) async {
    final url = Uri.parse(ApiNetwork.checkLogin);
    try {
      final response = await post(url, body: body);
      if (response.statusCode == 200) {
        return CheckLogin.fromJson(jsonDecode(response.body));
      } else {
        return CheckLogin(apiStatus: 'false');
      }
    } catch (e) {
      return CheckLogin(apiStatus: 'false');
    }
  }

  static Future<ReferCode> getRefer() async {
    final url = Uri.parse(ApiNetwork.show_refercode);
    try {
      Map<String, dynamic> body = {
        'id': SessionManager.getUserId(),
        'type': SessionManager.getLoginWith()
      };
      final response = await post(body: body, url);
      if (response.statusCode == 200) {
        return ReferCode.fromJson(jsonDecode(response.body));
      } else {
        return ReferCode(apiStatus: 'false');
      }
    } catch (e) {
      return ReferCode(apiStatus: 'false');
    }
  }

  static Future<UserNotification> getNotification() async {
    final url = Uri.parse(ApiNetwork.usernotification);
    try {
      Map<String, dynamic> body = {
        'id': SessionManager.getUserId(),
        'type': SessionManager.getLoginWith()
      };
      final response = await post(body: body, url);
      if (response.statusCode == 200) {
        return UserNotification.fromJson(jsonDecode(response.body));
      } else {
        return UserNotification(apiStatus: 'false');
      }
    } catch (e) {
      return UserNotification(apiStatus: 'false');
    }
  }

  static Future<ArtistNotification> getArtistNotfi() async {
    final url = Uri.parse(ApiNetwork.artistNotification);
    try {
      Map<String, dynamic> body = {
        'artist_id': SessionManager.getUserId(),
      };
      final response = await post(body: body, url);
      if (response.statusCode == 200) {
        return ArtistNotification.fromJson(jsonDecode(response.body));
      } else {
        return ArtistNotification(apiStatus: 'false');
      }
    } catch (e) {
      return ArtistNotification(apiStatus: 'false');
    }
  }

  static Future<CatSubCat> getCatSubCat() async {
    final url = Uri.parse(ApiNetwork.catSubCat);
    try {
      final response = await get(url);
      if (response.statusCode == 200) {
        return CatSubCat.fromJson(jsonDecode(response.body));
      } else {
        return CatSubCat(apiStatus: 'false');
      }
    } catch (e) {
      return CatSubCat(apiStatus: 'false');
    }
  }

  static Future<Wallet> getWallet() async {
    final url = Uri.parse(ApiNetwork.getWallet);
    try {
      Map<String, dynamic> body = {
        'id': SessionManager.getUserId(),
        'type': SessionManager.getLoginWith()
      };
      final response = await post(body: body, url);
      if (response.statusCode == 200) {
        return Wallet.fromJson(jsonDecode(response.body));
      } else {
        return Wallet(apiStatus: 'false');
      }
    } catch (e) {
      return Wallet(apiStatus: 'false');
    }
  }

  static Future<BankDetails> getbankDetails() async {
    final url = Uri.parse(ApiNetwork.viewBankDetails);
    try {
      Map<String, dynamic> body = {
        'artist_id': SessionManager.getUserId(),
      };
      final response = await post(body: body, url);
      if (response.statusCode == 200) {
        return BankDetails.fromJson(jsonDecode(response.body));
      } else {
        return BankDetails(apiStatus: 'false');
      }
    } catch (e) {
      return BankDetails(apiStatus: 'false');
    }
  }

  static Future<Login> add_bankdetails(
      Map<String, String> body, String imagePath) async {
    final url = Uri.parse(ApiNetwork.addBankDetails);
    try {
      var request = MultipartRequest('POST', url);
      if (imagePath.isNotEmpty) {
        request.files.add(await MultipartFile.fromPath('image', imagePath));
      }

      request.fields.addAll(body);

      StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var resp = await response.stream.bytesToString();
        print(jsonDecode(resp));
        return Login.fromJson(jsonDecode(resp));
      } else {
        return Login(
            result: 'Check your internet connection', apiStatus: "false");
      }
    } catch (e) {
      print(e);
      return Login(apiStatus: 'false');
    }
  }

  static Future<Login> deleteBankdetails(Map<String, String> body) async {
    final url = Uri.parse(ApiNetwork.deleteBankdetails);
    try {
      final response = await post(
        url,
        body: body,
      );

      print(jsonDecode(response.body));

      if (response.statusCode == 200) {
        return Login.fromJson(jsonDecode(response.body));
      } else {
        return Login(apiStatus: 'false');
      }
    } catch (e) {
      return Login(apiStatus: 'false');
    }
  }

  static Future<SupportChat> getSupportChat(Map<String, dynamic> body) async {
    final url = Uri.parse(ApiNetwork.supportChat);
    try {
      final response = await post(body: body, url);
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        return SupportChat.fromJson(jsonDecode(response.body));
      } else {
        return SupportChat(apiStatus: 'false');
      }
    } catch (e) {
      return SupportChat(apiStatus: 'false');
    }
  }

  static Future<Login> addReview(
      Map<String, String> body, String imagePath) async {
    final url = Uri.parse(ApiNetwork.addReview);
    try {
      var request = MultipartRequest('POST', url);
      if (imagePath.isNotEmpty) {
        request.files.add(await MultipartFile.fromPath('image', imagePath));
      }

      request.fields.addAll(body);

      StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var resp = await response.stream.bytesToString();
        print(jsonDecode(resp));
        return Login.fromJson(jsonDecode(resp));
      } else {
        return Login(
            result: 'Check your internet connection', apiStatus: "false");
      }
    } catch (e) {
      print(e);
      return Login(apiStatus: 'false');
    }
  }

  static Future<Login> registrationCheck(String contact) async {
    final url = Uri.parse(ApiNetwork.check_registration);
    try {
      Map<String, dynamic> body = {
        'contact': contact,
      };
      final response = await post(body: body, url);

      if (response.statusCode == 200) {
        return Login.fromJson(jsonDecode(response.body));
      } else {
        return Login(apiStatus: 'false', result: 'data not Found');
      }
    } catch (e) {
      print(e);
      return Login(apiStatus: 'false', result: 'Something went wrong');
    }
  }

  static Future<Login> deleteuser() async {
    final url = Uri.parse(ApiNetwork.deleteuser);
    try {
      Map<String, dynamic> body = {
        'user_id': SessionManager.getUserId(),
        'user_type': SessionManager.getLoginWith(),
      };
      final response = await post(body: body, url);

      if (response.statusCode == 200) {
        return Login.fromJson(jsonDecode(response.body));
      } else {
        return Login(apiStatus: 'false', result: 'data not Found');
      }
    } catch (e) {
      print(e);
      return Login(apiStatus: 'false', result: 'Something went wrong');
    }
  }

  static Future<TotalWallet> totalamount() async {
    final url = Uri.parse(ApiNetwork.totalwallet);
    try {
      Map<String, dynamic> body = {
        'artist_id': SessionManager.getUserId(),
        'user_type': SessionManager.getLoginWith(),
      };
      final response = await post(body: body, url);

      if (response.statusCode == 200) {
        return TotalWallet.fromJson(jsonDecode(response.body));
      } else {
        return TotalWallet(apiStatus: 'false');
      }
    } catch (e) {
      print(e);
      return TotalWallet(apiStatus: 'false');
    }
  }

  static Future<ArtistWallet> getArtisrwallet() async {
    final url = Uri.parse(ApiNetwork.artistWallet);
    try {
      Map<String, dynamic> body = {
        'artist_id': SessionManager.getUserId(),
      };
      final response = await post(body: body, url);
      if (response.statusCode == 200) {
        return ArtistWallet.fromJson(jsonDecode(response.body));
      } else {
        return ArtistWallet(apiStatus: 'false');
      }
    } catch (e) {
      return ArtistWallet(apiStatus: 'false');
    }
  }

  static Future<Login> walletWithDraw(Map<String, dynamic> body) async {
    final url = Uri.parse(ApiNetwork.WalletWithdraw);
    try {
      final response = await post(
        url,
        body: body,
      );
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        return Login.fromJson(jsonDecode(response.body));
      } else {
        return Login(apiStatus: 'false');
      }
    } catch (e) {
      print(e);
      return Login(apiStatus: 'false');
    }
  }

  static Future<Login> AddartistSlote(Map<String, dynamic> body) async {
    final url = Uri.parse(ApiNetwork.AddartistSlote);
    try {
      final response = await post(
        url,
        body: body,
      );
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        return Login.fromJson(jsonDecode(response.body));
      } else {
        return Login(apiStatus: 'false');
      }
    } catch (e) {
      print(e);
      return Login(apiStatus: 'false');
    }
  }

  static Future<ShowartistSlote> getShowartistSlote(String artistId) async {
    final url = Uri.parse(ApiNetwork.showArtistSlote);
    try {
      Map<String, dynamic> body = {
        'artist_id': artistId,
      };
      final response = await post(body: body, url);
      if (response.statusCode == 200) {
        return ShowartistSlote.fromJson(jsonDecode(response.body));
      } else {
        return ShowartistSlote(apiStatus: 'false');
      }
    } catch (e) {
      return ShowartistSlote(apiStatus: 'false');
    }
  }

  static Future<Login> addContect(Map<String, dynamic> body) async {
    final url = Uri.parse(ApiNetwork.addContactDetails);
    try {
      final response = await post(
        url,
        body: body,
      );
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        return Login.fromJson(jsonDecode(response.body));
      } else {
        return Login(apiStatus: 'false');
      }
    } catch (e) {
      print(e);
      return Login(apiStatus: 'false');
    }
  }

  static Future<ShowContactDetails> getcontact() async {
    final url = Uri.parse(ApiNetwork.showContactDetails);
    try {
      Map<String, dynamic> body = {
        'user_id': SessionManager.getUserId(),
        'user_type': SessionManager.getLoginWith(),
      };
      final response = await post(body: body, url);
      if (response.statusCode == 200) {
        return ShowContactDetails.fromJson(jsonDecode(response.body));
      } else {
        return ShowContactDetails(apiStatus: 'false');
      }
    } catch (e) {
      return ShowContactDetails(apiStatus: 'false');
    }
  }

  static Future<BookingCount> bookingCount() async {
    final url = Uri.parse(ApiNetwork.upcomingBookingCount);
    try {
      Map<String, dynamic> body = {
        'id': SessionManager.getUserId(),
        'type': SessionManager.getLoginWith(),
        'booking_status': 'UPCOMING',
      };
      final response = await post(body: body, url);

      if (response.statusCode == 200) {
        return BookingCount.fromJson(jsonDecode(response.body));
      } else {
        return BookingCount(status: false);
      }
    } catch (e) {
      print(e);
      return BookingCount(status: false);
    }
  }
}
