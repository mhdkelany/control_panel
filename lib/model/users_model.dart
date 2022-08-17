class UsersModel
{
  List<UsersInformation> userInformation=[];
  UsersModel.fromJson(dynamic json)
  {
    json.forEach((element){
      userInformation.add(UsersInformation.fromJson(element));
    });
  }
}
class UsersInformation
{
  String? idUser;
  String? name;
  var status;
  String? phone;
  String? address;
  String? userType;
  UsersInformation.fromJson(dynamic json)
  {
    idUser=json['id_user'];
    name=json['name'];
    phone=json['phone'];
    address=json['address'];
    userType=json['user_type'];
    status=json['state'];
  }
}