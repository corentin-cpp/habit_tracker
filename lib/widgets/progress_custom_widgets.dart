import 'package:flutter/material.dart';
import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:hobies_app/constants/app_colors.dart';

class ProgressCustomWidgets extends StatefulWidget {
  final String title;
  final int progress;
  const ProgressCustomWidgets({super.key, required this.title, required this.progress});

  @override
  State<ProgressCustomWidgets> createState() => _ProgressCustomWidgetsState();
}

class _ProgressCustomWidgetsState extends State<ProgressCustomWidgets> {
  final ValueNotifier<double> _valueNotifier = ValueNotifier(0);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DashedCircularProgressBar.aspectRatio(
      aspectRatio: 2, // width ÷ height
      valueNotifier: _valueNotifier,
      progress: widget.progress.toDouble(),
      startAngle: 225,
      sweepAngle: 270,
      foregroundColor: AppColors.inspiringGreen,
      backgroundColor: const Color(0xffeeeeee),
      foregroundStrokeWidth: 15,
      backgroundStrokeWidth: 15,
      animation: true,
      seekSize: 6,
      seekColor: const Color(0xffeeeeee),
      child: Center(
        child: ValueListenableBuilder(
          valueListenable: _valueNotifier,
          builder: (_, double value, __) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${value.toInt()}%',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.inspiringGreen,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                widget.title,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w400,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
