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
  }
}