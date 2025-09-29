import 'package:flutter/material.dart';
import 'package:hobies_app/pages/home_page.dart';
import 'package:hobies_app/pages/profile_page.dart';
import 'package:hobies_app/pages/settings_page.dart';
import 'package:hobies_app/constants/app_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hobies_app/auth/auth_wrapper.dart';
import 'package:hobies_app/services/local_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// Fonction pour gérer les notifications en arrière-plan
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final notificationService = LocalNotificationService();
  await notificationService.initialize();
  await notificationService.showFirebaseNotification(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(url: 'https://iymvkoqwhhohubgqqbij.supabase.co', anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml5bXZrb3F3aGhvaHViZ3FxYmlqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTU2ODM2MTQsImV4cCI6MjA3MTI1OTYxNH0.Zmi2YKbyY3giQqTH6x7TEGtEc8O--do-NbpTloGBWDM');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  // Configurer le gestionnaire de notifications en arrière-plan
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Habit Tracker',
      theme: AppTheme.darkTheme,
      home: const AuthWrapper(),
    );
  }
}

class NavigationWrapper extends StatefulWidget {
  const NavigationWrapper({super.key});

  @override
  State<NavigationWrapper> createState() => _NavigationWrapperState();
}

class _NavigationWrapperState extends State<NavigationWrapper> {
  int _selectedIndex = 0;
  final supabase = Supabase.instance.client;

  // Liste des pages
  static const List<Widget> _pages = <Widget>[
    HomePage(),
    ProfilePage(),
  ];

  // Méthode pour changer de page
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Habit Tracker')),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Habitudes'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
