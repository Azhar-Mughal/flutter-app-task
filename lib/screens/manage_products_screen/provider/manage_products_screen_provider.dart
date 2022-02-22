import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_task/screens/manage_products_screen/models/product_model.dart';
import 'package:flutter_task/services/shared_preferences_service.dart';

class ManageProductsScreenProvider extends ChangeNotifier {
  // Text editing controller and focus node for search text field
  TextEditingController mSearchController = TextEditingController();
  FocusNode mSearchNode = FocusNode();

  //List variables
  late List<ProductModel> productsList = [];
  late List<ProductModel> searchedProductsList = [];

  // Bool variables
  bool mShowSearchWidget = false;
  bool mShowLoading = true;

  // Fetching products list from shared preferences
  fetchProductsList() async {
    await sharedPreferenceService.getSharedPreferencesInstance();
    var response = await sharedPreferenceService.getProductsListData();
    if (response != null) {
      var listResponse = jsonDecode(response);
      final Iterable list = listResponse;
      productsList = list.map((e) => ProductModel.fromJson(e)).toList();
      mShowLoading = false;
      notifyListeners();
    }
    mShowLoading = false;
    notifyListeners();
  }

  // Updating product list after inserting a new item on top
  updateProductList({required ProductModel productModel}) {
    productsList.insert(0, productModel);
    notifyListeners();
  }

  // Hide search widget on empty text
  hideSearchWidget() {
    mShowSearchWidget = false;
    notifyListeners();
  }

  //Searching product from products list
  // Filtering on product Name, product Description, Product Price
  searchProductFromList({required String searchText}) {
    searchedProductsList.clear();
    mShowSearchWidget = true;
    notifyListeners();

    for (int i = 0; i < productsList.length; i++) {
      if (productsList[i].productName!.toLowerCase().contains(searchText.toLowerCase()) ||
          productsList[i].productDescription!.toLowerCase().contains(searchText.toLowerCase()) ||
          productsList[i].productPrice!.toLowerCase().contains(searchText.toLowerCase())) {
        searchedProductsList.add(productsList[i]);
        notifyListeners();
      } else {}
    }
  }
}
