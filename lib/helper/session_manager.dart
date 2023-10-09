import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static SharedPreferences? _preferences;

  static const _isLOGIN = "is_login";
  static const _userID = "user_id";
  static const _userNAME = "user_name";
  static const _userEMAIL = "email";
  static const _loginWith = "login_wth";
  static const _appTheme = "app_theme";
  static const _isWelcome = "is_welcome";
  static const _mobile = 'mobile';
  static const _profileImage = 'profile_image';
  static const _chatId = 'chat_id';
  static const _token = 'token';
  static const _artistMode = 'artist_mode';
  static const _isProfileUpdated = 'profile_update';
  static const _nickname = 'nick_name';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static dynamic setUserLoggedIn(bool isLogin) {
    _preferences!.setBool(_isLOGIN, isLogin);
  }

  static dynamic isLoggedIn() {
    return _preferences!.getBool(_isLOGIN) ?? false;
  }

  static dynamic setUserID(String userId) {
    _preferences!.setString(_userID, userId);
  }

  static dynamic getUserId() {
    return _preferences!.getString(_userID);
  }


  static dynamic setUserName(String userName) {
    _preferences!.setString(_userNAME, userName);
  }

  static dynamic getUserName() {
    return _preferences!.getString(_userNAME);
  }

  static dynamic setNickName(String artistName) {
    return _preferences!.setString(_nickname,artistName);
  }

  static dynamic getNickName() {
    return _preferences!.getString(_nickname);
  }

  static dynamic setUserEmail(String email) {
    _preferences!.setString(_userEMAIL, email);
  }

  static dynamic getUserEmail() {
    return _preferences!.getString(_userEMAIL);
  }

  static dynamic setLoginWith(String loginWith) {
    _preferences!.setString(_loginWith, loginWith);
  }

  static dynamic getLoginWith() {
    return _preferences!.getString(_loginWith);
  }

  static dynamic setAppTheme(String theme) {
    _preferences!.setString(_appTheme, theme);
  }

  static dynamic getAppTheme() {
    return _preferences!.getString(_appTheme) ?? 'Light';
  }

  static dynamic setWelcome(bool welcome) {
    _preferences!.setBool(_isWelcome, welcome);
  }

  static dynamic getWelcome() {
    return _preferences!.getBool(_isWelcome) ?? false;
  }

  static dynamic setMobile(String mobile) {
    _preferences!.setString(_mobile, mobile);
  }

  static dynamic getMobile() {
    return _preferences!.getString(_mobile);
  }

  static dynamic setProfileImage(String profile) {
    return _preferences!.setString(_profileImage, profile);
  }

  static dynamic getProfileImage() {
    return _preferences!.getString(_profileImage) ?? '';
  }

  static dynamic setChatId(String chatId) {
    _preferences!.setString(_chatId, chatId);
  }

  static dynamic getChatId() {
    return _preferences!.getString(_chatId);
  }

  static dynamic setToken(String token) {
    _preferences!.setString(_token, token);
  }

  static dynamic getToken() {
    return _preferences!.getString(_token)??'';
  }

  static dynamic setArtistMode(bool mode) {
    _preferences!.setBool(_artistMode, mode);
  }

  static dynamic getArtistMode() {
    return _preferences!.getBool(_artistMode) ?? false;
  }

  static dynamic setProfileUpdate(String isUpdate){
    _preferences!.setString(_isProfileUpdated, isUpdate);
  }

  static dynamic getProfileUpdate(){
    return _preferences!.getString(_isProfileUpdated) ?? '0';
  }

  static dynamic logout() async{
    _preferences!.remove(_userEMAIL);
    _preferences!.remove(_userNAME);
    _preferences!.remove(_userID);
    _preferences!.remove(_isLOGIN);
    _preferences!.remove(_loginWith);
    // _preferences!.remove(_isWelcome);
    _preferences!.remove(_profileImage);
    _preferences!.remove(_chatId);
   _preferences!.remove(_artistMode);
   _preferences!.remove(_nickname);
   _preferences!.remove(_isProfileUpdated);
  await _preferences!.clear();
  }
}
