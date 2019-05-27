import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;

import 'CryptoExchangeRateDisplay.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = currenciesList.first;

  @override
  Widget build(BuildContext context) {
    var widgets = List<Widget>();
    var list = Provider.of<ExchangeRateList>(context);
    cryptoList.forEach((crypto) {
      widgets.add(
        CryptoExchangeRateDisplay(list.getRate(crypto)),
      );
    });

    widgets.add(Container(
      height: 150.0,
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 30.0),
      color: Colors.lightBlue,
      child: Platform.isAndroid ? getDropDown() : getPicker(),
    ));

    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: widgets,
      ),
    );
  }

  CupertinoPicker getPicker() {
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (index) {
        setState(() {
          selectedCurrency = currenciesList[index];
        });
      },
      children: currenciesList.map((f) => Text(f)).toList(),
    );
  }

  DropdownButton<String> getDropDown() {
    return DropdownButton(
        value: selectedCurrency,
        items: currenciesList
            .map((f) => DropdownMenuItem(
                  child: Text(f),
                  value: f,
                ))
            .toList(),
        onChanged: (value) {
          setState(() {
            selectedCurrency = value;
            var list = Provider.of<ExchangeRateList>(context);
            cryptoList.forEach((crypto) {
              list.modifyRate('?', crypto);
              list.setSelectedCurrency(value, crypto);
            });
            Future.forEach(cryptoList, (crypto) async {
              var newRate = await CoinData().getExchangeRate(value, crypto);
              list.modifyRate(newRate.last.toString(), crypto);
            });
          });
        });
  }
}
