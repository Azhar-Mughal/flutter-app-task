class ProductModel {
  String? productName;
  String? productDescription;
  String? productPrice;

  ProductModel({this.productName, this.productDescription, this.productPrice});

  ProductModel.fromJson(Map<String, dynamic> json) {
    productName = json['productName'];
    productDescription = json['productDescription'];
    productPrice = json['productPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productName'] = this.productName;
    data['productDescription'] = this.productDescription;
    data['productPrice'] = this.productPrice;
    return data;
  }
}