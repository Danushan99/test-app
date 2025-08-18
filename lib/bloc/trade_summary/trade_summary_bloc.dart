import 'package:flutter_bloc/flutter_bloc.dart';
import 'trade_summary_event.dart';
import 'trade_summary_state.dart';
import '../../repo/trade_summary_repository.dart';

class TradeSummaryBloc extends Bloc<TradeSummaryEvent, TradeSummaryState> {
  final TradeSummaryRepository repository;

  TradeSummaryBloc({required this.repository}) : super(TradeSummaryLoading()) {
    on<LoadTradeSummary>((event, emit) async {
      emit(TradeSummaryLoading());
      try {
        final summaries = await repository.fetchTradeSummary();
        emit(TradeSummaryLoaded(summaries));
      } catch (e) {
        emit(TradeSummaryError('Failed to load trade summary'));
      }
    });
  }
}
