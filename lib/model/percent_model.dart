class PercentModel
{
  bool? status;
  List<Data> data=[];
  PercentModel.fromJson(dynamic json)
  {
    status=json['state'];
    json['data'].forEach((element){
      data.add(Data.fromJson(element));
    });
  }
}
class Data
{
  String? idProduct;
  String? name;
  String? priceBeforePercent;
  String? priceAfterPercent;
  String? percent;
  Data.fromJson(dynamic json)
  {
    idProduct=json['id_pro'];
    name=json['name'];
    priceBeforePercent=json['price_before'];
    priceAfterPercent=json['price_after'];
    percent=json['percent'];
  }
}