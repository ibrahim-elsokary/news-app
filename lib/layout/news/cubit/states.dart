abstract class NewsStates {}

class NewsInitState extends NewsStates {}

class NewsChangeBottmNavBar extends NewsStates {}

class NewsGetBusiness extends NewsStates {}

class NewsGetBusinessloading extends NewsStates {}

class NewsGetBusinessError extends NewsStates {
  late final String error;
  NewsGetBusinessError(this.error);
}

class NewsGetSports extends NewsStates {}

class NewsGetSportsloading extends NewsStates {}

class NewsGetSportsError extends NewsStates {
  late final String error;
  NewsGetSportsError(this.error);
}

class NewsGetScince extends NewsStates {}

class NewsGetScinceloading extends NewsStates {}

class NewsGetScinceError extends NewsStates {
  late final String error;
  NewsGetScinceError(this.error);
}

class NewsGetSearch extends NewsStates {}

class NewsGetSearchloading extends NewsStates {}

class NewsGetSearchError extends NewsStates {
  late final String error;
  NewsGetSearchError(this.error);
}

class NewsChangTheme extends NewsStates {}
