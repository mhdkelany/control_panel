class AllBillModel
{
  List<Information> information=[];
  AllBillModel.fromJson(dynamic json)
  {
    json.forEach((element){
      information.add(Information.fromJson(element));
    });
  }
}
class Information
{
  String? idUser;
  String? idBill;
  String? date;
  String? productOwnerName;
  String? billOwnerName;
  String? total;
  Information.fromJson(dynamic json)
  {
    idUser=json['id_user'];
    idBill=json['id_bill'];
    date=json['creation_date'];
    productOwnerName=json['username_product'];
    billOwnerName=json['user_name_bill'];
    total=json['total'];
  }
}