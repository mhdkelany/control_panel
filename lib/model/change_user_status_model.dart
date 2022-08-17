class ChangeUserStatusModel
{
  bool? status;
  String? message;
  ChangeUserStatusModel.fromJson(dynamic json)
  {
    status=json['state'];
    message=json['message'];
  }
}