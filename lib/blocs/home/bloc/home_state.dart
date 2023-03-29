part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {
  final List<String> itemList;

  const HomeState({this.itemList = const <String>[]});

  @override
  List<Object> get props => [itemList];
}

class HomePageLoading extends HomeState {}

class HomePageItemListChanged extends HomeState {
  const HomePageItemListChanged({itemList = const <String>[]})
      : super(itemList: itemList);

  @override
  List<Object> get props => [itemList];
}

class HomePageError extends HomeState {
  final String message;

  const HomePageError({this.message = '', itemList = const <String>[]})
      : super(itemList: itemList);

  @override
  List<Object> get props => [message, itemList];
}
