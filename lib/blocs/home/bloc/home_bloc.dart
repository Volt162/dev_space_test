import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final List<CustomException> exs = [
    CustomException('No internet connection'),
    CustomException('Sorry, item not added! Try againe'),
    CustomException('Sorry, item not removed! Try againe'),
  ];

  HomeBloc() : super(HomePageLoading()) {
    {
      on<StartHomePage>(_onStartHomePage);
      on<IncrementItemList>(_onIncrementItemList);
      on<DecrementItemList>(_onDecrementItemList);
    }
  }

  FutureOr<void> _onStartHomePage(
      StartHomePage event, Emitter<HomeState> emit) async {
    emit(HomePageLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 2000));
      emit(const HomePageItemListChanged());
    } catch (e) {
      emit(const HomePageError(message: ''));
    }
  }

  FutureOr<void> _onIncrementItemList(
      IncrementItemList event, Emitter<HomeState> emit) async {
    try {
      if (state.itemList.length > 35) {
        _tryGetRandomeException();
      }
      emit(HomePageItemListChanged(
          itemList: List<String>.from(state.itemList)
            ..add('Item ${state.itemList.length}')));
    } on CustomException catch (ex) {
      emit(HomePageError(
          message: ex.message, itemList: List<String>.from(state.itemList)));
    } catch (e) {
      emit(HomePageError(message: e.toString()));
    }
  }

  FutureOr<void> _onDecrementItemList(
      DecrementItemList event, Emitter<HomeState> emit) {
    try {
      if (state.itemList.length > 35) {
        _tryGetRandomeException();
      }
      if (state.itemList.isNotEmpty) {
        emit(HomePageItemListChanged(
            itemList: List<String>.from(state.itemList)
              ..removeAt(state.itemList.length - 1)));
      }
    } on CustomException catch (ex) {
      emit(HomePageError(
          message: ex.message, itemList: List<String>.from(state.itemList)));
    } catch (e) {
      emit(HomePageError(message: e.toString()));
    }
  }

  void _throwException(CustomException ex) {
    throw ex;
  }

  void _tryGetRandomeException() {
    final randomNumberGenerator = Random();
    final randomBoolean = randomNumberGenerator.nextBool();

    if (randomBoolean) {
      CustomException ex = exs[randomNumberGenerator.nextInt(3)];
      _throwException(ex);
    }
  }
}

class CustomException implements Exception {
  String message;
  CustomException(this.message);
}
