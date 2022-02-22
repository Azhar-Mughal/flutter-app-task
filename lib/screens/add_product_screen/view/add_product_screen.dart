import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_task/common/common_appbar_widget.dart';
import 'package:flutter_task/common/common_button_widget.dart';
import 'package:flutter_task/common/common_text_form_field_widget.dart';
import 'package:flutter_task/screens/add_product_screen/provider/add_product_screen_provider.dart';
import 'package:provider/provider.dart';

class AddProductsScreen extends StatefulWidget {
  const AddProductsScreen({Key? key}) : super(key: key);

  @override
  _AddProductsScreenState createState() => _AddProductsScreenState();
}

class _AddProductsScreenState extends State<AddProductsScreen> {
  //Init State
  // Listening All text form fields and managing button status (Enable/Disable)
  @override
  void initState() {
    var myProvider = Provider.of<AddProductsScreenProvider>(context, listen: false);
    myProvider.mProductNameController.addListener(() {
      if (myProvider.mProductNameController.text.isNotEmpty && myProvider.mProductDescController.text.isNotEmpty && myProvider.mProductPriceController.text.isNotEmpty) {
        myProvider.enableButton = true;
        setState(() {});
      }
    });
    myProvider.mProductDescController.addListener(() {
      if (myProvider.mProductNameController.text.isNotEmpty && myProvider.mProductDescController.text.isNotEmpty && myProvider.mProductPriceController.text.isNotEmpty) {
        myProvider.enableButton = true;
        setState(() {});
      }
    });
    myProvider.mProductPriceController.addListener(() {
      if (myProvider.mProductNameController.text.isNotEmpty && myProvider.mProductDescController.text.isNotEmpty && myProvider.mProductPriceController.text.isNotEmpty) {
        myProvider.enableButton = true;
        setState(() {});
      }
    });
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<AddProductsScreenProvider>(
      builder: (context, _provider, child) {
        return Scaffold(
          appBar: const CommonAppBarWidget(mTitle: "Add product", mShowLeading: true),
          body: Form(
            key: _formKey,
            child: ListView(
              children: [
                const SizedBox(height: 30),
                CommonTextFormFieldWidget(
                  mTextEditingController: _provider.mProductNameController,
                  mCurrentFocusNode: _provider.mProductNameFocusNode,
                  mNextFocusNode: _provider.mProductDescFocusNode,
                  mTextInputType: TextInputType.text,
                  mListOfInputFormatters: [],
                  mTextInputAction: TextInputAction.next,
                  mOnSubmit: (value) {},
                  mHintText: "Product Name",
                  mSuffixWidget: const SizedBox(),
                  mValidator: (value) {
                    if (value == null || value.length < 3) {
                      return 'Product name required at least 3 characters!';
                    }
                    return null;
                  },
                ),
                CommonTextFormFieldWidget(
                  mTextEditingController: _provider.mProductDescController,
                  mCurrentFocusNode: _provider.mProductDescFocusNode,
                  mNextFocusNode: _provider.mProductPriceFocusNode,
                  mTextInputType: TextInputType.text,
                  mListOfInputFormatters: [],
                  mTextInputAction: TextInputAction.next,
                  mOnSubmit: (value) {},
                  mHintText: "Product Description",
                  mSuffixWidget: const SizedBox(),
                  mValidator: (value) {
                    if (value == null || value.length < 3) {
                      return 'Product description required at least 3 characters!';
                    }
                    return null;
                  },
                ),
                CommonTextFormFieldWidget(
                  mTextEditingController: _provider.mProductPriceController,
                  mCurrentFocusNode: _provider.mProductPriceFocusNode,
                  mNextFocusNode: _provider.mProductPriceFocusNode,
                  mTextInputType: const TextInputType.numberWithOptions(decimal: true),
                  mListOfInputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
                  ],
                  mTextInputAction: TextInputAction.done,
                  mOnSubmit: (value) {},
                  mHintText: "Product Price",
                  mValidator: (value) {},
                  mSuffixWidget: const Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text("K.D"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CommonButtonWidget(
                    mButtonText: "Submit",
                    mOnPressed: _provider.enableButton == false
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              _provider.addNewProduct(context: context);
                            }
                          },
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
