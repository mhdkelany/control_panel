import 'package:control_panel/layout/cubit/cubit.dart';
import 'package:control_panel/layout/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ControlPanelCubit,ControlPanelStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: GoogleMap(
                  initialCameraPosition: ControlPanelCubit.get(context).kGooglePlex!,
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  mapToolbarEnabled: true,
                  zoomControlsEnabled: false,
                  markers:ControlPanelCubit.get(context).marker! ,
                  onMapCreated: (controller)
                  {
                    ControlPanelCubit.get(context).animateCamera(controller);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
