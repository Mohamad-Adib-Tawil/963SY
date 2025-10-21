import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ar'),
    Locale('fr'),
    Locale('es'),
    Locale('tr'),
    Locale('zh'),
    Locale('it'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Tourism App'**
  String get appTitle;

  /// No description provided for @menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get aboutApp;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @findPlaces.
  ///
  /// In en, this message translates to:
  /// **'Find places, landmarks or activities:'**
  String get findPlaces;

  /// No description provided for @searchHere.
  ///
  /// In en, this message translates to:
  /// **'Search here...'**
  String get searchHere;

  /// No description provided for @searchResults.
  ///
  /// In en, this message translates to:
  /// **'Search results will appear here.'**
  String get searchResults;

  /// No description provided for @tourismSites.
  ///
  /// In en, this message translates to:
  /// **'Tourism sites'**
  String get tourismSites;

  /// No description provided for @historicalSites.
  ///
  /// In en, this message translates to:
  /// **'Historical sites'**
  String get historicalSites;

  /// No description provided for @religiousSites.
  ///
  /// In en, this message translates to:
  /// **'Religious sites'**
  String get religiousSites;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @governorates.
  ///
  /// In en, this message translates to:
  /// **'Governorates'**
  String get governorates;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @subject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get subject;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @submitInformation.
  ///
  /// In en, this message translates to:
  /// **'Submit Information'**
  String get submitInformation;

  /// No description provided for @messageSent.
  ///
  /// In en, this message translates to:
  /// **'Message sent successfully!'**
  String get messageSent;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @french.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get french;

  /// No description provided for @languageSelected.
  ///
  /// In en, this message translates to:
  /// **'Language selected: @language'**
  String get languageSelected;

  /// No description provided for @aboutUsTitle.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get aboutUsTitle;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @decline.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get decline;

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Tourism App'**
  String get welcomeMessage;

  /// No description provided for @exploreMessage.
  ///
  /// In en, this message translates to:
  /// **'Explore beautiful places and attractions'**
  String get exploreMessage;

  /// No description provided for @noResults.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResults;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error occurred'**
  String get error;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @favorite.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get favorite;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @openingHours.
  ///
  /// In en, this message translates to:
  /// **'Opening Hours'**
  String get openingHours;

  /// No description provided for @closed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get closed;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @free.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get free;

  /// No description provided for @directions.
  ///
  /// In en, this message translates to:
  /// **'Get Directions'**
  String get directions;

  /// No description provided for @website.
  ///
  /// In en, this message translates to:
  /// **'Visit Website'**
  String get website;

  /// No description provided for @call.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get call;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// No description provided for @writeReview.
  ///
  /// In en, this message translates to:
  /// **'Write a Review'**
  String get writeReview;

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @photos.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get photos;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @showMore.
  ///
  /// In en, this message translates to:
  /// **'Show More'**
  String get showMore;

  /// No description provided for @showLess.
  ///
  /// In en, this message translates to:
  /// **'Show Less'**
  String get showLess;

  /// No description provided for @readMore.
  ///
  /// In en, this message translates to:
  /// **'Read More'**
  String get readMore;

  /// No description provided for @readLess.
  ///
  /// In en, this message translates to:
  /// **'Read Less'**
  String get readLess;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get aboutUs;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @map.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get map;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @whoWeAre.
  ///
  /// In en, this message translates to:
  /// **'Who We Are'**
  String get whoWeAre;

  /// No description provided for @whatIs963SY.
  ///
  /// In en, this message translates to:
  /// **'What is 963SY?'**
  String get whatIs963SY;

  /// No description provided for @ourMission.
  ///
  /// In en, this message translates to:
  /// **'Our Mission'**
  String get ourMission;

  /// No description provided for @whoWeAreContent.
  ///
  /// In en, this message translates to:
  /// **'Artfly Foundation is a pioneer in innovation and documentation, specializing in aerial photography using drone technology.'**
  String get whoWeAreContent;

  /// No description provided for @whatIs963SYContent.
  ///
  /// In en, this message translates to:
  /// **'963SY is a comprehensive mobile platform that makes tourism accessible to everyone, regardless of physical or linguistic barriers.'**
  String get whatIs963SYContent;

  /// No description provided for @ourMissionContent.
  ///
  /// In en, this message translates to:
  /// **'We aim to promote Syria\'s rich history, heritage, and tourist attractions through curated content, photos, and videos that highlight the country\'s true beauty and cultural significance.'**
  String get ourMissionContent;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search for places, landmarks, or activities...'**
  String get searchHint;

  /// No description provided for @government.
  ///
  /// In en, this message translates to:
  /// **'Government'**
  String get government;

  /// No description provided for @selectGovernorate.
  ///
  /// In en, this message translates to:
  /// **'Select Governorate'**
  String get selectGovernorate;

  /// No description provided for @selectCategory.
  ///
  /// In en, this message translates to:
  /// **'Select Category'**
  String get selectCategory;

  /// No description provided for @privacyPolicyLastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last updated: 2024-09-01'**
  String get privacyPolicyLastUpdated;

  /// No description provided for @privacyPolicyInfoCollection.
  ///
  /// In en, this message translates to:
  /// **'Do you allow the 963SY application to run videos and virtual tours on your device?'**
  String get privacyPolicyInfoCollection;

  /// No description provided for @privacyPolicyInfoCollectionContent.
  ///
  /// In en, this message translates to:
  /// **'The 963 application is an application owned by the Syrian Ministry of Tourism and implemented by ArtFly. It contributes to implementing the Ministry\'s plan in tourism promotion by displaying virtual tours of the most important tourist attractions'**
  String get privacyPolicyInfoCollectionContent;

  /// No description provided for @privacyPolicyInfoUsage.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicyInfoUsage;

  /// No description provided for @privacyPolicyInfoUsageContent.
  ///
  /// In en, this message translates to:
  /// **'ArtFly designed the 963 application as a free application. This service is provided by \"Artfly\" at no cost and is intended for use as is.\nThis page is used to inform visitors about our policies regarding the collection, use, and disclosure of personal information if anyone decides to use our service.\nIf you choose to use our service, then you agree to all information related to this policy. We will not use or share your information with anyone or any company.\nThe terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible on the 963 application unless otherwise defined in this Privacy Policy.'**
  String get privacyPolicyInfoUsageContent;

  /// No description provided for @privacyPolicyInfoSharing.
  ///
  /// In en, this message translates to:
  /// **'Information Collection and Use'**
  String get privacyPolicyInfoSharing;

  /// No description provided for @privacyPolicyInfoSharingContent.
  ///
  /// In en, this message translates to:
  /// **'For a better experience, while using our service, in a safe and protected manner, we will not ask you to provide us with personally identifiable information or any other type of data, and we will not request any permissions for your mobile phone. The information we request will be retained by us and used as described in this privacy policy.'**
  String get privacyPolicyInfoSharingContent;

  /// No description provided for @privacyPolicyYourRights.
  ///
  /// In en, this message translates to:
  /// **'Cookies'**
  String get privacyPolicyYourRights;

  /// No description provided for @privacyPolicyYourRightsContent.
  ///
  /// In en, this message translates to:
  /// **'Cookies are files containing a small amount of data that are commonly used as anonymous unique identifiers. They are sent to your browser from the websites you visit and are stored on your device\'s internal memory.\n\nThis service does not use \"cookies\" at all.'**
  String get privacyPolicyYourRightsContent;

  /// No description provided for @privacyPolicySecurity.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get privacyPolicySecurity;

  /// No description provided for @privacyPolicySecurityContent.
  ///
  /// In en, this message translates to:
  /// **'The application does not collect any personal information and does not request any permissions to access mobile data or information about it, and does not collect any information about your geographical location.'**
  String get privacyPolicySecurityContent;

  /// No description provided for @privacyPolicyLinks.
  ///
  /// In en, this message translates to:
  /// **'Links to Other Sites'**
  String get privacyPolicyLinks;

  /// No description provided for @privacyPolicyLinksContent.
  ///
  /// In en, this message translates to:
  /// **'This service may contain links to other sites, and these sites are for our platforms on social media. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by us. Therefore, we strongly advise you to review the Privacy Policy of these websites. We have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.'**
  String get privacyPolicyLinksContent;

  /// No description provided for @privacyPolicyChildren.
  ///
  /// In en, this message translates to:
  /// **'Children\'s Privacy'**
  String get privacyPolicyChildren;

  /// No description provided for @privacyPolicyChildrenContent.
  ///
  /// In en, this message translates to:
  /// **'This service is provided for all ages and genders and does not display any harmful content at all, and the content is managed effectively.'**
  String get privacyPolicyChildrenContent;

  /// No description provided for @privacyPolicyContact.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get privacyPolicyContact;

  /// No description provided for @privacyPolicyContactContent.
  ///
  /// In en, this message translates to:
  /// **'If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us at info@963sy.sy.'**
  String get privacyPolicyContactContent;

  /// No description provided for @privacyPolicyTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get privacyPolicyTerms;

  /// No description provided for @privacyPolicyTermsContent.
  ///
  /// In en, this message translates to:
  /// **'Definition of the application and its nature of operation\n\nThe application does not collect any information about users because the application is for displaying information only and does not contain any feature for logging in and creating an account and entering any type of data\n\nSources that the application uses on the user\'s device\nThe application does not use any sources or resources from the computer, it only needs an internet connection from mobile data or WIFI\n\nSharing personal data if it exists\nThere is no personal information about the user\n\nUnsubscribe\nThere is no subscription feature in the application\n\nUpdating the usage policy and how the user is notified\nIn case of updating the privacy policy, it will be displayed to the user with explicit reference to the changes made, and the privacy policy will be effective so that it allows the user to accept or reject it\n\nAny other necessary information that the application owner deems appropriate\nBy downloading or using the application, these terms will automatically apply to you - therefore, you should make sure to read them carefully before using the application. You are not allowed to copy or modify the application or any part of it or our trademarks in any way. You are not allowed to try to extract the source code of the application, and you should not try to translate the application into other languages or create derivative versions. The application itself and all trademarks, copyrights, database rights, and other intellectual property rights related to it remain owned by the Syrian Ministry of Tourism.\n\nYou are responsible for keeping your phone and access to the application secure. Therefore, we recommend that you do not jailbreak or root your phone, which is the process of removing software restrictions and restrictions imposed by the official operating system of your device. It can make your phone vulnerable to malware/viruses/malicious programs, compromise your phone\'s security features, and could mean that the 963 application won\'t work properly or at all.\n\nYou should be aware that there are certain things that ArtFly will not take responsibility for. Some functions of the application will require the application to have an active internet connection. The connection can be via Wi-Fi or provided by your mobile network provider, but ArtFly cannot take responsibility for the application not working at full functionality if you don\'t have access to Wi-Fi, and you don\'t have any other internet connection.\n\nWith respect to ArtFly\'s responsibility for your use of the application, when using the application, it\'s important to bear in mind that although we endeavor to ensure that it is updated and correct at all times, we do rely on third parties to provide information to us so that we can make it available to you. ArtFly accepts no liability for any loss, direct or indirect, you experience as a result of relying wholly on this functionality of the application.\n\nChanges to These Terms and Conditions\nWe may update our Terms and Conditions from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Terms and Conditions on this page.\n\nThese terms and conditions are effective as of 2024-09-01'**
  String get privacyPolicyTermsContent;

  /// No description provided for @damascus.
  ///
  /// In en, this message translates to:
  /// **'Damascus'**
  String get damascus;

  /// No description provided for @aleppo.
  ///
  /// In en, this message translates to:
  /// **'Aleppo'**
  String get aleppo;

  /// No description provided for @homs.
  ///
  /// In en, this message translates to:
  /// **'Homs'**
  String get homs;

  /// No description provided for @hama.
  ///
  /// In en, this message translates to:
  /// **'Hama'**
  String get hama;

  /// No description provided for @latakia.
  ///
  /// In en, this message translates to:
  /// **'Latakia'**
  String get latakia;

  /// No description provided for @tartus.
  ///
  /// In en, this message translates to:
  /// **'Tartus'**
  String get tartus;

  /// No description provided for @deirEzzor.
  ///
  /// In en, this message translates to:
  /// **'Deir Ezzor'**
  String get deirEzzor;

  /// No description provided for @raqqa.
  ///
  /// In en, this message translates to:
  /// **'Raqqa'**
  String get raqqa;

  /// No description provided for @hasakah.
  ///
  /// In en, this message translates to:
  /// **'Hasakah'**
  String get hasakah;

  /// No description provided for @idlib.
  ///
  /// In en, this message translates to:
  /// **'Idlib'**
  String get idlib;

  /// No description provided for @daraa.
  ///
  /// In en, this message translates to:
  /// **'Daraa'**
  String get daraa;

  /// No description provided for @sweida.
  ///
  /// In en, this message translates to:
  /// **'Sweida'**
  String get sweida;

  /// No description provided for @quneitra.
  ///
  /// In en, this message translates to:
  /// **'Quneitra'**
  String get quneitra;

  /// No description provided for @restaurants.
  ///
  /// In en, this message translates to:
  /// **'Restaurants'**
  String get restaurants;

  /// No description provided for @cafes.
  ///
  /// In en, this message translates to:
  /// **'Cafes'**
  String get cafes;

  /// No description provided for @hotels.
  ///
  /// In en, this message translates to:
  /// **'Hotels'**
  String get hotels;

  /// No description provided for @tourServices.
  ///
  /// In en, this message translates to:
  /// **'Tour Services'**
  String get tourServices;

  /// No description provided for @publicServices.
  ///
  /// In en, this message translates to:
  /// **'Public Services'**
  String get publicServices;

  /// No description provided for @hospitals.
  ///
  /// In en, this message translates to:
  /// **'Hospitals'**
  String get hospitals;

  /// No description provided for @aboutUsContent.
  ///
  /// In en, this message translates to:
  /// **'تطبيق 963SY \nمن أهم أعمال مؤسسة artfly... المؤسسة التي كان لها دورًا مهمًا في رحلة الابتكار، والتّصوير، والتّوثيق، والتميز في استخدام الطائرات المسيرة للتصوير الجوي.\nيعتبر التّطبيق 963SY حقيبة معلومات شاملة تجلب السياحة إلى متناول الجميع، بغض النظر عن قدراتهم البدنية أو اللغوية.\nيقدم المعرفة حول سورية بتاريخها وتراثها وأماكنها السياحية، ويسهم في زيادة الوعي حول وجودها وأهميتها.\nيوفر قاعدة بيانات للتعريف بالمقومات والأماكن السياحيّة المحليّة الجميلة، وكذلك الفعاليات والأنشطة كافة التي تشهدها سورية... يعرضها بفيديوهات وصور خاصة تعكس جمال سورية وتبرز التّجارب المشوقة التي يمكن الاستمتاع بها هناك.\nيمكن لمستخدم التطبيق 963SY تصفح الخريطة السياحيّة المتاحة للأماكن والمواقع المختلفة والوصول إليها بسهولة وسرعة، بالإضافة الى المعلومات والنّصوص المتعلقة بكل مكان على حدا.\nتطبيق 963SY  دليل الوعي والاستكشاف والتّراث الروحي الذي يحتضنه هذا البلد الجميل، ويتيح للعالم اكتشاف مقوماتها وزيارتها بضغطة زر. فهو يجمع بين الثّقافة والتّكنولوجيا، ويعطي للسائح تجربة سفر افتراضيّة حقيقية. في عالم ينقصه الوقت والفرص. كما يُقدّم تجربة محيطية كاملة للمواقع السياحية بزاوية رؤية 360 درجة لاستكشاف كل زاوية فيها ومجمل جمال المناظر الطبيعية الخلّابة في سورية.\nيوفير التطبيق 963SY  تجربة متكاملة وشاملة لجميع الفئات المختلفة من المستخدمين، بما في ذلك أولئك الذين يواجهون تحديات في التواصل وفهم المعلومات بسبب إعاقتهم السمعية.\nتطبيق 963SY يعكس رؤية artfly في خدمة المجتمع وتعزيز التّواصل الثّقافي والسّياحي من خلال التّكنولوجيا المتقدمة والابتكار.'**
  String get aboutUsContent;

  /// No description provided for @aboutUsEnglish.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get aboutUsEnglish;

  /// No description provided for @aboutUsEnglishContent.
  ///
  /// In en, this message translates to:
  /// **'963SY application\nOne of the most important works of the Artfly Foundation... is the organization that played an important role in the journey of innovation, photography, documentation, and excellence in the use of drones for aerial photography.\nThe 963SY application is a comprehensive information package that brings tourism within everyone\'s reach, regardless of their physical or linguistic abilities.\nIt provides knowledge about Syria, its history, heritage, and tourist places, and contributes to increasing awareness about its existence and importance.\nIt provides a database to introduce the beautiful local tourist attractions and places, as well as all the events and activities taking place in Syria... It displays them with special videos and photos that reflect the beauty of Syria and highlight the exciting experiences that can be enjoyed there.\nThe 963SY application user can browse the available tourist map of different places and sites and access them easily and quickly, in addition to information and texts related to each place separately.\nThe 963SY application is a guide to awareness, exploration, and the spiritual heritage that this beautiful country embraces, and allows the world to discover its components and visit them with the click of a button. It combines culture and technology, and gives tourists a real virtual travel experience. In a world that lacks time and opportunities. It also provides a complete surround experience of tourist sites with a 360-degree viewing angle to explore every corner and the entire beauty of Syria\'s stunning landscapes.\nThe 963SY application provides an integrated and comprehensive experience for all different categories of users, including those who face challenges in communicating and understanding information due to their hearing disability.\nThe 963SY application reflects artfly\'s vision of serving the community and enhancing cultural and tourism communication through advanced technology and innovation.'**
  String get aboutUsEnglishContent;

  /// No description provided for @information.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get information;

  /// No description provided for @virtualTour.
  ///
  /// In en, this message translates to:
  /// **'Virtual Tour'**
  String get virtualTour;

  /// No description provided for @goToPlace.
  ///
  /// In en, this message translates to:
  /// **'Go to Place'**
  String get goToPlace;

  /// No description provided for @mediaClips.
  ///
  /// In en, this message translates to:
  /// **'Media Clips'**
  String get mediaClips;

  /// No description provided for @signLanguage.
  ///
  /// In en, this message translates to:
  /// **'Sign Language'**
  String get signLanguage;

  /// No description provided for @cannotOpenGoogleMaps.
  ///
  /// In en, this message translates to:
  /// **'Cannot open Google Maps'**
  String get cannotOpenGoogleMaps;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @informationCollection.
  ///
  /// In en, this message translates to:
  /// **'Information Collection'**
  String get informationCollection;

  /// No description provided for @informationCollectionContent.
  ///
  /// In en, this message translates to:
  /// **'We collect necessary information, including location data and preferences, to provide our services. We ensure the protection of your personal data and do not share it with third parties.'**
  String get informationCollectionContent;

  /// No description provided for @dataUsage.
  ///
  /// In en, this message translates to:
  /// **'Data Usage'**
  String get dataUsage;

  /// No description provided for @dataUsageContent.
  ///
  /// In en, this message translates to:
  /// **'We use data to improve user experience and provide personalized content. You can control your privacy settings at any time.'**
  String get dataUsageContent;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @securityContent.
  ///
  /// In en, this message translates to:
  /// **'We use the latest security technologies to protect your data. All sensitive information is encrypted.'**
  String get securityContent;

  /// No description provided for @userRights.
  ///
  /// In en, this message translates to:
  /// **'User Rights'**
  String get userRights;

  /// No description provided for @userRightsContent.
  ///
  /// In en, this message translates to:
  /// **'You have the right to access, modify, or delete your data. You can also request to export your data.'**
  String get userRightsContent;

  /// No description provided for @deviceRegisteredSuccess.
  ///
  /// In en, this message translates to:
  /// **'Device registered successfully'**
  String get deviceRegisteredSuccess;

  /// No description provided for @deviceRegistrationError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String deviceRegistrationError(Object error);

  /// No description provided for @chooseService.
  ///
  /// In en, this message translates to:
  /// **'Choose a service'**
  String get chooseService;

  /// No description provided for @placeInfo.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get placeInfo;

  /// No description provided for @placeDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get placeDescription;

  /// No description provided for @noPlaces.
  ///
  /// In en, this message translates to:
  /// **'No places found'**
  String get noPlaces;

  /// No description provided for @noPlacesFound.
  ///
  /// In en, this message translates to:
  /// **'No Places Found'**
  String get noPlacesFound;

  /// No description provided for @noPlacesInGovernorate.
  ///
  /// In en, this message translates to:
  /// **'There are no places available in this governorate yet'**
  String get noPlacesInGovernorate;

  /// No description provided for @offlineTitle.
  ///
  /// In en, this message translates to:
  /// **'You are offline'**
  String get offlineTitle;

  /// No description provided for @offlineDescription.
  ///
  /// In en, this message translates to:
  /// **'Please check your internet connection and try again.'**
  String get offlineDescription;

  /// No description provided for @selectStar.
  ///
  /// In en, this message translates to:
  /// **'Select Star Rating'**
  String get selectStar;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'en',
    'es',
    'fr',
    'it',
    'tr',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'tr':
      return AppLocalizationsTr();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
