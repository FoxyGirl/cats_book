import 'dart:async';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:cats_book/import.dart';

part 'start.g.dart';

class StartCubit extends Cubit<StartState> {
  StartCubit(this.repository)
      : assert(repository != null),
        super(StartState());

  final DatabaseRepository repository;

  Future<void> load({CategoryKey categoryId}) async {
    if (state.status == StartStatus.loading) return;
    emit(state.copyWith(
      status: StartStatus.loading,
    ));
    try {
      final categories = await repository.readCategories();
      final units =
          await repository.readNewestUnits(limit: kShowcaseNewestUnitsLimit);

      emit(StartState());
      await Future.delayed(Duration(milliseconds: 300));
      emit(state.copyWith(
        categories: categories,
        units: units,
      ));
    } on Exception {
      out('error');
    } finally {
      emit(state.copyWith(
        status: StartStatus.ready,
      ));
    }
  }
}

enum StartStatus { initial, loading, ready }

@CopyWith()
class StartState extends Equatable {
  StartState({
    this.categories = const [],
    this.units = const [],
    this.status = StartStatus.initial,
  });

  final List<CategoryModel> categories;
  final List<UnitModel> units;
  final StartStatus status;

  @override
  List<Object> get props => [
        categories,
        units,
        status,
      ];
}
