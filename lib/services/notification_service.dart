import 'package:book_indian_talents_app/helper/constants.dart';
import 'package:book_indian_talents_app/helper/helper.dart';
import 'package:book_indian_talents_app/helper/session_manager.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> backgroundHandler(RemoteMessage message) async {
  String body = message.data['body'];
  String title = message.data['title'];
  String image = message.data['image'];
  String postID = message.data['post_id'];

  if (image.isEmpty) {
    NotificationService()
        .showLocalNotification(id: 0, title: '', body: body, payload: postID);
  } else {
    NotificationService().showLocalNotificationBigPicure(
        id: 0, title: '', body: '', payload: postID, imageUrl: image);
  }
}

int notificationId = 0;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  String body = message.data['body'];
  String title = message.data['title'];
  String image = message.data['image'];

  if (image.isEmpty) {
    NotificationService().showLocalNotification(
        id: notificationId,
        title: title,
        body: body,
        payload: notificationId.toString());
  } else {
    NotificationService().showLocalNotificationBigPicure(
        id: notificationId,
        title: title,
        body: body,
        payload: notificationId.toString(),
        imageUrl: image);
  }
  notificationId++;
}

class NotificationService {
  //todo: initialize firebase message
  static Future<void> initialize() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        print(token);
        SessionManager.setToken(token);
      }

      await FirebaseMessaging.instance.subscribeToTopic('all');
      //FirebaseMessaging.onBackgroundMessage(backgroundHandler);

      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);

      print("Notifications Initialized!");
    }
    print('User granted permission: ${settings.authorizationStatus}');
  }

  //todo: local notification initialize
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/notification');

    DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    // await notificationsPlugin.initialize(initializationSettings,
    //     onSelectNotification: selectNotification);
    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) {
        print('Response ${response.payload}');
      },
    );
  }

  Future<NotificationDetails> _notificationDetailsBigPicture(
      String imageUrl, String channelId, String title) async {
    //https://images.unsplash.com/photo-1624948465027-6f9b51067557?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80
    final bigPicture =
        await Helper.downloadAndSaveFile(imageUrl, "book_indian_app");

    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      channelId,
      '$channelId',
      groupKey: 'com.bookindian.app',
      channelDescription: 'channel_description',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      ticker: 'ticker',
      //largeIcon: const DrawableResourceAndroidBitmap('logo'),
      styleInformation: BigPictureStyleInformation(
        FilePathAndroidBitmap(bigPicture),
        hideExpandedLargeIcon: false,
      ),
      color: kAppColor,
      onlyAlertOnce: true,
    );

    DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(
            threadIdentifier: "thread1",
            attachments: <DarwinNotificationAttachment>[
          DarwinNotificationAttachment(bigPicture)
        ]);

    final details = await notificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      // behaviorSubject.add(details.payload!);
    }
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iosNotificationDetails);

    return platformChannelSpecifics;
  }

  //or ios : threadIdentifier in IOSNotificationDetails
  // for android : groupChannelId, groupChannelName, groupChannelDescription,
  Future<NotificationDetails> _notificationDetails(
      String body, String channelId, String title) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(channelId, '$channelId',
            groupKey: 'com.bookindian.app',
            channelDescription: 'channel_description',
            importance: Importance.max,
            priority: Priority.max,
            playSound: true,
            ticker: 'ticker',
            // largeIcon: const DrawableResourceAndroidBitmap('logo'),
            styleInformation: BigTextStyleInformation(body),
            color: kAppColor);

    DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(
      threadIdentifier: "thread1",
    );

    final details = await notificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      // behaviorSubject.add(details.payload!);
    }
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iosNotificationDetails);

    return platformChannelSpecifics;
  }

  Future<void> showLocalNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
  }) async {
    final platformChannelSpecifics =
        await _notificationDetails(body, payload, title);
    await notificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  Future<void> showLocalNotificationBigPicure(
      {required int id,
      required String title,
      required String body,
      required String payload,
      required String imageUrl}) async {
    final platformChannelSpecifics =
        await _notificationDetailsBigPicture(imageUrl, payload, title);
    await notificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }
}
