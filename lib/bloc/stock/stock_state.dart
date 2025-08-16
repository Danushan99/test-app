import 'package:equatable/equatable.dart';
import 'package:order3000_flutter/models/stock_model.dart';


abstract class StockState extends Equatable {
  @override
  List<Object?> get props => [];
}

class StockInitial extends StockState {}

class StockLoading extends StockState {}

class StockLoaded extends StockState {
  final Stock stock;
  StockLoaded(this.stock);

  @override
  List<Object?> get props => [stock];
}

class StockError extends StockState {
  final String message;
  StockError(this.message);

  @override
  List<Object?> get props => [message];
}
