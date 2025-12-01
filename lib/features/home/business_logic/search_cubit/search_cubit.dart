// Package imports:
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<bool> {
  SearchCubit() :  super(false);

  void search() => emit(!state);
}
