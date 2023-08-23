import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:pietycustomer/BloCLayer/OrderBloc.dart';
import 'package:pietycustomer/BloCLayer/StoreBlocV2.dart';
import 'package:pietycustomer/BloCLayer/StoreEvent.dart';
import 'package:pietycustomer/BloCLayer/UserBloc.dart';
import 'package:pietycustomer/DataLayer/Models/OrderModels/ServiceV2.dart';
import 'package:pietycustomer/DataLayer/Models/StoreModels/Store.dart';
import 'package:pietycustomer/UILayer/Screens/CheckoutScreenV2.dart';

class StoreDescriptionScreenV2 extends StatefulWidget {
  static String route = "store_description_screen";
  const StoreDescriptionScreenV2({super.key});

  @override
  State<StoreDescriptionScreenV2> createState() =>
      _StoreDescriptionScreenV2State();
}

class _StoreDescriptionScreenV2State extends State<StoreDescriptionScreenV2> {
  StoreBloc? _storeBloc;
  OrderBloc? _orderBloc;
  UserBloc? _userBloc;

  @override
  void didChangeDependencies() {
    _storeBloc = BlocProvider.of<StoreBloc>(context);
    _orderBloc = BlocProvider.of<OrderBloc>(context);
    _userBloc = BlocProvider.of<UserBloc>(context);
    final String args = ModalRoute.of(context)!.settings.arguments as String;
    _storeBloc!.mapEventToState(GetSingleStore(storeID: args));
    _storeBloc!.mapEventToState(FetchRateList(storeID: args));
    _storeBloc!.mapEventToState(GetStoreReview(storeId: args));
    // if (init) {
    //   _storeBloc.singleRateListStream.listen((event) {
    //     print("Set State Called");
    //     setState(() {
    //       tempFituredList = event.rateListItem;
    //     });
    //   });
    //   init = false;
    // }
    super.didChangeDependencies();
  }

  bool isSelectedNote = false;
  var dist = 0.0;

  // List<String> services = [
  //   'Wash and Fold (kg)',
  //   'Dry Cleaning',
  //   'Laundry Premium',
  //   'Sanitization',
  //   'Wash and Iron (kg)',
  //   'Sofa Cleaning',
  //   'Carpet Cleaning',
  // ];

  List<Service> services = [
    Service(service: 'Wash and Fold (kg)', price: '₹ 40'),
    Service(service: 'Dry Cleaning', price: '₹ 140'),
    Service(service: 'Laundry Premium', price: '₹ 50'),
    Service(service: 'Sanitization', price: '₹ 80'),
    Service(service: 'Wash and Iron (kg)', price: '₹ 100'),
    Service(service: 'Carpet Cleaning', price: '₹ 150'),
    Service(service: 'Sofa Cleaning', price: '₹ 200'),
  ];

  List<Service> selectedServices = [];

