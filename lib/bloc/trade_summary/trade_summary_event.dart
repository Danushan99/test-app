import 'package:equatable/equatable.dart';

abstract class TradeSummaryEvent extends Equatable {
  const TradeSummaryEvent();

  @override
  List<Object> get props => [];
}

class LoadTradeSummary extends TradeSummaryEvent {}
