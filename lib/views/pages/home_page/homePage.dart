import 'dart:async';

import 'package:destination/views/pages/history_page/history_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../consts/app_images.dart';
import 'homePageController.dart';

class HomePage extends GetView<HomePageController> {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    final penalHeightClosed = size.height * 0.1;
    final penalHeightOpen = size.height * 0.6;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    if (defaultTargetPlatform == TargetPlatform.android) {
      AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black54,
        body:Obx((){
          return  Row(
            children: [
              Expanded(
                  flex: 4,
                    child: SlidingUpPanel(
                      color: Colors.black54,
                      minHeight: penalHeightClosed,
                      maxHeight: penalHeightOpen,
                      body: GoogleMap(
                        markers: Set<Marker>.of(controller.marker),
                        polylines: Set<Polyline>.of(controller.polyline),
                        zoomControlsEnabled: false,
                        myLocationButtonEnabled: false,
                        myLocationEnabled: false,
                        mapType: MapType.normal,
                        onLongPress: controller.addDestinationMarker,
                        initialCameraPosition: controller.kGooglePlex,
                        onMapCreated: (GoogleMapController map) {
                          DefaultAssetBundle.of(context).loadString(AppImages.darkThemes)
                              .then((value)=> map.setMapStyle(value));
                          controller.mapController.complete(map);
                        },
                      ),
                      panelBuilder: (builder)=>HistoryPage(builder),
                    ),
              ),
              Expanded(flex: 2,
                child: Container(color: Colors.white10,
                  child:Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListView(
                      children:[
                        const Text('Search Destination', style: TextStyle(color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),),
                        const SizedBox(height: 8,),
                        SizedBox(
                          height: 40,
                          child: TextFormField(
                            style: const TextStyle(color: Colors.white),
                            keyboardType: TextInputType.text,
                            controller: controller.searchController,
                            onChanged: (value){
                               controller.isEditTextEnable.value = value.isEmpty ? false : true;
                            },
                            decoration: const InputDecoration(
                                suffixIcon: Icon(Icons.search),
                                fillColor: Colors.white10,
                                filled: true,
                                hintText: 'Destination..',
                                contentPadding: EdgeInsets.all(8),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.all(Radius.circular(8)))),
                          ),
                        ),
                        controller.isEditTextEnable.isTrue ?
                          SizedBox(
                          height: 100,
                          child: Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: 15,
                                itemBuilder: (_,index){
                                  return SizedBox(
                                    height: 20,
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 8),
                                      child: const Text(' Solid Point Karim Tower, 44/7/A & 44/7/B West, Panthapath, Dhaka',style: TextStyle(color: Colors.white30, fontSize: 12),),
                                      // Text(controller.placeList[index]['main_text'],style: const TextStyle(color: Colors.white30, fontSize: 12),),
                                    ),
                                  );
                                },
                            ),
                          ),
                        ) : Container(),
                        Container(
                          decoration: BoxDecoration(color: Colors.white10,
                              borderRadius: BorderRadius.circular(8)),
                          margin: const EdgeInsets.only(top: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(color: Colors.deepOrange,height: 16,width: 4,),
                                    const SizedBox(width: 8,),
                                    const Text('Overview',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),)
                                  ],),
                                const SizedBox(height: 16,),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(color: Colors.white10,
                                          borderRadius: BorderRadius.circular(8)),
                                      child:
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8,top: 2,right: 4,bottom: 2),
                                        child: Row(
                                          children:  [
                                            const Text('3',style: TextStyle(color: Colors.deepOrange,fontSize: 32,fontWeight: FontWeight.bold),),
                                            Container(margin: const EdgeInsets.only(top: 8),
                                                child: const Text(' km',style: TextStyle(color: Colors.deepOrange,fontSize: 16,fontWeight: FontWeight.bold),)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 4,),
                                    Column(
                                      children: const [
                                        Text('DISTANCE',style: TextStyle(color: Colors.white,fontSize: 24),),
                                        Text('Gultion ModdoBazar Road',style: TextStyle(color: Colors.white24,fontSize: 10),),
                                      ],
                                    )

                                  ],),
                                const SizedBox(height: 16,),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.location_on_outlined, color: Colors.white30,),
                                    const SizedBox(width: 8,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const [
                                        Text('12.33388/78.363733',style: TextStyle(color: Colors.white,),),
                                        Text('Destination Location Address',style: TextStyle(color: Colors.white24,fontSize: 12),),
                                      ],
                                    )

                                  ],),
                                const SizedBox(height: 8,),
                                SizedBox(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.timer_outlined, color: Colors.white30,),
                                      const SizedBox(width: 8,),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: const [
                                          Text('0h-25min',style: TextStyle(color: Colors.white,),),
                                          Text('Estimate Time',style: TextStyle(color: Colors.white24,fontSize: 12),),
                                        ],
                                      )

                                    ],),
                                ),

                              ],
                            ),
                          ),
                        ),
                         ElevatedButton(
                               onPressed: (){},
                               style: ElevatedButton.styleFrom(
                               primary: Colors.white10,),
                               child: Row(
                                 mainAxisSize: MainAxisSize.min,
                                 children: const [
                                   Icon(Icons.add, color: Colors.white30,),
                                   SizedBox(width: 8,),
                                   Text('Create Note',style: TextStyle(color: Colors.white30,),),
                                 ],
                           ),
                         ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

}




