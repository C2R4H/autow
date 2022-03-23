import 'dart:convert';
import 'package:flutter/services.dart';

class Brands{
  Future<List> readBrands() async {
    final response = await rootBundle.loadString('assets/automobile_data/brands.json');
    final data = await json.decode(response);
    return data['RECORDS'];
  }
}

