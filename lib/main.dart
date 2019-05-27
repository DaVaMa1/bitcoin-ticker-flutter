import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'CryptoExchangeRateDisplay.dart';
import 'coin_data.dart';
import 'price_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Map<String, String> cryptoMap =
      Map.fromIterable(cryptoList, key: (v) => v.toString(), value: (v) => '?');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.lightBlue,
          scaffoldBackgroundColor: Colors.white),
      home: ChangeNotifierProvider<ExchangeRateList>(
        child: PriceScreen(),
        builder: (_) {
          var list = ExchangeRateList();
          cryptoMap.forEach(
            (name, exchangeRate) {
              list.addRate(ExchangeRate(exchangeRate, name, currenciesList.first));
            },
          );
          return list;
        },
      ),
    );
  }
}
