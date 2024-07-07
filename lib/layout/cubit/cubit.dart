import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:control_panel/layout/cubit/states.dart';
import 'package:control_panel/model/All_bill_model.dart';
import 'package:control_panel/model/bill_details_model.dart';
import 'package:control_panel/model/change_user_status_model.dart';
import 'package:control_panel/model/percent_model.dart';
import 'package:control_panel/model/product_model.dart';
import 'package:control_panel/model/users_model.dart';
import 'package:control_panel/model/wish_model.dart';
import 'package:control_panel/shared/components/constants/contants.dart';
import 'package:control_panel/shared/network/end_point/end_point.dart';
import 'package:control_panel/shared/network/local/cache_helper/cache_helper.dart';
import 'package:control_panel/shared/network/remote/dio_helper/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart'as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ControlPanelCubit extends Cubit<ControlPanelStates>
{
  bool ?co=true;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription _connectivityStreamSubscription;
  ControlPanelCubit():super(ControlPanelInitialState()){
    _connectivityStreamSubscription =
        _connectivity.onConnectivityChanged.listen(
              (result) {
            if (result == ConnectivityResult.none) {
              co=false;
              emit(ConnectionErrorState()) ;
            } else {
              emit(ConnectionSuccessState()) ;
            }
          },
        );

  }
  @override
  Future<void> close() {
    _connectivityStreamSubscription.cancel();
    return super.close();
  }

  static ControlPanelCubit get(context)=>BlocProvider.of(context);
  AllBillModel ?allBillModel;

  void getOrders()async
  {
    if(await checkConnection()) {
      emit(GetOrdersLoadingState());
      DioHelper.getData(
          url: GET_ALL_BILL
      ).then((value) {
        allBillModel = AllBillModel.fromJson(value.data);

        emit(GetOrdersSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetOrdersErrorState());
      });
    }
    else
      {
        emit(CheckSocketState());
      }
  }
  BillDetailsModel? billDetailsModel;
  void getDetailsBill(int id)async
  {
    if(await checkConnection()) {
      emit(GetBillDetailsLoadingState());
      DioHelper.postData(
          url: GET_BILL_DETAILS,
          data: {
            'id_bill': id
          }
      ).then((value) {
        billDetailsModel = BillDetailsModel.fromJson(value.data);
        getTotalBill();
        getAddressForOwnerBill(
            double.tryParse(billDetailsModel!.details[0].billOwnerLat!)!,
            double.tryParse(billDetailsModel!.details[0].billOwnerLng!)!);
        getAddressForOwnerProduct(
            double.tryParse(billDetailsModel!.details[0].productOwnerLat!)!,
            double.tryParse(billDetailsModel!.details[0].productOwnerLng!)!);
        print(value.data);
        emit(GetBillDetailsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetBillDetailsErrorState());
      });
    }
    else
      {
        emit(CheckSocketState());
      }
  }
  Map<String,bool> isActive={};
  UsersModel ?usersModel;
  void getUsers()async
  {
    if(await checkConnection()) {
      emit(GetUsersLoadingState());
      DioHelper.getData(
          url: GET_ALL_USERS
      ).then((value) {
        usersModel = UsersModel.fromJson(value.data);
        usersModel!.userInformation.forEach((element) {
          isActive.addAll({element.idUser!: element.status});
        });
        print(isActive);
        //print(value.data);
        emit(GetUsersSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetUsersErrorState());
      });
    }
  }
  ChangeUserStatusModel? changeUserStatusModel;
  void changeUserStatus(int id)async
  {
    if(await checkConnection()) {
      isActive[id.toString()] = !isActive[id.toString()]!;
      DioHelper.postData(
          url: CHANGE_USER_STATUS,
          data: {
            'id_user': id,
            'state': isActive[id.toString()],

          }
      ).then((value) {
        changeUserStatusModel = ChangeUserStatusModel.fromJson(value.data);
        if (value.statusCode == 500) {
          isActive[id.toString()] = !isActive[id.toString()]!;
        }
        if (!changeUserStatusModel!.status!) {
          isActive[id.toString()] = !isActive[id.toString()]!;
        }
        else {

        }
        emit(ChangeUserStatusSuccessState());
      }).catchError((error) {
        isActive[id.toString()] = !isActive[id.toString()]!;
        print(error.toString());
        emit(ChangeUserStatusErrorState());
      });
    }
    else{
      emit(CheckSocketState());
    }
  }
  double totalPrice=0.0;
  void getTotalBill()
  {
    if(billDetailsModel!=null)
      {
        for(int i=0;i<billDetailsModel!.details.length;i++)
          {
           totalPrice =(double.tryParse(billDetailsModel!.details[i].sumPrice!)!+totalPrice);
          }
        print(totalPrice);
      }
  }
  Placemark? placeOwnerBill;
  void getAddressForOwnerBill(double lat,double lng)async
  {
    if(await checkConnection()) {
      placemarkFromCoordinates(lat, lng).then((value) {
        print(value);
        placeOwnerBill = value[2];
        emit(GetAddressSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetAddressErrorState());
      });
    }
  }
  Placemark? placeOwnerProduct;
  void getAddressForOwnerProduct(double lat,double lng)async
  {
    if(await checkConnection()) {
      placemarkFromCoordinates(lat, lng).then((value) {
        print(value);
        placeOwnerProduct = value[2];
        emit(GetAddressOwnerProductSuccessState());
      }).catchError((error) {
        emit(GetAddressOwnerProductErrorState());
      });
    }
  }
  double? lat;
  double ?lng;
  CameraPosition? kGooglePlex;
  Set<Marker>? marker;
  void initialMap()
  {
    kGooglePlex=CameraPosition(target: LatLng(lat! , lng!),zoom: 17.546);
    marker={
      Marker(
          markerId: MarkerId('1'),
        position: LatLng(lat!,lng!)
      )};
    emit(InitialMapState());
  }
  void animateCamera(GoogleMapController controller) {
    controller.animateCamera(CameraUpdate.newCameraPosition(kGooglePlex!));
  }
  File? productImage;
  var _picker = ImagePicker();
  Future<void> choiceImage() async
  {
    final XFile = await _picker.pickImage(source: ImageSource.gallery);
    if (XFile != null) {
      productImage = File(XFile.path);
      emit(ChoiceImageSuccessState());
    } else {
      print('no image selected');
      emit(ChoiceImageErrorState());
    }
  }
  //  insert(File bath)async
  // {
  // var request= await http.MultipartRequest("POST",Uri.parse('http://192.168.1.127:80/store/add_photo.php'));
  // var length=await bath.length();
  // var multiPartFile=http.MultipartFile("image",http.ByteStream(bath.openRead()),length,filename:bath.path.split('/').last );
  // request.files.add(multiPartFile);
  // var myRequest=await request.send();
  // var response=await http.Response.fromStream(myRequest);
  // if(myRequest.statusCode==200)
  //   {
  //     return jsonDecode(response.body);
  //   }else
  //     {
  //
  //     }
  //   // DioHelper.postData(url: choicePhoto
  //   //     ,
  //   //     data: {
  //   //   'image':jsonEncode(bath)
  //   //     }).then((value) {
  //   //       emit(PhotoSuccessSuccessState());
  //   // }).catchError((error){
  //   //   print(error.toString());
  //   //   emit(PhotoSuccessErrorState());
  //   // });
  // }
  void getStarted()async
  {
    if(await checkConnection()) {
      emit(AddTokenLoadingState());
      await FirebaseMessaging.instance.getToken().then((value) {
        print(value);
        CacheHelper.putData(key: 'token', value: value);
        DioHelper.postData(
            url: ADD_TOKEN,
            data: {
              'token_mobile': value
            }
        ).then((value) {
          print(value.data);
          emit(AddTokenSuccessState());
        }).catchError((error) {
          print(error.toString());
          emit(AddTokenErrorState());
        });
      });
    }
    else
      {
        emit(CheckSocketState());
      }
  }
  WishModel? wishModel;
  void getWish()async
  {
    if(await checkConnection()) {
      emit(GetWishLoadingState());
      DioHelper.getData(
          url: GET_WISH
      ).then((value) {
        wishModel = WishModel.fromJson(value.data);
        print(wishModel!.wishes[0].idWish);
        emit(GetUsersSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetUsersErrorState());
      });
    }
  }

  void changeStateForOrder(bool isDelete,int id)async
  {
    if(await checkConnection()) {
      DioHelper.postData(
          url: UPDATE_BILL_STATE,
          data:
          {
            'state': isDelete ? 2 : 0,
            'id_bill': id
          }
      ).then((value) {
        getOrders();
        emit(ChangeStatusOrderSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(ChangeStatusOrderErrorState());
      });
    }else
      {
        emit(CheckSocketState());
      }
  }
  void changeStateForWish(bool isDelete,int id)async
  {
    if(await checkConnection()) {
      DioHelper.postData(
          url: UPDATE_WISH_STATE,
          data:
          {
            'state': isDelete ? 2 : 1,
            'id_wish': id
          }
      ).then((value) {
        getWish();
        emit(ChangeStatusWishSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(ChangeStatusWishErrorState());
      });
    }
    else
      {
        emit(CheckSocketState());
      }
  }

  bool deleted=false;
  void changeDeleted(bool isDelete)
  {
    deleted=isDelete;
  }

  void changeStateForProduct(bool isDelete,int id,{double ?percent})async
  {
    emit(ChangeStatusProductLoadingState());
    if(await checkConnection()) {
      DioHelper.postData(
          url: UPDATE_PRODUCT_STATE,
          data:
          {
            'id_pro': id,
            'state': isDelete ? 2 : 1,
            'percent':percent
          }
      ).then((value) {
        getProduct();
        emit(ChangeStatusProductSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(ChangeStatusProductErrorState());
      });
    }
    else
      {
        emit(CheckSocketState());
      }
  }
  ProductModel? productModel;
  void getProduct()async
  {
    if(await checkConnection()) {
      emit(GetProductLoadingState());
      DioHelper.getData(
          url: GET_ALL_PRODUCT
      ).then((value) {
        productModel = ProductModel.fromJson(value.data);
        print('${productModel!.information.length} 334');
        emit(GetProductSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetUsersErrorState());
      });
    }
  }
  PercentModel? percentModel;
  void getPercent()async
  {
    emit(GetPercentLoadingState());
    if(await checkConnection())
      {
        DioHelper.getData(
            url: GET_PERCENT,
        ).then((value) {
          percentModel=PercentModel.fromJson(value.data);
          emit(GetPercentSuccessState());
        }).catchError((error){
          print(error.toString());
          emit(GetPercentErrorState());
        });
      }
    else
      {
        emit(CheckSocketState());
      }
  }
  AllProductsModel ?allProductsModel;
  void getAllProducts()async
  {
    emit(GetAllProductLoadingState());
    if(await checkConnection()) {
      DioHelper.getData(
          url: GET_ALL_PRODUCTS
      ).then((value) {
        allProductsModel=AllProductsModel.fromJson(value.data);
        print(value.data);
        emit(GetAllProductSuccessState());
      });
    }
    else
      {
        emit(CheckSocketState());
      }
  }
  void deleteProduct(int id)async
  {
    if(await checkConnection())
      {
        emit(GetDeleteProductLoadingState());
        DioHelper.putData(
            url: DELETE_PRODUCT,
            data:{
              'id_pro':id
            }
        ).then((value) {
          getAllProducts();
          emit(GetDeleteProductSuccessState());
        }).catchError((error){
          emit(GetDeleteProductErrorState());
        });
      }
  }
  // change product before change state
   changeProduct(File? path,Map data,context)async
  {
    if(await checkConnection()) {
      try {
        emit(ChangeProductLoadingState());
        var request = await http.MultipartRequest(
            "POST",
            Uri.parse('https://ibrahim-store.com/api2/update_pro_before.php'));
        if(path!=null) {
          var length = await path.length();
          var multiPartFile = http.MultipartFile(
              "image", http.ByteStream(path.openRead()), length,
              filename: path.path
                  .split('/')
                  .last);
          request.files.add(multiPartFile);
        }
        request.fields['name'] = data['name'];
        request.fields['short_description'] = data['shortDescription'];
        request.fields['long_description'] = data['longDescription'];
        request.fields['price'] = data['price'];
        request.fields['quantity'] = data['quantity'];
        request.fields['id_pro'] = data['idProduct'];
        request.fields['state'] = data['status'];
        var myRequest = await request.send();
        var response = await http.Response.fromStream(myRequest);
        if (myRequest.statusCode == 200) {
          emit(ChangeProductSuccessState(message: jsonDecode(response.body)['message'],status:jsonDecode(response.body)['state'] ));
          Navigator.pop(context);
          print(response.body);
         // print(jsonDecode(response.body));
          getProduct();
          return response.body;
        } else {
          print('sss');
          emit(ChangeProductErrorState());
        }
      } catch(e)
      {
        emit(ChangeProductErrorState());
        print(e.toString());
      }
    }
    else
    {
      emit(CheckSocketState());
    }
  }
  void removeImage()
  {
    productImage=null;
    emit(RemoveImageState());
  }
  void changePercent(double percent,int idProduct,context)async
  {
    if(await checkConnection())
      try {
      emit(ChangePercentLoadingState());
      DioHelper.postData(
            url: CHANGE_PERCENT,
            data:
            {
              'percent': percent,
              'id_pro': idProduct
            }
        ).then((value) {
          Navigator.pop(context);
          getAllProducts();
          emit(ChangePercentSuccessState());
        }).catchError((error){
          emit(ChangePercentErrorState());
        });
      }
    catch(e)
    {
      emit(ChangePercentErrorState());
      print(e);
    }
  }
}