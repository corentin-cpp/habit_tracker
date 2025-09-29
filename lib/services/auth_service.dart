import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final supabase = Supabase.instance.client;

  // Obtenir l'utilisateur actuel
  User? get currentUser => supabase.auth.currentUser;

  // Vérifier si l'utilisateur est connecté
  bool get isLoggedIn => currentUser != null;

  // Stream pour écouter les changements d'authentification
  Stream<AuthState> get authStateChanges => supabase.auth.onAuthStateChange;

  // Connexion avec email et mot de passe
  Future<AuthResponse> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Inscription avec email et mot de passe
  Future<AuthResponse> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Déconnexion
  Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  // Réinitialisation du mot de passe
  Future<void> resetPassword(String email) async {
    try {
      await supabase.auth.resetPasswordForEmail(email);
    } catch (e) {
      rethrow;
    }
  }

  // Obtenir les métadonnées de l'utilisateur
  Map<String, dynamic>? get userMetadata => currentUser?.userMetadata;

  // Obtenir l'email de l'utilisateur
  String? get userEmail => currentUser?.email;

  // Obtenir l'ID de l'utilisateur
  String? get userId => currentUser?.id;
}
