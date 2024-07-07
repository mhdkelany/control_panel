import 'dart:async';
import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:control_panel/layout/cubit/cubit.dart';
import 'package:control_panel/layout/cubit/states.dart';
import 'package:control_panel/shared/components/components.dart';
import 'package:control_panel/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_details_screen.dart';

class ProductScreen extends StatelessWidget {
  RegExp _regExp = RegExp(r'^[0-9]+$');
  RegExp reg = RegExp(r'^\d{0,8}(\.\d{1,4})?$');
  var productNameController=TextEditingController();
  var descriptionController=TextEditingController();
  var priceController=TextEditingController();
  var quantityController=TextEditingController();
  var shortDescriptionController=TextEditingController();
var textController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    textController.text=7.toString();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<ControlPanelCubit,ControlPanelStates>(
        listener: (context,state)
        {
          if(state is ChangeProductLoadingState)
            {
              showDialog(context: context, builder: (context)=>Directionality(
                textDirection: TextDirection.rtl,
                child: AlertDialog(
                  surfaceTintColor: Colors.white,
                  backgroundColor: Colors.white,
                  contentPadding: EdgeInsets.zero,
                  content: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('جاري المعالجة'),
                        SizedBox(
                          width: 5,
                        ),
                        CircularProgressIndicator(),
                      ],
                    ),
                  ),
                ),
              ));

            }
          if(state is ChangeProductSuccessState)
            {

              showDialog(context: context, builder: (context)=>Directionality(
                textDirection: TextDirection.rtl,
                child: AlertDialog(
                  backgroundColor: Colors.white,
                  surfaceTintColor: Colors.white,
                  contentPadding: EdgeInsets.zero,
                  content: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(state.message),
                      ],
                    ),
                  ),
                ),
              ));
              Timer(Duration(seconds: 2),() => Navigator.pop(context),);
            }
          if(state is CheckSocketState)
            {
              ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(Text('لا يوجد اتصال باﻷنترنت'), Colors.amber, Duration(seconds: 5)));
            }
          if(state is ChangeStatusProductLoadingState)
          {
            showDialog(context: context, builder: (context)=>Directionality(
              textDirection: TextDirection.rtl,
              child: AlertDialog(
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                contentPadding: EdgeInsets.zero,
                content: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('جاري المعالجة'),
                      SizedBox(
                        width: 5,
                      ),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              ),
            ));

          }
         else if(state is ChangeStatusProductSuccessState)
            {
              if(!ControlPanelCubit.get(context).deleted) {
                ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(
                    Text('تم قبول المنتج'), Colors.green,
                    Duration(seconds: 3)));

              }
              if(ControlPanelCubit.get(context).deleted)
                ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(Text('تم حذف المنتج'), Colors.red, Duration(seconds: 3)));
              Navigator.pop(context);
            }
        },
        builder: (context,state)
        {
          return Scaffold(
            backgroundColor: Colors.white,
            body:ConditionalBuilder(
              builder: (context)
              {
                if(ControlPanelCubit.get(context).productModel!.information.length==0)
                  {
                    return Center(child: Text('لا يوجد منتجات بعد',style: TextStyle(color: Colors.grey[300],fontSize: 26),),);
                  }
                else
                return ListView.separated(
                    itemBuilder:(context,index)
                    {
                      return  Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction)
                        {
                          if(direction==DismissDirection.startToEnd)
                          {
                            ControlPanelCubit.get(context).changeDeleted(true);
                            print(ControlPanelCubit.get(context).productModel!.information[index].idProduct);
                            ControlPanelCubit.get(context).changeStateForProduct(ControlPanelCubit.get(context).deleted, int.tryParse(ControlPanelCubit.get(context).productModel!.information[index].idProduct!)!);
                          }
                          if(direction==DismissDirection.endToStart)
                          {
                            ControlPanelCubit.get(context).changeDeleted(false);
                            showDialog(context: context, builder: (context)=>Directionality(
                              textDirection: TextDirection.rtl,
                              child: AlertDialog(
                                backgroundColor: Colors.white,
                                surfaceTintColor: Colors.white,
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      decoration: InputDecoration(
                                          label: Text('ادخل النسبة'),
                                          hintText: 'ادخل النسبة',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.grey)
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.blue)
                                          )
                                      ),
                                      keyboardType:  TextInputType.number,
                                      controller:textController ,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    ElevatedButton(onPressed: ()
                                    {
                                      ControlPanelCubit.get(context).changeStateForProduct(ControlPanelCubit.get(context).deleted, int.tryParse(ControlPanelCubit.get(context).productModel!.information[index].idProduct!)!,percent: double.tryParse(textController.text));
                                      Navigator.pop(context);
                                    }, child: Text('تم'))
                                  ],
                                ),

                              ),
                            ));
                          }
                        },
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          color: Colors.red,
                          child: Icon(Icons.delete_forever,color: Colors.white,size: 30,),
                        ),
                        secondaryBackground:Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          color: Colors.green,
                          child: Icon(Icons.archive_sharp,color: Colors.white,size: 30,),
                        ),
                        child:  InkWell(
                          onLongPress: (){
                            productNameController.text=ControlPanelCubit.get(context).productModel!.information[index].productName!;
                            descriptionController.text=ControlPanelCubit.get(context).productModel!.information[index].longDescription!;
                            priceController.text=double.tryParse(ControlPanelCubit.get(context).productModel!.information[index].price!)!.toStringAsFixed(2);
                            quantityController.text=ControlPanelCubit.get(context).productModel!.information[index].quantity!;
                            shortDescriptionController.text=ControlPanelCubit.get(context).productModel!.information[index].shortDescription!;
                            showModalBottomSheet(shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20),
                              )
                            ),isScrollControlled: true,context: context, builder: (context)=>Directionality(
                              textDirection: TextDirection.rtl,
                              child: Container(
                                height: MediaQuery.of(context).size.height-100,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20,top: 25),
                                  child: ListView(
                                   // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: defaultTextFromField(
                                            prefixIconColor: Colors.blue,
                                            border2: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.blue,width: 1),
                                            ),
                                            hintText: 'اسم المنتج',
                                            floatingLabelBehavior: FloatingLabelBehavior.always,
                                            isShow: false,
                                            controller:productNameController,
                                            text: 'اسم المنتج',
                                            prefix: Icons.shopping_cart_outlined,
                                            inputType: TextInputType.text,
                                            validate: (String value)
                                            {
                                              if(value.trim().isEmpty)
                                                return 'يجب ان لا يكون فارغا';
                                              if(value.trim().length<2)
                                                return 'يجب ان تكون القيمة اكبر من 1';
                                              if(value.trim().length>50)
                                                return 'يجب ان تكون القيمة اقل من 50';
                                              // validator(value, 1, 15, 'product');
                                            }
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),

                                      defaultTextFromField(
                                          prefixIconColor: Colors.blue,
                                          border2: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.blue,width: 1),
                                          ),
                                          hintText: 'مثلاً لون المنتج',
                                          floatingLabelBehavior: FloatingLabelBehavior.always,
                                          isShow: false,
                                          controller:shortDescriptionController,
                                          text: 'وصف صغير',
                                          prefix: Icons.short_text,
                                          inputType: TextInputType.text,
                                          validate: (String value)
                                          {
                                            if(value.trim().isEmpty)
                                              return 'يجب ان لا يكون فارغا';
                                            if(value.trim().length<2)
                                              return 'يجب ان تكون القيمة اكبر من 1';
                                            if(value.trim().length>25)
                                              return 'يجب ان تكون القيمة اقل من 25';
                                            // validator(value, 1, 15, 'product');
                                          }
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      defaultTextFromField(
                                          maxLine: 3,
                                          prefixIconColor: Colors.blue,
                                          border2: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.blue,width: 1),
                                          ),
                                          hintText: 'مثلاً كمية القطع في الكرتونة',
                                          floatingLabelBehavior: FloatingLabelBehavior.always,
                                          isShow: false,
                                          controller:descriptionController,
                                          text: 'وصف كبير',
                                          prefix: Icons.description,
                                          inputType: TextInputType.text,
                                          validate: (String value)
                                          {
                                            if(value.trim().isEmpty)
                                              return 'يجب ان لا يكون فارغا';
                                            if(value.trim().length<2)
                                              return 'يجب ان تكون القيمة اكبر من 1';
                                            if(value.trim().length>150)
                                              return 'يجب ان تكون القيمة اقل من 150';
                                            // validator(value, 1, 15, 'product');
                                          }
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      defaultTextFromField(
                                          prefixIconColor: Colors.blue,
                                          border2: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.blue,width: 1),
                                          ),
                                          hintText: '150 دينار',
                                          floatingLabelBehavior: FloatingLabelBehavior.always,
                                          isShow: false,

                                          controller:priceController,
                                          text: 'السعر',
                                          prefix: Icons.price_check,
                                          inputType: TextInputType.numberWithOptions(),
                                          validate: (String value)
                                          {
                                            if(!reg.hasMatch(value))
                                            {
                                              return'يجب ادخال رقم';
                                            }
                                            if(value.trim().isEmpty)
                                              return 'يجب ان لا يكون فارغا';
                                            if(value.trim().length>6)
                                              return 'يجب ان تكون القيمة اقل من 6';
                                            // validator(value, 1, 15, 'product');
                                          }
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      defaultTextFromField(
                                        focusColor: Colors.blue,
                                          prefixIconColor: Colors.blue,
                                          border2: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.blue,width: 1),
                                          ),
                                          hintText: '5',
                                          floatingLabelBehavior: FloatingLabelBehavior.always,
                                          isShow: false,
                                          controller:quantityController,
                                          text: 'الكمية',
                                          prefix: Icons.queue,
                                          inputType: TextInputType.numberWithOptions(),
                                          validate: (String value)
                                          {
                                            if(!_regExp.hasMatch(value))
                                            {
                                              return 'يجب ادخال رقم';
                                            }
                                            if(value.trim().isEmpty)
                                              return 'يجب ان لا يكون فارغا';

                                            if(value.trim().length>6)
                                              return 'يجب ان تكون القيمة اقل من 6';
                                            // validator(value, 1, 15, 'product');
                                          }
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      OutlinedButton(
                                        onPressed: ()
                                        {
                                          ControlPanelCubit.get(context).choiceImage();
                                        },
                                        child: Text('اختر صورة'),
                                  ),
                                      if(ControlPanelCubit.get(context).productImage!=null)
                                      SizedBox(
                                        height: 20,
                                      ),
                                      if(ControlPanelCubit.get(context).productImage!=null)
                                      Stack(
                                        children: [
                                          Image.file(
                                              File(ControlPanelCubit.get(context).productImage!.path),
                                            fit: BoxFit.cover,
                                          ),
                                          GestureDetector( onTap:(){
                                            ControlPanelCubit.get(context).removeImage();
                                          },child: CircleAvatar(radius:15,backgroundColor:Colors.red.withOpacity(0.5),child: Center(child: Icon(  Icons.delete,size: 18,color: Colors.white,))))
                                        ],
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      defaultButton(
                                          function: state is ChangeProductLoadingState?null:()
                                          {
                                            ControlPanelCubit.get(context).changeProduct(ControlPanelCubit.get(context).productImage, {
                                              'name':productNameController.text,
                                              'shortDescription':shortDescriptionController.text,
                                              'longDescription':descriptionController.text,
                                              'price':priceController.text,
                                              'quantity':quantityController.text,
                                              'idProduct':ControlPanelCubit.get(context).productModel!.information[index].idProduct!,
                                              'status':'3'
                                            },context);
                                          },
                                          widget: state is ChangeProductLoadingState?CircularProgressIndicator():Text('تعديل',style: TextStyle(color: Colors.white,fontSize: 16),))
                                    ],
                                  ),
                                ),
                              ),
                            ));
                          },
                          onTap: (){
                            navigateTo(context, ProductDetailsScreen(index: index,));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            flex:0,
                                            child: Text(
                                              'صاحب المنتج : ',
                                              style: TextStyle(
                                                  fontFamily: 'tajawal-bold',
                                                  fontSize: 14
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              '${ControlPanelCubit.get(context).productModel!.information[index].userName}',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[400]
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 0,
                                            child: Text(
                                              'اسم المنتج : ',
                                              style: TextStyle(
                                                  fontFamily: 'tajawal-bold',
                                                  fontSize: 14
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              '${ControlPanelCubit.get(context).productModel!.information[index].productName}',
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 14,
                                              ),
                                              maxLines: 2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              //  Spacer(),
                                Icon(Icons.arrow_forward_ios,color: Colors.grey[300],)
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context,index)=>Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey,
                    ),
                    itemCount: ControlPanelCubit.get(context).productModel!.information.length
                );
              },
              fallback: (context)=>Center(child: CircularProgressIndicator(),),
              condition: ControlPanelCubit.get(context).productModel!=null,
            )


          );
        },
      ),
    );
  }
}
