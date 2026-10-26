import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit()
    : super(
        const GameState(
          cards: [
            GameCard(color: Color(0xFFE57373)),
            GameCard(color: Color(0xFF64B5F6)),
            GameCard(color: Color(0xFFE57373)),
            GameCard(color: Color(0xFF64B5F6)),
          ],
        ),
      );

  static const int _maximumMistakes = 2;

  void selectCard(int index) {
    if (state.isGameOver ||
        state.isWon ||
        state.isChecking ||
        index < 0 ||
        index >= state.cards.length) {
      return;
    }

    final selectedCard = state.cards[index];
    if (selectedCard.isOpen || selectedCard.isMatched) {
      return;
    }

    final cards = List<GameCard>.of(state.cards);
    cards[index] = selectedCard.copyWith(isOpen: true);

    final openIndexes = <int>[
      for (var i = 0; i < cards.length; i++)
        if (cards[i].isOpen && !cards[i].isMatched) i,
    ];

    if (openIndexes.length < 2) {
      emit(
        GameState(
          cards: cards,
          mistakes: state.mistakes,
          isChecking: false,
          isGameOver: false,
          isWon: false,
        ),
      );
      return;
    }

    final firstIndex = openIndexes[0];
    final secondIndex = openIndexes[1];

    if (cards[firstIndex].color == cards[secondIndex].color) {
      cards[firstIndex] = cards[firstIndex].copyWith(isMatched: true);
      cards[secondIndex] = cards[secondIndex].copyWith(isMatched: true);
      final hasWon = cards.every((card) => card.isMatched);

      emit(
        GameState(
          cards: cards,
          mistakes: state.mistakes,
          message: 'Успешно',
          isWon: hasWon,
        ),
      );
      return;
    }

    final mistakes = state.mistakes + 1;
    final hasLost = mistakes >= _maximumMistakes;
    emit(
      GameState(
        cards: cards,
        mistakes: mistakes,
        message: hasLost ? 'У вас не осталось попыток' : null,
        isChecking: !hasLost,
        isGameOver: hasLost,
      ),
    );

    if (!hasLost) {
      _hideUnmatchedCards();
    }
  }

  Future<void> _hideUnmatchedCards() async {
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (isClosed || state.isGameOver) {
      return;
    }

    final cards = state.cards
        .map((card) => card.isMatched ? card : card.copyWith(isOpen: false))
        .toList();
    emit(GameState(cards: cards, mistakes: state.mistakes));
  }
}
