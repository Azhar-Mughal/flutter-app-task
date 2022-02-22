import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/manage_products_screen_provider.dart';

class SearchProductListWidget extends StatelessWidget {
  const SearchProductListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ManageProductsScreenProvider>(
      builder: (context, _provider, child) {
        return ListView.separated(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _provider.searchedProductsList[index].productName!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        _provider.searchedProductsList[index].productDescription!,
                        style: const TextStyle(fontSize: 14.0),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        _provider.searchedProductsList[index].productPrice! + " K.D",
                        style: const TextStyle(
                          color: Color(0xfffd7272),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 10);
          },
          itemCount: _provider.searchedProductsList.length,
        );
      },
    );
  }
}
