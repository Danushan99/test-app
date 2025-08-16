import 'package:equatable/equatable.dart';

abstract class StockEvent extends Equatable {
  const StockEvent();

  @override
  List<Object> get props => [];
}

// Event to fetch stock data by symbol
class FetchStock extends StockEvent {
  final String symbol;

  const FetchStock(this.symbol);

  @override
  List<Object> get props => [symbol];
}
