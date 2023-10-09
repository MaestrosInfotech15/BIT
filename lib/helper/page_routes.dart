import 'package:book_indian_talents_app/model/categories.dart';
import 'package:book_indian_talents_app/model/show_address.dart';
import 'package:book_indian_talents_app/model/sub_category.dart';
import 'package:book_indian_talents_app/model/talents.dart';
import 'package:book_indian_talents_app/screens/aboutus_screen.dart';
import 'package:book_indian_talents_app/screens/address_book_screen.dart';
import 'package:book_indian_talents_app/screens/all_top_rated_screen.dart';
import 'package:book_indian_talents_app/screens/artist_bank_details_screen.dart';
import 'package:book_indian_talents_app/screens/artist_booking_history.dart';
import 'package:book_indian_talents_app/screens/artist_notification_screen.dart';
import 'package:book_indian_talents_app/screens/artist_plan_screen.dart';
import 'package:book_indian_talents_app/screens/bookind_screen.dart';
import 'package:book_indian_talents_app/screens/cancelled_booking_screen.dart';
import 'package:book_indian_talents_app/screens/chat_list_screen.dart';
import 'package:book_indian_talents_app/screens/chat_screen.dart';
import 'package:book_indian_talents_app/screens/home_screen.dart';
import 'package:book_indian_talents_app/screens/login_screen.dart';
import 'package:book_indian_talents_app/screens/offers_screen.dart';
import 'package:book_indian_talents_app/screens/ongoing_booking_screen.dart';
import 'package:book_indian_talents_app/screens/otp_screen.dart';
import 'package:book_indian_talents_app/screens/post_booking_screen.dart';
import 'package:book_indian_talents_app/screens/register_screen.dart';
import 'package:book_indian_talents_app/screens/search_screen.dart';
import 'package:book_indian_talents_app/screens/sub_category_screen.dart';
import 'package:book_indian_talents_app/screens/talent_detail_screen.dart';
import 'package:book_indian_talents_app/screens/talent_list_screen.dart';
import 'package:book_indian_talents_app/screens/update_artist_basic_info_screen.dart';
import 'package:book_indian_talents_app/screens/update_artist_carousel_screen.dart';
import 'package:book_indian_talents_app/screens/update_artist_profile_screen.dart';
import 'package:book_indian_talents_app/screens/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../screens/add_address_screen.dart';
import '../screens/artist_add_event_videos_screen.dart';
import '../screens/artist_wallet_screen.dart';
import '../screens/choose_language_screen.dart';
import '../screens/confirm_booking_screen.dart';
import '../screens/edit_address_screen.dart';
import '../screens/favorite_screen.dart';
import '../screens/my_rating_screen.dart';
import '../screens/notification_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/show_artist_plan_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/support_booking_screen.dart';
import '../screens/support_chat_screen.dart';
import '../screens/update_availability_screen.dart';
import '../screens/update_profile_screen.dart';
import '../screens/upload_bank_details_screen.dart';
import '../screens/view_artist_profile_screen.dart';
import '../screens/wallet_screen.dart';
import '../screens/welcom_screen.dart';
class PageRoutes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.id:
        return transitionAnimation(const LoginScreen());
      case RegisterScreen.id:
        return transitionAnimation(const RegisterScreen());
      case OTPScreen.id:
        final phone = settings.arguments as Map<String, dynamic>;
        return transitionAnimation(OTPScreen(
          body: phone,
        ));
      case HomeScreen.id:
        return transitionAnimation(const HomeScreen());
      case SubCategoryScreen.id:
        final categories = settings.arguments as CategoryData;
        return transitionAnimation(
            SubCategoryScreen(categoriesData: categories));
      case TalentListScreen.id:
        final categories = settings.arguments as SubCategoryData;
        return transitionAnimation(TalentListScreen(
          data: categories,
        ));
      case TalentDetailScreen.id:
        final data = settings.arguments as TalentData;
        return transitionAnimation(TalentDetailScreen(talentData: data));
      case NotificationScreen.id:
        return transitionAnimation(const NotificationScreen());
      case OngoingBookingScreen.id:
        return transitionAnimation(const OngoingBookingScreen());
      case PastBookingScreen.id:
        return transitionAnimation(const PastBookingScreen());
      case CancelledBookingScreen.id:
        return transitionAnimation(const CancelledBookingScreen());
      case SupportBookingScreen.id:
        return transitionAnimation(const SupportBookingScreen());
      case AddressBookScreen.id:
        return transitionAnimation(const AddressBookScreen());
      case AboutUsScreen.id:
        final type = settings.arguments as String;
        return transitionAnimation(AboutUsScreen(type: type));
      case ChooseLanguageScreen.id:
        return transitionAnimation(const ChooseLanguageScreen());
      case WelcomScreen.id:
        return transitionAnimation(const WelcomScreen());
      case EditAddressScreen.id:
        final addressdata = settings.arguments as ShowAddressData;
        return transitionAnimation(EditAddressScreen(data: addressdata));
      case AddAddressScreen.id:
        return transitionAnimation(const AddAddressScreen());
      case UpdateProfileScreen.id:
        return transitionAnimation(const UpdateProfileScreen());
      case UpdateArtistProfileScreen.id:
        return transitionAnimation(const UpdateArtistProfileScreen());
      case UpdateArtistBasicInfoScreen.id:
        return transitionAnimation(const UpdateArtistBasicInfoScreen());
      case UpdateArtistCarouselScreen.id:
        // final data = settings.arguments as List<String>;
        return transitionAnimation(UpdateArtistCarouselScreen());

      case FavoriteScreen.id:
        return transitionAnimation(const FavoriteScreen());
      case MyRatingScreen.id:
        return transitionAnimation(const MyRatingScreen());
      case ArtistPlanScreen.id:
        final data = settings.arguments as TalentData;
        return transitionAnimation(ArtistPlanScreen(data: data));
      case BookingScreen.id:
        final data = settings.arguments as Map<String, String>;
        return transitionAnimation(BookingScreen(body: data));
      case OffersScreen.id:
        final planId = settings.arguments as String;
        return transitionAnimation(OffersScreen(planId: planId));
      case ArtistBookingHistoryScreen.id:
        return transitionAnimation(const ArtistBookingHistoryScreen());
      case ChatScreen.id:
        final data = settings.arguments as Map<String, dynamic>;
        return transitionAnimation(ChatScreen(data: data));
      case ChatListScreen.id:
        return transitionAnimation(const ChatListScreen());
      case AllTopRatedScreen.id:
        return transitionAnimation(const AllTopRatedScreen());
      case SearchScreen.id:
        return transitionAnimation(const SearchScreen());
      case ArtistNotificationScreen.id:
        return transitionAnimation(const ArtistNotificationScreen());
      case WalletScreen.id:
        return transitionAnimation(const WalletScreen());

      case UploadBankDetailsScreen.id:
        return transitionAnimation(const UploadBankDetailsScreen());

      case SupportChatScreen.id:
        return transitionAnimation(const SupportChatScreen());

      case OnboardingScreen.id:
        return transitionAnimation(const OnboardingScreen());

      case ViewArtistProfileScreen.id:
        return transitionAnimation(const ViewArtistProfileScreen());
      case ArtistWalletScreen.id:
        return transitionAnimation(const ArtistWalletScreen());
      case ShowArtistPlanScreen.id:
        return transitionAnimation(const ShowArtistPlanScreen());
      case ArtistBankDetailsScreen.id:
        return transitionAnimation(const ArtistBankDetailsScreen());

      case ArtistAddEventVideoScreen.id:
        return transitionAnimation(const ArtistAddEventVideoScreen());

      case UpdateAvailabilityScreen.id:
        return transitionAnimation(const UpdateAvailabilityScreen());

        case SplashScreen.id:
        return transitionAnimation(const SplashScreen());

        case ConfirmBookingScreen.id:
          final data = settings.arguments as Map<String, String>;
        return transitionAnimation( ConfirmBookingScreen(body: data));

      default:
        return null;
    }
  }

  static PageTransition transitionAnimation(Widget widget) {
    return PageTransition(child: widget, type: PageTransitionType.rightToLeft);
  }

  static PageTransition bottomToTop(Widget widget) {
    return PageTransition(child: widget, type: PageTransitionType.bottomToTop);
  }
}

