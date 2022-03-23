import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

class Automobiles{
  Future<List> readBrands() async {
    final response = await rootBundle.loadString('assets/automobile_data/automobiles.json');
    final data = await json.decode(response);
    return data['RECORDS'];
  }
}
