import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:control_panel/layout/cubit/cubit.dart';
import 'package:control_panel/layout/cubit/states.dart';
import 'package:control_panel/model/product_model.dart';
import 'package:control_panel/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllProductsScreen extends StatelessWidget {
  AllProductsScreen({Key? key}) : super(key: key);
  var percentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<ControlPanelCubit, ControlPanelStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blue,
                title: Text(
                  'المنتجات',
                  style: TextStyle(color: Colors.white),
                ),
                titleSpacing: 0.0,
              ),
              body: ConditionalBuilder(
                builder: (context) {
                  return ListView.separated(
                      itemBuilder: (context, index) => buildCardItem(
                          context,
                          ControlPanelCubit.get(context)
                              .allProductsModel!
                              .info[index],
                          state),
                      separatorBuilder: (context, index) => SizedBox(
                            height: 5,
                          ),
                      itemCount: ControlPanelCubit.get(context)
                          .allProductsModel!
                          .info
                          .length);
                },
                fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
                condition:
                    ControlPanelCubit.get(context).allProductsModel != null,
              ));
        },
      ),
    );
  }

  Widget buildCardItem(context, InformationProducts products, state) => Column(
        children: [
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: CachedNetworkImage(
                    imageUrl:
                        'https://ibrahim-store.com/api2/images/${products.image}',
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      clipBehavior: Clip.antiAlias,
                      child: Image(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height * 0.30,
                      ),
                    ),
                    placeholder: (context, url) => Container(
                        height: MediaQuery.of(context).size.height * 0.30,
                        child: Center(child: CircularProgressIndicator())),
                    errorWidget: (context, url, error) => Container(
                      height: MediaQuery.of(context).size.height * 0.30,
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.refresh_outlined,
                        color: Colors.grey,
                      ),
                    ),
                  )),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'الاسم :',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'tajawal-light',
                                  fontSize: 14),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(
                                '${products.productName}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'tajawal-light',
                                    fontSize: 14),
                                maxLines: 3,
                                //textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'الوصف :',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'tajawal-light',
                                  fontSize: 14),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(
                                '${products.shortDescription}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'tajawal-light',
                                    fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'الوصف 2 :',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'tajawal-light',
                                  fontSize: 14),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(
                                '${products.longDescription}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'tajawal-light',
                                    fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'السعر :',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'tajawal-light',
                                  fontSize: 14),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(
                                '${products.price}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'tajawal-light',
                                    fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'السعر بعد النسبة :',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'tajawal-light',
                                  fontSize: 14),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(
                                '${products.pricePercent}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'tajawal-light',
                                  fontSize: 14,
                                  
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.question,
                                      animType: AnimType.bottomSlide,
                                      title: 'حذف المنتج',
                                      desc: 'هل تريد حذف المنتج؟',
                                      btnOkOnPress: () {
                                        ControlPanelCubit.get(context)
                                            .deleteProduct(
                                                int.parse(products.idProduct!) );
                                      },
                                      btnCancelOnPress: () {})
                                    ..show();
                                },
                                child: Text('حذف'),
                                style: ButtonStyle(
                                  foregroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
                                  backgroundColor:
                                      MaterialStateColor.resolveWith(
                                          (states) => Colors.red),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  showCupertinoDialog(
                                      context: context,
                                      builder: (context) =>
                                          CupertinoAlertDialog(
                                            title: Text(state
                                                    is ChangePercentLoadingState
                                                ? 'جاري التعديل'
                                                : 'تعديل النسبة'),
                                            content: Column(
                                              children: [
                                                CupertinoTextField(
                                                  controller: percentController,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border:
                                                        Border.all(width: 1),
                                                  ),
                                                  keyboardType:
                                                      TextInputType.number,
                                                )
                                              ],
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    if (!percentController
                                                        .text.isEmpty)
                                                      ControlPanelCubit.get(
                                                              context)
                                                          .changePercent(
                                                              double.tryParse(
                                                                  percentController
                                                                      .text)!,
                                                              int.tryParse(products
                                                                  .idProduct!)!,
                                                              context);
                                                  },
                                                  child: Text('تعديل')),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('الغاء')),
                                            ],
                                          ));
                                },
                                child: Text(
                                  'تعديل النسبة',
                                  style: TextStyle(fontSize: 12),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateColor.resolveWith(
                                          (states) => Colors.green),
                                  foregroundColor: MaterialStateColor.resolveWith((states) => Colors.white)
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      );
}
