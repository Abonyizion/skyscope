
abstract class CitySearchState {}

class SearchInitial extends CitySearchState {}

class SearchLoading extends CitySearchState {}

class SearchLoaded extends CitySearchState {
  final List<Map<String, dynamic>> results;
  SearchLoaded(this.results);
}

class SearchError extends CitySearchState {
  final String message;
  SearchError(this.message);
}
