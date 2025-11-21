
abstract class CitySearchEvent {}

class SearchCity extends CitySearchEvent {
  final String query;
  SearchCity(this.query);
}
