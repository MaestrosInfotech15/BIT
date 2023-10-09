import 'package:book_indian_talents_app/helper/session_manager.dart';
import 'package:flutter/material.dart';

class AppController extends ChangeNotifier {
  int bottomSelectedIndex = 0;

  void onBottomSelectedIndex(int index) {
    bottomSelectedIndex = index;
    notifyListeners();
  }

  bool isArtistMode = SessionManager.getArtistMode();

  void setArtistMode(bool mode) {
    isArtistMode = mode;
    SessionManager.setArtistMode(mode);
    notifyListeners();
  }

  String profileImage=SessionManager.getProfileImage();
  void setProfileImage(String imagePath){
    profileImage=imagePath;
    SessionManager.setProfileImage(imagePath);
    notifyListeners();
  }
  Map<String,dynamic>filterBody={

  };
  void setFilter(Map<String,dynamic>body){
    filterBody=body;
    notifyListeners();
  }

}
