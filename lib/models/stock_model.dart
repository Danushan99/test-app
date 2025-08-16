class Stock {
  final int id;
  final String symbol;
  final String name;
  final String? issueDate;
  final int? quantityIssued;
  final double? parValue;
  final double? issuedPrice;
  final double? lastPrice;

  // High / Low prices
  final double? wtdHiPrice;
  final double? mtdHiPrice;
  final double? ytdHiPrice;
  final double? p12HiPrice;
  final double? allHiPrice;

  final double? wtdLowPrice;
  final double? mtdLowPrice;
  final double? ytdLowPrice;
  final double? p12LowPrice;
  final double? allLowPrice;

  // Volume
  final int? tdyShareVolume;
  final int? wdyShareVolume;
  final int? mtdShareVolume;
  final int? ytdShareVolume;
  final int? p12ShareVolume;

  // Turnover
  final double? tdyTurnover;
  final double? wtdTurnover;
  final double? mtdTurnover;
  final double? ytdTurnover;
  final double? p12Turnover;

  // Beta
  final double? triASIBetaValue;
  final double? betaValueSPSL;
  final String? triASIBetaPeriod;
  final int? quarter;

  // Logos
  final String? logoPath;
  final String? tagsLogoPath;

  Stock({
    required this.id,
    required this.symbol,
    required this.name,
    this.issueDate,
    this.quantityIssued,
    this.parValue,
    this.issuedPrice,
    this.lastPrice,
    this.wtdHiPrice,
    this.mtdHiPrice,
    this.ytdHiPrice,
    this.p12HiPrice,
    this.allHiPrice,
    this.wtdLowPrice,
    this.mtdLowPrice,
    this.ytdLowPrice,
    this.p12LowPrice,
    this.allLowPrice,
    this.tdyShareVolume,
    this.wdyShareVolume,
    this.mtdShareVolume,
    this.ytdShareVolume,
    this.p12ShareVolume,
    this.tdyTurnover,
    this.wtdTurnover,
    this.mtdTurnover,
    this.ytdTurnover,
    this.p12Turnover,
    this.triASIBetaValue,
    this.betaValueSPSL,
    this.triASIBetaPeriod,
    this.quarter,
    this.logoPath,
    this.tagsLogoPath,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    final symbolInfo = json['reqSymbolInfo'] ?? {};
    final betaInfo = json['reqSymbolBetaInfo'] ?? {};
    final logoInfo = json['reqLogo'] ?? {};
    final tagLogoInfo = json['reqTagsLogo'] ?? {};

    return Stock(
      id: symbolInfo['id'] ?? 0,
      symbol: symbolInfo['symbol'] ?? '',
      name: symbolInfo['name'] ?? '',
      issueDate: symbolInfo['issueDate'],
      quantityIssued: symbolInfo['quantityIssued'],
      parValue: (symbolInfo['parValue'] != null)
          ? (symbolInfo['parValue'] as num).toDouble()
          : null,
      issuedPrice: (symbolInfo['issuedPrice'] != null)
          ? (symbolInfo['issuedPrice'] as num).toDouble()
          : null,
      lastPrice: (symbolInfo['lastTradedPrice'] != null)
          ? (symbolInfo['lastTradedPrice'] as num).toDouble()
          : null,
      wtdHiPrice: (symbolInfo['wtdHiPrice'] != null)
          ? (symbolInfo['wtdHiPrice'] as num).toDouble()
          : null,
      mtdHiPrice: (symbolInfo['mtdHiPrice'] != null)
          ? (symbolInfo['mtdHiPrice'] as num).toDouble()
          : null,
      ytdHiPrice: (symbolInfo['ytdHiPrice'] != null)
          ? (symbolInfo['ytdHiPrice'] as num).toDouble()
          : null,
      p12HiPrice: (symbolInfo['p12HiPrice'] != null)
          ? (symbolInfo['p12HiPrice'] as num).toDouble()
          : null,
      allHiPrice: (symbolInfo['allHiPrice'] != null)
          ? (symbolInfo['allHiPrice'] as num).toDouble()
          : null,
      wtdLowPrice: (symbolInfo['wtdLowPrice'] != null)
          ? (symbolInfo['wtdLowPrice'] as num).toDouble()
          : null,
      mtdLowPrice: (symbolInfo['mtdLowPrice'] != null)
          ? (symbolInfo['mtdLowPrice'] as num).toDouble()
          : null,
      ytdLowPrice: (symbolInfo['ytdLowPrice'] != null)
          ? (symbolInfo['ytdLowPrice'] as num).toDouble()
          : null,
      p12LowPrice: (symbolInfo['p12LowPrice'] != null)
          ? (symbolInfo['p12LowPrice'] as num).toDouble()
          : null,
      allLowPrice: (symbolInfo['allLowPrice'] != null)
          ? (symbolInfo['allLowPrice'] as num).toDouble()
          : null,
      tdyShareVolume: symbolInfo['tdyShareVolume'],
      wdyShareVolume: symbolInfo['wdyShareVolume'],
      mtdShareVolume: symbolInfo['mtdShareVolume'],
      ytdShareVolume: symbolInfo['ytdShareVolume'],
      p12ShareVolume: symbolInfo['p12ShareVolume'],
      tdyTurnover: (symbolInfo['tdyTurnover'] != null)
          ? (symbolInfo['tdyTurnover'] as num).toDouble()
          : null,
      wtdTurnover: (symbolInfo['wtdTurnover'] != null)
          ? (symbolInfo['wtdTurnover'] as num).toDouble()
          : null,
      mtdTurnover: (symbolInfo['mtdTurnover'] != null)
          ? (symbolInfo['mtdTurnover'] as num).toDouble()
          : null,
      ytdTurnover: (symbolInfo['ytdTurnover'] != null)
          ? (symbolInfo['ytdTurnover'] as num).toDouble()
          : null,
      p12Turnover: (symbolInfo['p12Turnover'] != null)
          ? (symbolInfo['p12Turnover'] as num).toDouble()
          : null,
      triASIBetaValue: (betaInfo['triASIBetaValue'] != null)
          ? (betaInfo['triASIBetaValue'] as num).toDouble()
          : null,
      betaValueSPSL: (betaInfo['betaValueSPSL'] != null)
          ? (betaInfo['betaValueSPSL'] as num).toDouble()
          : null,
      triASIBetaPeriod: betaInfo['triASIBetaPeriod'],
      quarter: betaInfo['quarter'],
      logoPath: logoInfo['path'],
      tagsLogoPath: tagLogoInfo['path'],
    );
  }
}
