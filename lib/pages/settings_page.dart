import 'package:flutter/material.dart';
import 'package:hobies_app/constants/app_colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.settings,
            size: 100,
            color: AppColors.energyBlue,
          ),
          const SizedBox(height: AppDimensions.paddingLarge),
          Text(
            'Paramètres',
            style: AppTextStyles.heading1.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingMedium),
          Text(
            'Configurez votre expérience Habit Tracker',
            style: AppTextStyles.body.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimensions.paddingXLarge),
          
          // Placeholder pour futures fonctionnalités
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingMedium),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.notifications, color: AppColors.energyBlue),
                    title: Text(
                      'Notifications',
                      style: AppTextStyles.subtitle.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    subtitle: Text(
                      'Gérer les rappels d\'habitudes',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textLight,
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: AppColors.textLight),
                  ),
                  Divider(color: AppColors.surfaceVariant),
                  ListTile(
                    leading: Icon(Icons.palette, color: AppColors.motivatingPurple),
                    title: Text(
                      'Thème',
                      style: AppTextStyles.subtitle.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    subtitle: Text(
                      'Personnaliser l\'apparence',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textLight,
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: AppColors.textLight),
                  ),
                  Divider(color: AppColors.surfaceVariant),
                  ListTile(
                    leading: Icon(Icons.backup, color: AppColors.inspiringGreen),
                    title: Text(
                      'Sauvegarde',
                      style: AppTextStyles.subtitle.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    subtitle: Text(
                      'Synchronisation des données',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textLight,
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: AppColors.textLight),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
