import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order3000_flutter/repo/stock_repository.dart';

import 'stock_event.dart';
import 'stock_state.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  final StockRepository repository;

  StockBloc({required this.repository}) : super(StockInitial()) {
    on<FetchStock>((event, emit) async {
      emit(StockLoading());
      try {
        final stock = await repository.fetchStock(event.symbol);
        emit(StockLoaded(stock));
      } catch (e) {
        emit(StockError(e.toString()));
      }
    });
  }
}
