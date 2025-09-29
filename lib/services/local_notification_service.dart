import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LocalNotificationService {
  static final LocalNotificationService _instance = LocalNotificationService._internal();
  factory LocalNotificationService() => _instance;
  LocalNotificationService._internal();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const String _channelId = 'habit_tracker_notifications';
  static const String _channelName = 'Habit Tracker Notifications';
  static const String _channelDescription = 'Notifications pour l\'application Habit Tracker';

  // Initialiser les notifications locales
  Future<void> initialize() async {
    // Configuration Android
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Configuration iOS
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    // Configuration macOS
    const DarwinInitializationSettings initializationSettingsMacOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    // Configuration générale
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: initializationSettingsMacOS,
    );

    // Initialiser le plugin
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Créer le canal de notification Android
    await _createNotificationChannel();
  }

  // Créer le canal de notification pour Android
  Future<void> _createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      _channelId,
      _channelName,
      description: _channelDescription,
      importance: Importance.high,
      sound: RawResourceAndroidNotificationSound('notification'),
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  // Gérer le tap sur une notification
  void _onNotificationTapped(NotificationResponse notificationResponse) {
    final String? payload = notificationResponse.payload;
    if (payload != null) {
      debugPrint('Notification payload: $payload');
      // Ici vous pouvez ajouter la logique pour naviguer vers une page spécifique
      // Par exemple : NavigationService.navigateTo('/task_detail', arguments: payload);
    }
  }

  // Afficher une notification locale
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      color: Color(0xFF0EA5E9), // AppColors.energyBlue
      ledColor: Color(0xFF0EA5E9),
      ledOnMs: 1000,
      ledOffMs: 500,
    );

    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const DarwinNotificationDetails macosNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
      macOS: macosNotificationDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  // Afficher une notification avec style étendu (Android)
  Future<void> showBigTextNotification({
    required int id,
    required String title,
    required String body,
    required String bigText,
    String? payload,
  }) async {
    final AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      color: const Color(0xFF0EA5E9),
      styleInformation: BigTextStyleInformation(
        bigText,
        htmlFormatBigText: true,
        contentTitle: title,
        htmlFormatContentTitle: true,
        summaryText: 'Habit Tracker',
        htmlFormatSummaryText: true,
      ),
    );

    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
      macOS: iosNotificationDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  // Convertir un message Firebase en notification locale
  Future<void> showFirebaseNotification(RemoteMessage message) async {
    final notification = message.notification;
    final data = message.data;

    if (notification != null) {
      // Utiliser l'ID du message ou générer un ID unique
      final int notificationId = message.hashCode;
      
      String title = notification.title ?? 'Habit Tracker';
      String body = notification.body ?? 'Nouvelle notification';
      
      // Forcer l'affichage même en foreground
      await showForegroundNotification(
        id: notificationId,
        title: title,
        body: body,
        payload: data['payload'],
        bigText: data['big_text'],
      );
    }
  }

  // Notification spécialement conçue pour le foreground
  Future<void> showForegroundNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
    String? bigText,
  }) async {
    // Debug pour simulateur
    debugPrint('🔔 Tentative d\'affichage notification: $title - $body');
    
    final AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.max, // Importance maximale
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      color: const Color(0xFF0EA5E9),
      ledColor: const Color(0xFF0EA5E9),
      ledOnMs: 1000,
      ledOffMs: 500,
      // Forcer l'affichage en foreground
      enableVibration: true,
      playSound: true,
      // Style étendu si disponible
      styleInformation: bigText != null
          ? BigTextStyleInformation(
              bigText,
              htmlFormatBigText: true,
              contentTitle: title,
              htmlFormatContentTitle: true,
              summaryText: 'Habit Tracker',
            )
          : null,
    );

    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,  // Forcer l'affichage en foreground
      presentBadge: true,
      presentSound: true,
      sound: 'default',
    );

    const DarwinNotificationDetails macosNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,  // Forcer l'affichage en foreground
      presentBadge: true,
      presentSound: true,
      sound: 'default',
    );

    final NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
      macOS: macosNotificationDetails,
    );

    try {
      await _flutterLocalNotificationsPlugin.show(
        id,
        title,
        body,
        notificationDetails,
        payload: payload,
      );
      debugPrint('✅ Notification envoyée avec succès');
    } catch (e) {
      debugPrint('❌ Erreur notification: $e');
    }
  }

  // Annuler une notification
  Future<void> cancelNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  // Annuler toutes les notifications
  Future<void> cancelAllNotifications() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  // Demander les permissions (iOS)
  Future<bool> requestPermissions() async {
    final bool? result = await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    return result ?? false;
  }

  // Demander les permissions (macOS)
  Future<bool> requestPermissionsMacOS() async {
    final bool? result = await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    return result ?? false;
  }
}
