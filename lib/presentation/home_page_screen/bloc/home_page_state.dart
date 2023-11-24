// ignore_for_file: must_be_immutable

part of 'home_page_bloc.dart';

/// Represents the state of HomePage in the application.
class HomePageState {}

class HomeDataState extends HomePageState {
  final HomeData homeData;
  HomeDataState(this.homeData);
}

class HomeLoadingState extends HomePageState {}

class HomeErrorState extends HomePageState {
  final String error;
  HomeErrorState(this.error);
}
