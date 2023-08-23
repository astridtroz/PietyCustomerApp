import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

class StoreDescription extends StatefulWidget {
  static String route = "store_description_screen";
  const StoreDescription({Key? key}) : super(key: key);

  @override
  State<StoreDescription> createState() => _StoreDescriptionState();
}

class _StoreDescriptionState extends State<StoreDescription> {

  StoreBloc? _storeBloc;
  OrderBloc? _orderBloc;
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
  Widget build(BuildContext context) {
    final address = _userBloc!.getSelectedUserLocationAddress;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
                                           Text("Shop name",
                                           style: TextStyle(
                                             fontSize: 20,
                                           ),),
                                           Text("Shop description Lorem ipsum dolor sit amet, consectetur adipiscing eli"),
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
                                     PlusButton(),
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
  const PlusButton({Key? key}) : super(key: key);

  @override
  State<PlusButton> createState() => _PlusButtonState();
}

class _PlusButtonState extends State<PlusButton> {
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
        GestureDetector(child: Center(child: Icon(FontAwesomeIcons.plus,
          color: Colors.white,)), onTap: (){})
      ]),
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
