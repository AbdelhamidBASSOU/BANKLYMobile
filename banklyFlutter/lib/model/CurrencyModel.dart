enum Currency {
  USD,
  EUR,
  GBP,
  JPY,
  CHF,
  AUD,
  CAD,
  HKD,
}

class CurrencyModel {
  final int id;
  final String name;

  CurrencyModel({
    required this.id,
    required this.name,
  });

  factory CurrencyModel.fromEnum(Currency currency) {
    switch (currency) {
      case Currency.USD:
        return CurrencyModel(id: 1, name: 'USD');
      case Currency.EUR:
        return CurrencyModel(id: 2, name: 'EUR');
      case Currency.GBP:
        return CurrencyModel(id: 3, name: 'GBP');
      case Currency.JPY:
        return CurrencyModel(id: 4, name: 'JPY');
      case Currency.CHF:
        return CurrencyModel(id: 5, name: 'CHF');
      case Currency.AUD:
        return CurrencyModel(id: 6, name: 'AUD');
      case Currency.CAD:
        return CurrencyModel(id: 7, name: 'CAD');
      case Currency.HKD:
        return CurrencyModel(id: 8, name: 'HKD');
      default:
        throw Exception('Unknown currency: $currency');
    }
  }
}
