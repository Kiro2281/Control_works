import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/game_cubit.dart';
import 'screens/game_screen.dart';

void main() {
  runApp(const FindPairApp());
}

class FindPairApp extends StatelessWidget {
  const FindPairApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Найди пару',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6750A4)),
        useMaterial3: true,
      ),
      home: BlocProvider(create: (_) => GameCubit(), child: const GameScreen()),
    );
  }
}
