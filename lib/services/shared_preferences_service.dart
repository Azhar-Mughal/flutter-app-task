import 'dart:convert';

import 'package:flutter_task/screens/manage_products_screen/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  late SharedPreferences _prefs;

  Future<bool> getSharedPreferencesInstance() async {
    _prefs = await SharedPreferences.getInstance().catchError((e) {});
    return true;
  }

  //* Storing Products List Data In Preferences
  Future saveProductsListData({required List<ProductModel>? productList}) async {
    print("Encoded Data == ");
    final encodeData = json.encode(productList);
    await _prefs.setString("productListKey", encodeData.toString());
  }

  //* Getting Products List Data From Preferences
  Future getProductsListData() async {
    final productsData = _prefs.getString("productListKey");
    return productsData;
  }
}

SharedPreferenceService sharedPreferenceService = SharedPreferenceService();
