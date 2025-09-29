import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hobies_app/constants/app_colors.dart';
import 'package:hobies_app/models/task_model.dart';
import 'package:hobies_app/services/supabase_task_service.dart';
import 'package:hobies_app/services/local_notification_service.dart';
import 'package:hobies_app/widgets/progress_custom_widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final supabase = Supabase.instance.client;
  final SupabaseTaskService _taskService = SupabaseTaskService();
  final LocalNotificationService _notificationService =
      LocalNotificationService();
  List<Task> _habits = [];
  double _progressTask = 0.0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    _setupFirebaseMessaging();
    _loadHabits();
  }

  Future<void> _initializeNotifications() async {
    await _notificationService.initialize();
    await _notificationService.requestPermissions();
  }

  void _setupFirebaseMessaging() {
    supabase.auth.onAuthStateChange.listen((event) async {
      if (event.event == AuthChangeEvent.signedIn) {
        await FirebaseMessaging.instance.requestPermission();
        await FirebaseMessaging.instance.getAPNSToken();
        final fcmToken = await FirebaseMessaging.instance.getToken();
        if (fcmToken != null) {
          _setFcmToken(fcmToken);
        }
      }
    });

    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
      await _setFcmToken(fcmToken);
    });

    FirebaseMessaging.onMessage.listen((payload) {
      // Afficher une vraie notification locale au lieu d'un SnackBar
      _notificationService.showFirebaseNotification(payload);
    });
  }

  Future<void> _setFcmToken(String token) async {
    final userId = supabase.auth.currentUser?.id;
    if (userId != null) {
      await supabase.from('profiles').upsert({
        'id': userId,
        'fcm_token': token,
      });
    }
  }

  Future<void> _loadHabits() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final tasks = await _taskService.getAllTasks();
      final progress = await _taskService.getProgressPercentage();

      setState(() {
        _habits = tasks;
        _progressTask = progress;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur lors du chargement: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _addHabit() async {
    showDialog(
      context: context,
      builder: (context) {
        String habitName = '';
        String description = '';
        bool isLoading = false;

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: AppColors.surface,
              title: Text(
                'Ajouter une habitude',
                style: AppTextStyles.heading2.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    onChanged: (value) => habitName = value,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.textPrimary,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Nom de l\'habitude',
                      hintStyle: TextStyle(color: AppColors.textLight),
                      filled: true,
                      fillColor: AppColors.surfaceVariant,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusSmall,
                        ),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingMedium),
                  TextField(
                    onChanged: (value) => description = value,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.textPrimary,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Description (optionnel)',
                      hintStyle: TextStyle(color: AppColors.textLight),
                      filled: true,
                      fillColor: AppColors.surfaceVariant,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusSmall,
                        ),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Annuler',
                    style: AppTextStyles.subtitle.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          if (habitName.isNotEmpty) {
                            setDialogState(() {
                              isLoading = true;
                            });

                            try {
                              await _taskService.addTask(
                                name: habitName,
                                description: description,
                              );

                              Navigator.of(context).pop();
                              _loadHabits(); // Recharger la liste

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Habitude ajoutée avec succès !',
                                  ),
                                  backgroundColor: AppColors.success,
                                ),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Erreur: $e'),
                                  backgroundColor: AppColors.error,
                                ),
                              );
                            } finally {
                              setDialogState(() {
                                isLoading = false;
                              });
                            }
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.energyBlue,
                    foregroundColor: AppColors.onPrimary,
                  ),
                  child: isLoading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : Text('Ajouter', style: AppTextStyles.subtitle),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _onChecked(Task task, bool? value) async {
    if (value == null) return;

    try {
      final updatedTask = task.copyWith(isChecked: value);
      await _taskService.updateTask(updatedTask);

      // Recharger pour mettre à jour la progression
      await _loadHabits();

      // Vérifier si toutes les tâches sont terminées
      if (_habits.every((task) => task.isChecked)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '🎉 Félicitations ! Vous avez terminé toutes vos habitudes !',
            ),
            duration: const Duration(seconds: 3),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de la mise à jour: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.energyBlue),
              ),
            )
          : CustomScrollView(
              slivers: [
                // SliverAppBar qui va se cacher lors du scroll
                SliverAppBar(
                  expandedHeight: 300.0,
                  floating: false,
                  pinned: false,
                  snap: false,
                  backgroundColor: AppColors.background,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Padding(
                      padding: const EdgeInsets.all(
                        AppDimensions.paddingMedium,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.task_alt, color: AppColors.success),
                              const SizedBox(width: AppDimensions.paddingSmall),
                              Text(
                                'Ma progression',
                                style: AppTextStyles.heading2.copyWith(
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppDimensions.paddingMedium),
                          // Votre ProgressCustomWidget qui va se cacher
                          ProgressCustomWidgets(
                            title: "Progression des habitudes",
                            progress: _progressTask.round(),
                          ),
                          const SizedBox(height: AppDimensions.paddingMedium),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 50.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Mes Habitudes',
                          style: AppTextStyles.heading2.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _habits.isEmpty
                    ? SliverFillRemaining(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.favorite_outline,
                                size: 64,
                                color: AppColors.textLight,
                              ),
                              const SizedBox(
                                height: AppDimensions.paddingMedium,
                              ),
                              Text(
                                'Aucune habitude pour le moment',
                                style: AppTextStyles.subtitle.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(
                                height: AppDimensions.paddingSmall,
                              ),
                              Text(
                                'Ajoutez vos premières habitudes !',
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.textLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SliverPadding(
                        padding: const EdgeInsets.all(
                          AppDimensions.paddingMedium,
                        ),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final habit = _habits[index];
                            return Card(
                              margin: const EdgeInsets.only(
                                bottom: AppDimensions.paddingSmall,
                              ),
                              child: ListTile(
                                leading: Container(
                                  width: 48,
                                  height: 48,
                                  child: Checkbox(
                                    value: habit.isChecked,
                                    onChanged: (value) {
                                      _onChecked(habit, value);
                                    },
                                    activeColor: AppColors.inspiringGreen,
                                    shape: const CircleBorder(),
                                    splashRadius: AppDimensions.radiusCircular,
                                  ),
                                ),
                                title: Text(
                                  habit.name,
                                  style: AppTextStyles.subtitle.copyWith(
                                    color: AppColors.textPrimary,
                                    decoration: habit.isChecked
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                                ),
                                subtitle: Text(
                                  habit.description.isEmpty
                                      ? 'Habitude ajoutée le ${habit.createdAt.day}/${habit.createdAt.month}/${habit.createdAt.year}'
                                      : habit.description,
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                  color: AppColors.textLight,
                                ),
                              ),
                            );
                          }, childCount: _habits.length),
                        ),
                      ),
              ],
            ),
      // Bouton flottant toujours visible
      floatingActionButton: IconButton(
        onPressed: _addHabit,
        icon: const Icon(Icons.add),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.energyBlue),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
