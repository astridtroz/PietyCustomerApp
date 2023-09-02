import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:pietycustomer/BloCLayer/OrderBloc.dart';
import 'package:pietycustomer/BloCLayer/StoreBlocV2.dart';
import 'package:pietycustomer/BloCLayer/StoreEvent.dart';
import 'package:pietycustomer/BloCLayer/UserBloc.dart';
import 'package:pietycustomer/DataLayer/Models/OrderModels/ServiceV2.dart';
import 'package:pietycustomer/DataLayer/Models/StoreModels/RateList.dart';
import 'package:pietycustomer/DataLayer/Models/StoreModels/Store.dart';
import 'package:pietycustomer/UILayer/Screens/CheckoutScreenV2.dart';

import '../../Widgets/RateListContainer.dart';
bool isSelectedNote = false;
var dist = 0.0;
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
class StoreDescription extends StatefulWidget {
  static String route = "store_description_screen";

  const StoreDescription({Key? key}) : super(key: key);



  @override
  State<StoreDescription> createState() => _StoreDescriptionState();
}

class _StoreDescriptionState extends State<StoreDescription> {

  List<String> _selectedText = [];
  Map<String, double> _prices = Map<String, double>();
  Map<String, int> _numberOfItems = Map<String, int>();
  String _searchField = "All";

  String dropDownValue = "All";
  StoreBloc? _storeBloc;
  OrderBloc? _orderBloc;
  var init = true;

  List<RateListItem> tempFituredList = [];

  // Visbility Text..

  bool visibilityText = false;
  UserBloc? _userBloc;


  @override

