class TradeSummary {
  final String symbol;
  final double price;
  final int volume; // will store tradevolume
  final double change;

  TradeSummary({
    required this.symbol,
    required this.price,
    required this.volume,
    required this.change,
  });

  factory TradeSummary.fromJson(Map<String, dynamic> json) {
    return TradeSummary(
      symbol: json['symbol'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      volume: (json['tradevolume'] ?? 0).toInt(), // correct field
      change: (json['change'] ?? 0).toDouble(),
    );
  }
}
