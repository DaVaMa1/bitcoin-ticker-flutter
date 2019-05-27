import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = currenciesList.first;
  List<Widget> cryptos = List<Widget>();

  @override
  initState() {
    super.initState();
    setState(() {
      cryptos.addAll(
        cryptoList.map((crypto) {
          return CryptoExchangeRateDisplay(
            crypto,
            selectedCurrency: selectedCurrency,
            selectedCurrencyExchangeRate: '?',
          );
        }),
      );
      cryptos.add(Container(
        height: 150.0,
        alignment: Alignment.center,
        padding: EdgeInsets.only(bottom: 30.0),
        color: Colors.lightBlue,
        child: Platform.isAndroid ? getDropDown() : getPicker(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: cryptos,
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
          });
        });
  }
}

class CryptoExchangeRateDisplay extends StatefulWidget {
  CryptoExchangeRateDisplay(
    this.crypto, {
    this.selectedCurrencyExchangeRate,
    this.selectedCurrency,
  });

  final String selectedCurrencyExchangeRate;
  final String selectedCurrency;
  final String crypto;

  @override
  _CryptoExchangeRateDisplayState createState() =>
      _CryptoExchangeRateDisplayState(
          selectedCurrencyExchangeRate, selectedCurrency);
}

class _CryptoExchangeRateDisplayState extends State<CryptoExchangeRateDisplay> {
  String selectedCurrencyExchangeRate;
  String selectedCurrency;

  _CryptoExchangeRateDisplayState(
      this.selectedCurrencyExchangeRate, this.selectedCurrency);

  @override
  Widget build(BuildContext context) {
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
            '${widget.crypto} = $selectedCurrencyExchangeRate $selectedCurrency',
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