  @override
  Widget build(BuildContext context) {
    final address = _userBloc!.getSelectedUserLocationAddress;
    double screenWidth = MediaQuery.of(context).size.width;
    return StreamBuilder<Store>(
        initialData: _storeBloc!.getSingleStore,
        stream: _storeBloc!.singleStoreStream,
        builder: (context, snapshot) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children:[
                  Center(
                    ///Image
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 500,

                      child: Image.asset(
                        'assets/Images/laundry2.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                 ClipRRect(
                   borderRadius: BorderRadius.only(
                     topLeft: Radius.circular(50.0),
                     topRight: Radius.circular(50.0),
                   ),
                   child: Container(
                    child: Column(
                      children: [
                        ///Name and rating row
                        Padding(
                          padding:
                          const EdgeInsets.only(right: 16, left: 16, top: 8.0),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 100,
                                width: .5*screenWidth,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Text(
                                    snapshot.data!.name.toString(),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: List.generate(
                                      5,
                                          (index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: SizedBox(
                                            height: 3,
                                            width: 3,
                                            child: Icon(
                                              index < 4
                                                  ? Icons.star
                                                  : Icons.star_border,
                                              color: Color.fromARGB(255, 239, 208, 7),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        "10 reviews",
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),

                        ///Address and location on map button row
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 16,
                            left: 16,
                          ),
                          child: SingleChildScrollView(
                            child: Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 100,
                                    width: .3*screenWidth,
                                    child: Center(
                                      child: Text(
                                        snapshot.data!.address!.getDisplayAddress().toString(),
                                        overflow: TextOverflow.fade,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Material(
                                            child: FlutterLocationPicker(
                                              initPosition: LatLong(
                                                snapshot
                                                    .data!.storeCoordinates!.latitude,
                                                snapshot
                                                    .data!.storeCoordinates!.longitude,
                                              ),
                                              selectLocationButtonStyle: ButtonStyle(
                                                backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.blue),
                                              ),
                                              selectLocationButtonText:
                                              'Store Location ' + dist.toString(),
                                              initZoom: 11,
                                              minZoomLevel: 5,
                                              maxZoomLevel: 16,
                                              trackMyPosition: false,
                                              onError: (e) => print(e),
                                              onPicked: (pickedData) {
                                                dist = Geolocator.distanceBetween(
                                                  address!.latitude,
                                                  address.longitude,
                                                  snapshot
                                                      .data!.storeCoordinates!.latitude,
                                                  snapshot.data!.storeCoordinates!
                                                      .longitude,
                                                );
                                                print("dist"+dist.toString());
                                                Navigator.of(context).pop;
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text("Location On Map"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        ///open close tag
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 16,
                            left: 16,
                          ),
                          child: Row(
                            children: [
                              Center(
                                child: Text(
                                  "Open ",
                                  style: TextStyle(
                                    color: Colors.green,
                                  ),
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                              Center(
                                child: Text(
                                  " - Closes at " +
                                      snapshot.data!.closingHour.toString() +
                                      " PM",
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                            ],
                          ),
                        ),

                        ///divider
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                            thickness: 1.5,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                            right: 16,
                            left: 16,
                            top: 8,
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 3,
                                ),

                                ///rate list button
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    side: BorderSide(
                                      width: 1.0,
                                    ),
                                    minimumSize: Size(120, 40),
                                    maximumSize: Size(120, 40),
                                  ),
                                  child: Center(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.currency_rupee_outlined,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          'Rate',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),

                                ///offer button
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    side: BorderSide(
                                      width: 1.0,
                                    ),
                                    minimumSize: Size(120, 40),
                                    maximumSize: Size(120, 40),
                                  ),
                                  child: Center(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.local_offer_outlined,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          'Offer',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),

                                ///compare button
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    side: BorderSide(
                                      width: 1.0,
                                    ),
                                    minimumSize: Size(120, 40),
                                    maximumSize: Size(130, 40),
                                  ),
                                  child: Center(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.bar_chart_outlined,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          'Compare',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(right: 16, left: 16, top: 16),
                          child: Container(
                            height: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromARGB(255, 210, 245, 171),
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Select Service',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 80,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Expanded(
                                          child: Text(
                                            'Selected Services: ',
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          selectedServices.length == 0
                                              ? '0'
                                              : selectedServices.length.toString(),
                                          style: TextStyle(
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 8.0,
                                      left: 8.0,
                                    ),
                                    child: Divider(
                                      thickness: 1.5,
                                    ),
                                  ),
                                  Text(
                                    'Click on the checkbox to select services',
                                  ),

                                  ///Checkboxes
                                  SizedBox(
                                    height: 200,
                                    width: 300,
                                    child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: services.length,
                                      shrinkWrap: true,
                                      itemBuilder: ((context, index) {
                                        return CheckboxListTile(
                                          title:
                                          Text(services[index].service.toString()),
                                          subtitle: Text(services[index].price),
                                          activeColor: Colors.blueAccent,
                                          controlAffinity:
                                          ListTileControlAffinity.leading,
                                          value: services[index].isSelected,
                                          onChanged: (value) {
                                            setState(() {
                                              services[index].isSelected = value!;
                                              if (services[index].isSelected) {
                                                selectedServices.add(services[index]);
                                              } else if (!services[index].isSelected) {
                                                selectedServices
                                                    .remove(services[index]);
                                              }
                                              print("services selected" +
                                                  selectedServices.toList().toString());
                                            });
                                          },
                                        );
                                      }),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),

                        ///Note
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 16.0, left: 16, bottom: 8.0, top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Note',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '*',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                              width: 50,
                              child: Checkbox(
                                  value: isSelectedNote,
                                  activeColor: Colors.blueAccent,
                                  onChanged: (value) {
                                    setState(() {
                                      isSelectedNote = value!;
                                    });
                                  }),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                width: 200,
                                child: Text(
                                  "Some stores don't accept sarees and other clothes as wash..............................................",
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                ),
                 ),
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 240,
                    child: Text(
                      'Check all the clothes after receiving in front of delivery partner',
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    child: ElevatedButton(
                      onPressed:  selectedServices.isEmpty || !isSelectedNote
                          ? () {
                        Fluttertoast.showToast(
                            msg: "Please Select Services and Also Agree to Store's T&C",
                            toastLength: Toast.LENGTH_LONG);
                      }
                          : () {
                        List<String> selectedServiceName = [];
                        Map<String, int> map = Map();
                        for(Service s in selectedServices){
                          selectedServiceName.add(s.service);
                          map[s.service] = 1;
                        }
                        _orderBloc!.selectedServicesSink
                            .add(selectedServiceName);
                        // ServicesScreenArgs args =
                        //     ServicesScreenArgs(
                        //   services: selectedServices,
                        // );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckoutScreen(
                              selectedServices: selectedServiceName,
                              selectedServicesItems: map,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                                (states) => Colors.orange),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}


