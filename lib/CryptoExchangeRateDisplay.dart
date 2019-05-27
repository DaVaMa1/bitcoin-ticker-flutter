import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'coin_data.dart';

class CryptoExchangeRateDisplay extends StatefulWidget {
  CryptoExchangeRateDisplay(this.exchangeRate);

  final ExchangeRate exchangeRate;

  @override
  _CryptoExchangeRateDisplayState createState() =>
      _CryptoExchangeRateDisplayState();
}

class _CryptoExchangeRateDisplayState extends State<CryptoExchangeRateDisplay> {
  @override
  initState() {
    super.initState();
    setRates();
  }

  setRates() async {
    var newRate = await CoinData().getExchangeRate(
        widget.exchangeRate.getCurrency(), widget.exchangeRate.getCrypto());
    widget.exchangeRate.setSelectedCurrency(widget.exchangeRate.getCurrency());
    widget.exchangeRate.setRate(newRate.last.toString());
  }

  @override
  Widget build(BuildContext context) {
    final rate = Provider.of<ExchangeRateList>(context)
        .getRate(widget.exchangeRate.getCrypto());
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '${widget.exchangeRate.getCrypto()} = ${rate.getRate()} ${rate.getCurrency()}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class ExchangeRateList with ChangeNotifier {
  List<ExchangeRate> _rates = List<ExchangeRate>();

  void addRate(ExchangeRate rate) {
    _rates.add(rate);
    notifyListeners();
  }

  void modifyRate(String exchangeRate, String crypto) {
    final rate = _rates.firstWhere((element) => element.getCrypto() == crypto,
        orElse: () {
      return;
    });
    rate.setRate(exchangeRate);
    notifyListeners();
  }

  void setSelectedCurrency(String currency, String crypto){
    final rate = _rates.firstWhere((element) => element.getCrypto() == crypto,
        orElse: () {
          return;
        });
    rate.setSelectedCurrency(currency);
    notifyListeners();
  }

  ExchangeRate getRate(String rate) {
    return _rates.firstWhere((element) => element.getCrypto() == rate,
        orElse: () {
      return;
    });
  }
}

class ExchangeRate {
  String _exchangeRate;
  final String _crypto;
  String _selectedCurrency;

  ExchangeRate(this._exchangeRate, this._crypto, this._selectedCurrency);

  getRate() => _exchangeRate;

  String getCrypto() => _crypto;

  getCurrency() => _selectedCurrency;

  setRate(String value) {
    _exchangeRate = value;
  }

  setSelectedCurrency(String value) {
    _selectedCurrency = value;
  }
}
