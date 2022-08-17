import 'package:cached_network_image/cached_network_image.dart';
import 'package:control_panel/layout/cubit/cubit.dart';
import 'package:control_panel/layout/cubit/states.dart';
import 'package:control_panel/shared/components/constants/shimmer_widget.dart';
import 'package:control_panel/shared/style/colors.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsScreen extends StatelessWidget {
  int index;
  ProductDetailsScreen({required this.index});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<ControlPanelCubit,ControlPanelStates>(
        listener: (context,state){},
        builder: (context,state)
        {
          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child:CachedNetworkImage(
                    imageUrl:'https://ibrahim-store.com/api/images/${ControlPanelCubit.get(context).productModel!.information[index].image}',
                    imageBuilder: (context,imageProvider)=>Image(
                      width: double.infinity,
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                    placeholder: (context,url)=>Container(
                      child: ShimmerWidget.rectangular(height: MediaQuery.of(context).size.height,),
                    ),
                    errorWidget: (context,url,error)=>Container(
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.refresh_outlined,
                        color: Colors.grey,
                      ),
                    ),
                  ),

                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    '${ControlPanelCubit.get(context).productModel!.information[index].productName}',
                                    style: TextStyle(
                                        fontSize: 18
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '${ControlPanelCubit.get(context).productModel!.information[index].price} د.أ',
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 25,
                                      fontFamily: 'tajawal-bold'
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              width: double.infinity,
                              height: 1,
                              color: Colors.grey[400],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    '${ControlPanelCubit.get(context).productModel!.information[index].shortDescription}',
                                    style: TextStyle(
                                        fontSize: 18
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              width: double.infinity,
                              height: 1,
                              color: Colors.grey[400],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: ExpandableText(
                                '${ControlPanelCubit.get(context).productModel!.information[index].longDescription}',
                                expandText: 'المزيد',
                                collapseText: 'اقل',
                                animationCurve: Curves.slowMiddle,
                                maxLines: 2,
                                linkColor: primaryColor,
                                style: Theme.of(context).textTheme.caption!.copyWith(
                                  fontSize: 16,
                                )
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
