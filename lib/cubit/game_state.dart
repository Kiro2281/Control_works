import 'package:flutter/material.dart';

class GameCard {
  const GameCard({
    required this.color,
    this.isOpen = false,
    this.isMatched = false,
  });

  final Color color;
  final bool isOpen;
  final bool isMatched;

  GameCard copyWith({bool? isOpen, bool? isMatched}) {
    return GameCard(
      color: color,
      isOpen: isOpen ?? this.isOpen,
      isMatched: isMatched ?? this.isMatched,
    );
  }
}

class GameState {
  const GameState({
    required this.cards,
    this.mistakes = 0,
    this.message,
    this.isChecking = false,
    this.isGameOver = false,
    this.isWon = false,
  });

  final List<GameCard> cards;
  final int mistakes;
  final String? message;
  final bool isChecking;
  final bool isGameOver;
  final bool isWon;
}
