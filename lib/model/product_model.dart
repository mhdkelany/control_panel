class AllProductsModel
{
  bool? status;
  String? message;
  List<InformationProducts> info=[];
  AllProductsModel.fromJson(dynamic json)
  {
    status=json['state'];
    message=json['message'];
    json['product'].forEach((element){
      info.add(InformationProducts.fromJson(element));
    });
  }
}

class ProductModel
{
  List<InformationProduct> information=[];
  ProductModel.fromJson(dynamic json)
  {
    json.forEach((element){
      information.add(InformationProduct.fromJson(element));
    });
  }
}
class InformationProduct
{
  String? idProduct;
  String? productName;
  String? quantity;
  String? price;
  int? percent;
  String? pricePercent;
  String? image;
  String? userName;
  String? longDescription;
  String? shortDescription;
  InformationProduct.fromJson(dynamic json)
  {
    idProduct=json['id_pro'];
    productName=json['name'];
    quantity=json['quantity'];
    price=json['price'];
    image=json['img'];
    userName=json['username'];
    longDescription=json['long_description'];
    shortDescription=json['short_description'];
    if(json['percent']!=null)
      percent=json['percent'];
    if(json['price_percent']!=null)
      pricePercent=json['price_percent'];
  }
}

class InformationProducts
{
  String? idProduct;
  String? productName;
  String? quantity;
  dynamic? price;
  int? percent;
  dynamic? pricePercent;
  String? image;
  String? userName;
  String? longDescription;
  String? shortDescription;
  InformationProducts.fromJson(dynamic json)
  {
    idProduct=json['id_pro'];
    productName=json['name'];
    quantity=json['quantity'];
    price=json['price'];
    image=json['img'];
    userName=json['username'];
    longDescription=json['long_description'];
    shortDescription=json['short_description'];
    if(json['percent']!=null)
      percent=json['percent'];
    if(json['price_percent']!=null)
      pricePercent=json['price_percent'];
  }
}