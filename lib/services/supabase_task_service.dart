import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hobies_app/models/task_model.dart';

class SupabaseTaskService {
  static final SupabaseTaskService _instance = SupabaseTaskService._internal();
  factory SupabaseTaskService() => _instance;
  SupabaseTaskService._internal();

  final supabase = Supabase.instance.client;

  // Obtenir toutes les tâches de l'utilisateur connecté
  Future<List<Task>> getAllTasks() async {
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('Utilisateur non connecté');
      }

      final response = await supabase
          .from('tasks')
          .select('*')
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      return (response as List<dynamic>)
          .map((json) => Task.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Erreur lors du chargement des tâches: $e');
    }
  }

  // Ajouter une nouvelle tâche
  Future<Task> addTask({
    required String name,
    String description = '',
    DateTime? executionDate,
    bool reccurent = false,
  }) async {
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('Utilisateur non connecté');
      }

      final taskData = {
        'name': name,
        'description': description,
        'isChecked': false,
        'executionDate': executionDate?.toIso8601String(),
        'created_at': DateTime.now().toIso8601String(),
        'reccurent': reccurent,
        'user_id': userId,
      };

      final response = await supabase
          .from('tasks')
          .insert(taskData)
          .select()
          .single();

      return Task.fromJson(response);
    } catch (e) {
      throw Exception('Erreur lors de l\'ajout de la tâche: $e');
    }
  }

  // Mettre à jour une tâche
  Future<Task> updateTask(Task task) async {
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('Utilisateur non connecté');
      }

      if (task.id == null) {
        throw Exception('ID de tâche manquant');
      }

      final updateData = {
        'name': task.name,
        'description': task.description,
        'isChecked': task.isChecked,
        'executionDate': task.executionDate?.toIso8601String(),
        'reccurent': task.reccurent,
      };

      final response = await supabase
          .from('tasks')
          .update(updateData)
          .eq('id', task.id!)
          .eq('user_id', userId)
          .select()
          .single();

      return Task.fromJson(response);
    } catch (e) {
      throw Exception('Erreur lors de la mise à jour de la tâche: $e');
    }
  }

  // Supprimer une tâche
  Future<void> deleteTask(String taskId) async {
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('Utilisateur non connecté');
      }

      await supabase
          .from('tasks')
          .delete()
          .eq('id', taskId)
          .eq('user_id', userId);
    } catch (e) {
      throw Exception('Erreur lors de la suppression de la tâche: $e');
    }
  }

  // Marquer une tâche comme terminée/non terminée
  Future<Task> toggleTaskCompletion(Task task) async {
    final updatedTask = task.copyWith(
      isChecked: !task.isChecked,
    );
    return await updateTask(updatedTask);
  }

  // Obtenir le nombre de tâches terminées
  Future<int> getCompletedTasksCount() async {
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) return 0;

      final response = await supabase
          .from('tasks')
          .select('id')
          .eq('user_id', userId)
          .eq('isChecked', true);

      return (response as List).length;
    } catch (e) {
      return 0;
    }
  }

  // Obtenir le nombre total de tâches
  Future<int> getTotalTasksCount() async {
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) return 0;

      final response = await supabase
          .from('tasks')
          .select('id')
          .eq('user_id', userId);

      return (response as List).length;
    } catch (e) {
      return 0;
    }
  }

  // Calculer le pourcentage de progression
  Future<double> getProgressPercentage() async {
    try {
      final total = await getTotalTasksCount();
      if (total == 0) return 0.0;
      
      final completed = await getCompletedTasksCount();
      return (completed / total) * 100;
    } catch (e) {
      return 0.0;
    }
  }

  // Écouter les changements en temps réel
  Stream<List<Task>> watchTasks() {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) {
      return Stream.value([]);
    }

    return supabase
        .from('tasks')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .order('created_at', ascending: false)
        .map((data) => data.map((json) => Task.fromJson(json)).toList());
  }
}
