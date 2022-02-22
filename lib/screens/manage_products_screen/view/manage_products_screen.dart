import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/common/common_button_widget.dart';
import 'package:flutter_task/common/common_text_form_field_widget.dart';
import 'package:flutter_task/screens/add_product_screen/view/add_product_screen.dart';
import 'package:flutter_task/screens/manage_products_screen/provider/manage_products_screen_provider.dart';
import 'package:flutter_task/screens/manage_products_screen/widgets/products_list_widget.dart';
import 'package:flutter_task/screens/manage_products_screen/widgets/search_product_list_widget.dart';
import 'package:provider/provider.dart';
import '../widgets/empty_list_widget.dart';
import '../widgets/loading_widget.dart';

class ManageProductsScreen extends StatefulWidget {
  const ManageProductsScreen({Key? key}) : super(key: key);

  @override
  _ManageProductsScreenState createState() => _ManageProductsScreenState();
}

class _ManageProductsScreenState extends State<ManageProductsScreen> {
  // Init State
  // Here I have added Listener for search text form field to get real time updates
  // Managing Search widget according to text field listener
  @override
  void initState() {
    var myProvider = Provider.of<ManageProductsScreenProvider>(context, listen: false);
    myProvider.mSearchController.addListener(() {
      if (myProvider.mSearchController.text.isEmpty) {
        myProvider.hideSearchWidget();
      } else {
        myProvider.searchProductFromList(searchText: myProvider.mSearchController.text);
      }
    });
    myProvider.fetchProductsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ManageProductsScreenProvider>(
      builder: (context, _provider, child) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          extendBody: true,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            elevation: 0,
            title: const Text("Manage Products"),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: CommonTextFormFieldWidget(
                mTextEditingController: _provider.mSearchController,
                mCurrentFocusNode: _provider.mSearchNode,
                mNextFocusNode: _provider.mSearchNode,
                mTextInputType: TextInputType.text,
                mListOfInputFormatters: [],
                mTextInputAction: TextInputAction.search,
                mValidator: (value) {},
                mOnSubmit: (value) {
                  _provider.mSearchNode.unfocus();
                },
                mHintText: "Search product",
                mSuffixWidget: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: IconButton(
                    onPressed: () {
                      FocusScope.of(context).requestFocus(_provider.mSearchNode);
                    },
                    icon: const Icon(CupertinoIcons.search, size: 20),
                  ),
                ),
              ),
            ),
          ),
          body: _provider.mShowLoading
              ? const LoadingWidget()
              : _provider.productsList.isEmpty
                  ? const EmptyListWidget()
                  : _provider.mShowSearchWidget
                      ? const SearchProductListWidget()
                      : const ProductsListWidget(),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CommonButtonWidget(
              mButtonText: "Add Product",
              mOnPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddProductsScreen(),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
