class WishModel
{
  List<WishInformation> wishes=[];
  WishModel.fromJson(dynamic json)
  {
    json.forEach((element) {
      wishes.add(WishInformation.fromJson(element));
    });
  }
}
class WishInformation
{
  String? idWish;
  String? phone;
  String? lat;
  String? lng;
  String? name;
  String? wish;
  WishInformation.fromJson(Map<String,dynamic> json)
  {
    phone=json['phone'];
    lat=json['lat'];
    lng=json['lng'];
    name=json['username'];
    wish=json['wish'];
    idWish=json['id_wish'];
  }
}