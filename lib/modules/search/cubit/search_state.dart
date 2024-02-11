part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitialState extends SearchState {}

class LoadingSearchState extends SearchState {}

class SuccessSearchState extends SearchState {
  final SearchModel searchModel;

  SuccessSearchState(this.searchModel);
}

class ErrorSearchState extends SearchState {
  final String errorMessage;

  ErrorSearchState(this.errorMessage);
}