  void didChangeDependencies() {
    _storeBloc = BlocProvider.of<StoreBloc>(context);
    _orderBloc = BlocProvider.of<OrderBloc>(context);
    _userBloc = BlocProvider.of<UserBloc>(context);
    final args = ModalRoute.of(context)?.settings.arguments as String?;
    if (args != null) {
      _storeBloc!.mapEventToState(GetSingleStore(storeID: args));
      _storeBloc!.mapEventToState(FetchRateList(storeID: args));
      _storeBloc!.mapEventToState(GetStoreReview(storeId: args));
    }
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


  Widget build(BuildContext context) {
    final address = _userBloc!.getSelectedUserLocationAddress;
    double screenWidth = MediaQuery.of(context).size.width;
    return StreamBuilder<Store>(
      initialData: _storeBloc!.getSingleStore,
      stream: _storeBloc!.singleStoreStream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
       return Expanded(
         child: Scaffold(
            body: Center(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(

                      child: Container(
                        color: Colors.white,
                        child: Image.asset(
                          'assets/Images/laundry2.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 270,
                    child: CustomPaint(
                      painter: MyPainter(),
                      child: SingleChildScrollView(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(50),
                              topLeft: Radius.circular(50),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              children: [
                                ///name and ratelist
                                Padding(
                                  padding:
                                  const EdgeInsets.only(right: 16, left: 16, top: 8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          height: 100,
                                          width: .5*screenWidth,
                                          child: SingleChildScrollView(
                                              scrollDirection: Axis.vertical,
                                              child: Container(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      snapshot.data!.name.toString(),
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                      overflow: TextOverflow.fade,
                                                    ),
                                                  ],
                                                ),
                                              )
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: Column(
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
                                                      height: 5,
                                                      width: 5,
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
                                      ),
                                    ],
                                  ),
                                ),
                               SizedBox(
                                 height: 10,
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
                              SizedBox(
                                height: 10,
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
                                          onPressed: () {
                                            ///rate list
                                            showModalBottomSheet(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  _storeBloc!.mapEventToState(GetRateListOfType(
                                                      rateListType:
                                                      "All",
                                                      storeID: _storeBloc!
                                                          .getSingleStore
                                                          .uid!));

                                                  return SingleChildScrollView(

                                                  child: Padding(
                                                      padding: const EdgeInsets.all(
                                                          8.0),
                                                      child:
                                                      StatefulBuilder(builder: (BuildContext context, StateSetter mySetState) {
                                                        return SingleChildScrollView(
                                                          child: Container(
                                                              height: MediaQuery.of(context).size.height * 0.67,
                                                              width: MediaQuery.of(context).size.width,
                                                              child: Column(children: <Widget>[
                                                                StreamBuilder<List<String>>(
                                                                    initialData: _storeBloc!.getCategoryRateList,
                                                                    stream: _storeBloc!.categoryListOfStoreStream,
                                                                    builder: (context, snapshot) {
                                                                      if (snapshot.hasData) {
                                                                        if (snapshot.hasError) {
                                                                          return Text("Something went wrong in Cate");
                                                                        } else {
                                                                          List<String> items = snapshot.data!;
                                                                          print(items.toString());
                                                                          if (!items.contains("All")) {
                                                                            items.add("All");
                                                                          }
                                                                          return Container(
                                                                            padding: const EdgeInsets.only(left: 10, right: 10),
                                                                            decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(5),
                                                                              border: Border.all(color: Colors.grey),
                                                                            ),
                                                                            child: DropdownButton<String>(
                                                                              isDense: true,
                                                                              value: dropDownValue,
                                                                              onChanged: (String? val) {
                                                                                mySetState(() {
                                                                                  dropDownValue = val!;
                                                                                });
                                                                                _storeBloc!.mapEventToState(GetRateListOfType(rateListType: dropDownValue, storeID: _storeBloc!.getSingleStore.uid!));
                                                                              },
                                                                              items: items.map<DropdownMenuItem<String>>((String value) {
                                                                                return DropdownMenuItem<String>(
                                                                                  value: value,
                                                                                  child: Text(value),
                                                                                );
                                                                              }).toList(),
                                                                            ),
                                                                          );
                                                                        }
                                                                      } else {
                                                                        return Text("Loading... 1");
                                                                      }
                                                                    }),
                                                                StreamBuilder<RateList>(
                                                                    initialData: _storeBloc!.getInitialRateList,
                                                                    stream: _storeBloc!.singleRateListStream,
                                                                    builder: (BuildContext context, AsyncSnapshot<RateList> snapshot) {
                                                                      print("\nRebuilded\n");
                                                                      if (snapshot.hasData) {
                                                                        return Container(
                                                                          height: MediaQuery.of(context).size.height * 0.62,
                                                                          child: ListView(
                                                                            children: snapshot.data!.cumulativeRateList.keys.map((category) {
                                                                              return GFAccordion(
                                                                                key: ObjectKey(category),
                                                                                title: "$category",
                                                                                contentChild: Column(children: <Widget>[
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                    children: <Widget>[
                                                                                      Text(
                                                                                        "Service",
                                                                                        style: TextStyle(fontWeight: FontWeight.bold),
                                                                                      ),
                                                                                      Text(
                                                                                        "Price",
                                                                                        style: TextStyle(fontWeight: FontWeight.bold),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                  Divider(
                                                                                    color: Colors.black,
                                                                                  ),
                                                                                  Column(
                                                                                    children: snapshot.data!.cumulativeRateList[category]!.map((RateListItem rateListItem) {
                                                                                      return Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                        children: <Widget>[
                                                                                          Text(
                                                                                            "${rateListItem.serviceName}",
                                                                                          ),
                                                                                          Text(
                                                                                            rateListItem.serviceRate!.isFixed! ? "\u{20B9} ${rateListItem.serviceRate?.fixed} (FIX)" : "\u{20B9} ${rateListItem.serviceRate?.low} - \u{20B9} ${rateListItem.serviceRate?.high}",
                                                                                          )
                                                                                        ],
                                                                                      );
                                                                                    }).toList(),
                                                                                  ),
                                                                                ]),
                                                                              );
                                                                            }).toList(),
                                                                          ),
                                                                        );
                                                                        // List<RateListItem> temp = snapshot.data;
                                                                        // return Container(
                                                                        //   height: MediaQuery.of(context).size.height * 0.6,
                                                                        //   child: ListView.builder(
                                                                        //     shrinkWrap: true,
                                                                        //     physics: ClampingScrollPhysics(),
                                                                        //     itemCount: temp.length,
                                                                        //     itemBuilder: (context, count) {
                                                                        //       return RateListContainer(temp, count);
                                                                        //     },
                                                                        //   ),
                                                                        // );
                                                                      } else {
                                                                        return Center(
                                                                          child: Text("Something went Wrong in Items"),
                                                                        );
                                                                      }
                                                                    })
                                                              ])),
                                                        );
                                                      }
                                                      )
                                                  )
                                                  );
                                                });
                                          },
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

                                ///services list
                                Container(height: 250,
                                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: services.length,
                                    shrinkWrap: true,
                                    itemBuilder: ((context, index) {
                                      return ListTile(
                                        leading: Container(
                                          child: Image.network("https://t8d9k2a6.rocketcdn.me/wp-content/uploads/2022/11/Folded-laundry-wash-and-fold-service.jpg",
                                            height: 80,
                                            width: 80,
                                          ),
                                        ),
                                        title:
                                        Text(services[index].service.toString()),
                                        subtitle: Text(services[index].price),
                                        tileColor: Colors.white,
                                        dense: services[index].isSelected,
                                        /* onChanged: (value) {
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
                                     },*/
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            MinusButton(),
                                            PlusButton(
                                              index: index, // Pass the index
                                              isSelected: services[index].isSelected,
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
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
                        ///  _orderBloc!.selectedServicesSink
                        ///      .add(selectedServiceName);
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

          ),
       );
      },
    );
  }
}
class MinusButton extends StatefulWidget {
  const MinusButton({Key? key}) : super(key: key);

  @override
  State<MinusButton> createState() => _MinusButtonState();
}

class _MinusButtonState extends State<MinusButton> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 25,
      height: 25,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Stack(children: [
        ElevatedButton(
          onPressed: (){},
          child: Container(),
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              )),
        ),
        GestureDetector(child: Center(child: Icon(FontAwesomeIcons.minus,
          color: Colors.white,)), onTap: (){})
      ]),
    );
  }
}

class PlusButton extends StatefulWidget {
  final int index;
  final bool isSelected;

  PlusButton({required this.index, required this.isSelected, Key? key})
      : super(key: key);

  @override
  State<PlusButton> createState() => _PlusButtonState();
}


class _PlusButtonState extends State<PlusButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25,
      height: 25,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Stack(
        children: [
          ElevatedButton(
            onPressed: () {},
            child: Container(),
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                widget.isSelected
                    ? selectedServices.remove(services[widget.index])
                    : selectedServices.add(services[widget.index]);

                services[widget.index].isSelected = !widget.isSelected;
              });
            },
            child: Center(
              child: Icon(
                FontAwesomeIcons.plus,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class MyPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    // You can customize the painting here if needed
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
