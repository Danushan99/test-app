import 'package:equatable/equatable.dart';
import 'package:order3000_flutter/models/trade_summary_model.dart';


abstract class TradeSummaryState extends Equatable {
  const TradeSummaryState();

  @override
  List<Object?> get props => [];
}

class TradeSummaryInitial extends TradeSummaryState {}

class TradeSummaryLoading extends TradeSummaryState {}

class TradeSummaryLoaded extends TradeSummaryState {
  final List<TradeSummary> summaries;

  const TradeSummaryLoaded(this.summaries);

  @override
  List<Object?> get props => [summaries];
}

class TradeSummaryError extends TradeSummaryState {
  final String message;

  const TradeSummaryError(this.message);

  @override
  List<Object?> get props => [message];
}
