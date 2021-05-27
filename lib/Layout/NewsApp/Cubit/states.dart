abstract class NewState {}

class NewsInitializeState extends NewState {}

class NewsBottomBarState extends NewState {}

class NewsBusinessLoadingState extends NewState {}

class NewsBusinessSuccessState extends NewState {}

class NewsBusinessErrorState extends NewState {
  final String error;

  NewsBusinessErrorState(this.error);
}

class NewsSportLoadingState extends NewState {}

class NewsSportSuccessState extends NewState {}

class NewsSportErrorState extends NewState {
  final String error;

  NewsSportErrorState(this.error);
}

class NewsScienceLoadingState extends NewState {}

class NewsScienceSuccessState extends NewState {}

class NewsScienceErrorState extends NewState {
  final String error;

  NewsScienceErrorState(this.error);
}

class NewsSearchLoadingState extends NewState {}

class NewsSearchSuccessState extends NewState {}

class NewsSearchErrorState extends NewState {
  final String error;

  NewsSearchErrorState(this.error);
}


class NewsTechnologyLoadingState extends NewState {}

class NewsTechnologySuccessState extends NewState {}

class NewsTechnologyErrorState extends NewState {
  final String error;

  NewsTechnologyErrorState(this.error);
}