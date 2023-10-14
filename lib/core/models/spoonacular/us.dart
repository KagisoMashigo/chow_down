class Us {
  final double amount;
  final String? unitShort;
  final String? unitLong;

  Us({
    required this.amount,
    this.unitShort,
    this.unitLong,
  });

  factory Us.fromJson(json) => Us(
        amount: (json['amount'] as num).toDouble(),
        unitShort: json['unitShort'] as String,
        unitLong: json['unitLong'] as String,
      );

  toJson() => {
        'amount': amount,
        'unitShort': unitShort,
        'unitLong': unitLong,
      };
}
