import 'package:diario_emocional/core/app_colors.dart';
import 'package:flutter/material.dart';

enum Emotion { sad, bad, neutral, good, happy }

const Map<Emotion, String> emotionLabels = {
  Emotion.sad: 'Triste',
  Emotion.bad: 'Mal',
  Emotion.neutral: 'Neutro',
  Emotion.good: 'Bem',
  Emotion.happy: 'Feliz',
};

const Map<Emotion, IconData> emotionIcons = {
  Emotion.sad: Icons.sentiment_very_dissatisfied,
  Emotion.bad: Icons.sentiment_dissatisfied,
  Emotion.neutral: Icons.sentiment_neutral,
  Emotion.good: Icons.sentiment_satisfied,
  Emotion.happy: Icons.sentiment_very_satisfied,
};

const Map<Emotion, Color> emotionColors = {
  Emotion.sad: AppColors.red,
  Emotion.bad: AppColors.orange,
  Emotion.neutral: AppColors.yellow,
  Emotion.good: AppColors.lightGreen,
  Emotion.happy: AppColors.green,
};
