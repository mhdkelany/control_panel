class BillDetailsModel
{
 List<Details> details=[];
 BillDetailsModel.fromJson(dynamic json)
 {
   json.forEach((element){
     details.add(Details.fromJson(element));
   });
 }
}
class Details
{
  String? idUser;
  String? idBill;
  String? date;
  String? productOwnerName;
  String? productOwnerPhone;
  String? productOwnerLat;
  String? productOwnerLng;
  String? billOwnerName;
  String? billOwnerPhone;
  String? billOwnerLat;
  String? billOwnerLng;
  String? idProduct;
  String? productName;
  String? quantity;
  String? price;
  String? sumPrice;
  String? total;
  Details.fromJson(dynamic json)
  {
    idUser=json['id_user'];
    idBill=json['id_bill'];
    date=json['creation_date'];
    productOwnerName=json['username_pro'];
    billOwnerName=json['username_bill'];
    total=json['total'];
    productOwnerPhone=json['phone_pro'];
    productOwnerLat=json['lat_pro'];
    productOwnerLng=json['lng_pro'];
    billOwnerPhone=json['phone_bill'];
    billOwnerLat=json['lat_bill'];
    billOwnerLng=json['lng_bill'];
    idProduct=json['id_pro'];
    productName=json['pro_name'];
    quantity=json['quantity'];
    price=json['price'];
    sumPrice=json['sum'];
  }
}