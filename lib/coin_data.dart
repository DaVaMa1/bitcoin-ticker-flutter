import 'dart:convert';

import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<CurrencyExchangeRate> getExchangeRate(String selectedCurrency) {
    return http
        .get(
            'https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC$selectedCurrency')
        .then((response) {
      return CurrencyExchangeRate.fromJson(json.decode(response.body));
    });
  }
}

class CurrencyExchangeRate {
  double ask;
  double bid;
  double last;
  double high;
  double low;
  Open open;
  Averages averages;
  double volume;
  Changes changes;
  double volumePercent;
  int timestamp;
  String displayTimestamp;

  CurrencyExchangeRate(
      {this.ask,
      this.bid,
      this.last,
      this.high,
      this.low,
      this.open,
      this.averages,
      this.volume,
      this.changes,
      this.volumePercent,
      this.timestamp,
      this.displayTimestamp});

  CurrencyExchangeRate.fromJson(Map<String, dynamic> json) {
    ask = json['ask'];
    bid = json['bid'];
    last = json['last'];
    high = json['high'];
    low = json['low'];
    open = json['open'] != null ? new Open.fromJson(json['open']) : null;
    averages = json['averages'] != null
        ? new Averages.fromJson(json['averages'])
        : null;
    volume = json['volume'];
    changes =
        json['changes'] != null ? new Changes.fromJson(json['changes']) : null;
    volumePercent = json['volume_percent'];
    timestamp = json['timestamp'];
    displayTimestamp = json['display_timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ask'] = this.ask;
    data['bid'] = this.bid;
    data['last'] = this.last;
    data['high'] = this.high;
    data['low'] = this.low;
    if (this.open != null) {
      data['open'] = this.open.toJson();
    }
    if (this.averages != null) {
      data['averages'] = this.averages.toJson();
    }
    data['volume'] = this.volume;
    if (this.changes != null) {
      data['changes'] = this.changes.toJson();
    }
    data['volume_percent'] = this.volumePercent;
    data['timestamp'] = this.timestamp;
    data['display_timestamp'] = this.displayTimestamp;
    return data;
  }
}

class Open {
  double day;
  double week;
  double month;

  Open({this.day, this.week, this.month});

  Open.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    week = json['week'];
    month = json['month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['week'] = this.week;
    data['month'] = this.month;
    return data;
  }
}

class Averages {
  double daily;
  double weekly;
  double monthly;

  Averages({this.daily, this.weekly, this.monthly});

  Averages.fromJson(Map<String, dynamic> json) {
    daily = json['daily'];
    weekly = json['weekly'];
    monthly = json['monthly'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['daily'] = this.daily;
    data['weekly'] = this.weekly;
    data['monthly'] = this.monthly;
    return data;
  }
}

class Changes {
  Price price;
  Percent percent;

  Changes({this.price, this.percent});

  Changes.fromJson(Map<String, dynamic> json) {
    price = json['price'] != null ? new Price.fromJson(json['price']) : null;
    percent =
        json['percent'] != null ? new Percent.fromJson(json['percent']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.price != null) {
      data['price'] = this.price.toJson();
    }
    if (this.percent != null) {
      data['percent'] = this.percent.toJson();
    }
    return data;
  }
}

class Price {
  double weekly;
  double monthly;
  double daily;

  Price({this.weekly, this.monthly, this.daily});

  Price.fromJson(Map<String, dynamic> json) {
    weekly = json['weekly'];
    monthly = json['monthly'];
    daily = json['daily'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['weekly'] = this.weekly;
    data['monthly'] = this.monthly;
    data['daily'] = this.daily;
    return data;
  }
}

class Percent {
  double weekly;
  double monthly;
  double daily;

  Percent({this.weekly, this.monthly, this.daily});

  Percent.fromJson(Map<String, dynamic> json) {
    weekly = json['weekly'];
    monthly = json['monthly'];
    daily = json['daily'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['weekly'] = this.weekly;
    data['monthly'] = this.monthly;
    data['daily'] = this.daily;
    return data;
  }
}
