import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hobies_app/pages/auth/login_page.dart';
import 'package:hobies_app/main.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  User? _user;
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    _getInitialSession();
    _listenToAuthChanges();
  }

  void _getInitialSession() {
    setState(() {
      _user = supabase.auth.currentUser;
    });
  }

  void _listenToAuthChanges() {
    supabase.auth.onAuthStateChange.listen((data) {
      setState(() {
        _user = data.session?.user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Si l'utilisateur est connecté, afficher l'app normale
    // Sinon, afficher la page de login
    return _user != null ? const NavigationWrapper() : const LoginPage();
  }
}
