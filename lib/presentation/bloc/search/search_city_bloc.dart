import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sky_scope/presentation/bloc/search/search_city_event.dart';
import 'package:sky_scope/presentation/bloc/search/search_city_state.dart';
import '../../../data/repositories/city_search_repository.dart';


class CitySearchBloc extends Bloc<CitySearchEvent, CitySearchState> {
  final CitySearchRepository repository;

  CitySearchBloc({required this.repository}) : super(SearchInitial()) {
    on<SearchCity>(_onSearchCity);
  }

  Future<void> _onSearchCity(
      SearchCity event, Emitter<CitySearchState> emit) async {
    if (event.query.isEmpty) return;

    emit(SearchLoading());

    try {
      final results = await repository.searchCities(event.query);
      emit(SearchLoaded(results));
    } catch (e) {
      emit(SearchError("Error searching cities"));
    }
  }
}
