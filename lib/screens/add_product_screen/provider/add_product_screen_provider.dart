import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/shared_preferences_service.dart';
import '../../manage_products_screen/models/product_model.dart';
import '../../manage_products_screen/provider/manage_products_screen_provider.dart';

class AddProductsScreenProvider extends ChangeNotifier {
  // Text Editing Controllers
  TextEditingController mProductNameController = TextEditingController();
  TextEditingController mProductDescController = TextEditingController();
  TextEditingController mProductPriceController = TextEditingController();

  //Focus nodes for text editing controllers
  FocusNode mProductNameFocusNode = FocusNode();
  FocusNode mProductDescFocusNode = FocusNode();
  FocusNode mProductPriceFocusNode = FocusNode();

  // Button enable/disable status
  bool enableButton = false;

  // Add a new product via text fields
  // Check available products and then add this new product in available list
  addNewProduct({required BuildContext context}) async {
    late List<ProductModel> productsList = [];
    await sharedPreferenceService.getSharedPreferencesInstance();
    var response = await sharedPreferenceService.getProductsListData();
    if (response != null) {
      var listResponse = jsonDecode(response);
      final Iterable list = listResponse;
      productsList = list.map((e) => ProductModel.fromJson(e)).toList();
    }

    productsList.add(
      ProductModel(
        productPrice: mProductPriceController.text,
        productDescription: mProductDescController.text,
        productName: mProductNameController.text,
      ),
    );
    await sharedPreferenceService.saveProductsListData(productList: productsList);
    var myProvider = Provider.of<ManageProductsScreenProvider>(context, listen: false);
    myProvider.updateProductList(
      productModel: ProductModel(
        productPrice: mProductPriceController.text,
        productDescription: mProductDescController.text,
        productName: mProductNameController.text,
      ),
    );
    mProductNameController.clear();
    mProductDescController.clear();
    mProductPriceController.clear();
    notifyListeners();
    _showSuccessSnackBar(context: context);
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
    });
  }

  // Show Success SnackBar
  _showSuccessSnackBar({required BuildContext context}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          '✔ Product was added successfully',
          style: TextStyle(
            color: Colors.green,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 80),
      ),
    );
  }
}
