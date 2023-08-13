import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:pietycustomer/BloCLayer/StoreBlocV2.dart';
import 'package:pietycustomer/BloCLayer/StoreEvent.dart';
import 'package:pietycustomer/BloCLayer/UserBloc.dart';
import 'package:pietycustomer/BloCLayer/UserEvent.dart';
import 'package:pietycustomer/DataLayer/Models/UserModels/User.dart';
import 'package:pietycustomer/DataLayer/Models/UserModels/UserAddress.dart';
import 'package:pietycustomer/UILayer/Screens/HomeScreens/HomeStoreListBuilder.dart';
import '../../../DataLayer/Models/StoreModels/Store.dart';


TextEditingController _controller = TextEditingController();

class Home extends StatefulWidget {
  static String route = "home";
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final StoreBloc storeBloc = StoreBloc.initialize();
  int currentTab = 0;

  final List<Widget> screens = [
    const MainScreen(),
    const Nearby(),
    const Share(),
    const Profile()
  ];

  LatLng? _pickedLocation;
  var _isSelected = false;
  double rating = 3;
  int selectedAddress = 0;

  @override
  void dispose() {

    super.dispose();
    _controller.dispose();
  }
  double userLatitude = 37.7749;
  double userLongitude = -122.4194;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  //  storeBloc.mapEventToState(PrimaryStores(
    //  latitude: userLatitude,
    //  longitude: userLongitude,
   // )
   // );
  }

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const MainScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  width: 5, color: const Color.fromARGB(134, 80, 182, 84))),
          child: FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 80, 182, 83),
            elevation: 10,
            child: const Icon(
              Icons.shopping_bag_outlined,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.09,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = const MainScreen();
                          currentTab = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.home_rounded,
                            color: currentTab == 0 ? Colors.green : Colors.grey,
                            size: 30,
                          ),
                          Text(
                            'Home',
                            style: TextStyle(
                              color:
                                  currentTab == 0 ? Colors.green : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = const Nearby();
                          currentTab = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_pin,
                            color: currentTab == 1 ? Colors.green : Colors.grey,
                            size: 30,
                          ),
                          Text(
                            'Nearby',
                            style: TextStyle(
                              color:
                                  currentTab == 1 ? Colors.green : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = const Share();
                          currentTab = 2;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.share,
                            color: currentTab == 2 ? Colors.green : Colors.grey,
                            size: 30,
                          ),
                          Text(
                            'Share',
                            style: TextStyle(
                              color:
                                  currentTab == 2 ? Colors.green : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = const Profile();
                          currentTab = 3;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person_2_rounded,
                            color: currentTab == 3 ? Colors.green : Colors.grey,
                            size: 30,
                          ),
                          Text(
                            'Profile',
                            style: TextStyle(
                              color:
                                  currentTab == 3 ? Colors.green : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  LatLng? _pickedLocation;
  var _isSelected = false;
  double rating = 3;
  int selectedAddress = 0;
  @override
  Widget build(BuildContext context) {
    StoreBloc storeBloc = BlocProvider.of<StoreBloc>(context);
    UserBloc userBloc = BlocProvider.of<UserBloc>(context);

    // User2 user = userBloc.getUser;
    // String add = userBloc.getSelectedUserAddress.toString();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 134, 4),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12))),
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              const Text(
                'Hello, ',
                style: TextStyle(color: Colors.white, fontSize: 31),
              ),
              StreamBuilder<User2>(
                  stream: userBloc.getUserStream,
                  initialData: userBloc.getUser,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        snapshot.data != null
                            ? snapshot.data!.name.toString()
                            : 'Guest',
                        style: TextStyle(color: Colors.white, fontSize: 31),
                      );
                    } else if (snapshot.hasError) {
                      return Text(
                        'Guest',
                        style: TextStyle(color: Colors.white, fontSize: 31),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: const Text(
              'Your Location',
              style: TextStyle(color: Colors.white54),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 2.0,
              right: 0.0,
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: const Icon(
                      Icons.location_pin,
                      color: Colors.white,
                      // size: 35,
                    ),
                  ),
                  StreamBuilder<UserAddress>(
                      stream: userBloc.selectedAddressStream,
                      initialData: userBloc.getSelectedUserAddress,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SizedBox(
                            height: 40,
                            width: 180,
                            child: Center(
                              child: Text(
                                snapshot.data!.displayAddress().toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          );
                        } else{
                          return SizedBox(
                            height: 40,
                            width: 180,
                            child: Center(
                              child: Text(
                                "Select your location",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          );
                        }
                      }),
                  SizedBox(
                    height: 40,
                    child: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (BuildContext context) {
                              return Card(
                                margin: const EdgeInsets.all(8.0),
                                elevation: 5,
                                child: Container(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.45,
                                  padding: EdgeInsets.only(
                                    top: 10,
                                    left: 10,
                                    right: 10,
                                    bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom +
                                        10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Change Delivery Location",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0),
                                      ),
                                      Text(
                                        "Select a delivery location to see Store Availability",
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      StatefulBuilder(
                                        builder: (BuildContext context,
                                                StateSetter mySetState) =>
                                            StreamBuilder<User2>(
                                          initialData: userBloc.getUser,
                                          stream: userBloc.getUserStream,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              if (snapshot.hasError) {
                                                return Text(
                                                    "Something went wrong");
                                              } else {
                                                // savedAddress = snapshot.data.addresses;
                                                return Container(
                                                  width: double.infinity,
                                                  height: 100,
                                                  child: ListView.separated(
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    primary: false,
                                                    physics:
                                                        ClampingScrollPhysics(),
                                                    // reverse: true,
                                                    separatorBuilder:
                                                        (context, count) {
                                                      return SizedBox(width: 5);
                                                    },
                                                    itemCount: snapshot.data!
                                                        .addresses!.length,
                                                    itemBuilder:
                                                        (context, count) {
                                                      // print(snapshot.data);
                                                      return Card(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.0),
                                                        ),
                                                        elevation: 2,
                                                        margin: const EdgeInsets
                                                            .all(5.0),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.0),
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                .amberAccent,
                                                            onTap: () {
                                                              mySetState(() {
                                                                _isSelected =
                                                                    !_isSelected;
                                                                // _selectedIndex = count;
                                                                selectedAddress =
                                                                    count;
                                                                setUserLocationIndex(
                                                                    count);
                                                              });

                                                              userBloc.mapEventToState(
                                                                  SelectUserAddress(
                                                                      index:
                                                                          count));

                                                              // print(
                                                              //     "Index is : $selectedAddress");
                                                            },
                                                            child: StreamBuilder<
                                                                UserAddress>(
                                                              stream: userBloc
                                                                  .selectedAddressStream,
                                                              initialData: userBloc
                                                                  .getSelectedUserAddress,
                                                              builder: (context,
                                                                  selectedAddress) {
                                                                if (snapshot
                                                                    .hasData) {
                                                                  if (snapshot
                                                                      .hasError) {
                                                                    return Center(
                                                                        child: Text(
                                                                            "Something went wrong"));
                                                                  } else {
                                                                    return Container(
                                                                      color: selectedAddress.data ==
                                                                              snapshot.data!.addresses![
                                                                                  count]
                                                                          ? Colors
                                                                              .amber
                                                                          : Colors
                                                                              .white,
                                                                      width:
                                                                          100.0,
                                                                      height:
                                                                          100.0,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            FittedBox(
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: <Widget>[
                                                                              Text(
                                                                                "${snapshot.data!.addresses![count].locality}",
                                                                                style: TextStyle(
                                                                                  fontSize: 18,
                                                                                  color: Colors.black,
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                "${snapshot.data!.addresses![count].city} , ${snapshot.data!.addresses![count].state}",
                                                                                style: TextStyle(
                                                                                  fontSize: 15,
                                                                                  color: Colors.black,
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                "${snapshot.data!.addresses![count].postalCode} ",
                                                                                style: TextStyle(
                                                                                  fontSize: 15,
                                                                                  color: Colors.black,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }
                                                                }
                                                                return Center(
                                                                    child: Text(
                                                                        "No Address Found"));
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                );
                                              }
                                            } else {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                      TextButton.icon(
                                        icon: Icon(
                                          Icons.location_searching,
                                          size: 15.0,
                                        ),
                                        label: Text("Add Another location",
                                            style: TextStyle(fontSize: 15.0)),
                                        onPressed: () async {
                                          Position position = await Geolocator
                                              .getCurrentPosition(
                                                  desiredAccuracy:
                                                      LocationAccuracy.high);
                                          _pickedLocation =
                                              await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Material(
                                                child: FlutterLocationPicker(
                                                    initPosition: LatLong(
                                                        position.latitude,
                                                        position.longitude),
                                                    selectLocationButtonStyle:
                                                        ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(Colors.blue),
                                                    ),
                                                    selectLocationButtonText:
                                                        'Set Current Location',
                                                    initZoom: 11,
                                                    minZoomLevel: 5,
                                                    maxZoomLevel: 16,
                                                    trackMyPosition: true,
                                                    onError: (e) => print(e),
                                                    onPicked: (pickedData) {
                                                      print(pickedData
                                                          .latLong.latitude);
                                                      print(pickedData
                                                          .latLong.longitude);
                                                      print(pickedData.address);
                                                      print(pickedData
                                                              .addressData[
                                                          'country']);
                                                      _pickedLocation = LatLng(
                                                          pickedData
                                                              .latLong.latitude,
                                                          pickedData.latLong
                                                              .longitude);
                                                      if (_pickedLocation !=
                                                          null) {
                                                        userBloc.mapEventToState(
                                                            AddAddressByLatLng(
                                                                latLng:
                                                                    _pickedLocation!
                                                                // .latLng
                                                                ));
                                                      }
                                                      setState(() {
                                                        _isSelected = false;
                                                      });
                                                      Navigator.pop(context);
                                                    }),
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      icon: const Icon(
                        Icons.arrow_drop_down,
                      ),
                      splashRadius: 20.0,
                    ),
                  ),
                ]),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      width: 200,
                      height: 45,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            textAlign: TextAlign.start,
                            controller: _controller,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search Laundry and More',
                            ),
                            autofocus: false,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 112, 35, 255),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.search_rounded,
                                color: Colors.white,
                              ),
                              Text(
                                'Search',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        )),
                  )
                ],
              ),
            ),
          )
        ]),
        toolbarHeight: 200,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text(
                      'Top Services',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 260,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Expanded(
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              HomeStoreListBuilder()));
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 70,
                                          width: 100,
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [BoxShadow(blurRadius: 7)],
                                              shape: BoxShape.circle),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Image.asset(
                                              'assets/Images/clean.png',
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text('Wash & Fold'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              HomeStoreListBuilder()));
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 70,
                                          width: 100,
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [BoxShadow(blurRadius: 7)],
                                              shape: BoxShape.circle),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                              'assets/Images/ironing.png',
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text('Wash & Iron'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              HomeStoreListBuilder()));
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 70,
                                          width: 100,
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [BoxShadow(blurRadius: 7)],
                                              shape: BoxShape.circle),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Image.asset(
                                              'assets/Images/coat.png',
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text('Dry Cleaning'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              HomeStoreListBuilder()));
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 70,
                                          width: 100,
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [BoxShadow(blurRadius: 7)],
                                              shape: BoxShape.circle),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                              'assets/Images/carpet-cleaner.png',
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text('Carpet Clean'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 18.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              HomeStoreListBuilder()));
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 70,
                                          width: 100,
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [BoxShadow(blurRadius: 7)],
                                              shape: BoxShape.circle),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                              'assets/Images/washing-clothes.png',
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'Laudary\nPremium',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              HomeStoreListBuilder()));
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 70,
                                          width: 100,
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [BoxShadow(blurRadius: 7)],
                                              shape: BoxShape.circle),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                              'assets/Images/cleaning.png',
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'Sofa\nCleaning',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              HomeStoreListBuilder()));
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 70,
                                          width: 100,
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [BoxShadow(blurRadius: 7)],
                                              shape: BoxShape.circle),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                              'assets/Images/hand-sanitizer.png',
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'Sanitization\n  ',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text(
                      'Popular Laundry Nearby',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),




                    SizedBox(
                    height: 200,
                    child: StreamBuilder<List<Store>>(
                      stream: storeBloc.selectedStoreStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<Store> stores = snapshot.data!;
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: stores.length,
                            itemBuilder: ((context, index) {
                              Store store = stores[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 300,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(7),
                                            border: Border.all(
                                              color: Colors.grey,
                                            ),
                                            color: Colors.white,
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              'assets/Images/laundry.jpg',
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 75,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    store.name??'',
                                                    style: TextStyle(fontSize: 20),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.yellow,
                                                      ),
                                                      Text("${store.rating} Rating"),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    store.address as String,
                                                    style: TextStyle(color: Colors.grey),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        width: 3,
                                                        color: Colors.yellow,
                                                      ),
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(30),
                                                        bottomRight: Radius.circular(30),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Text('View Details'),
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
                              );
                            }),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  )


                  /* SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: 300,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(7)),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          border: Border.all(
                                            color: Colors.grey,
                                          ),
                                          color: Colors.white,
                                        ),
                                        child: Center(
                                            child: Image.asset(
                                          'assets/Images/laundry.jpg',
                                          fit: BoxFit.contain,
                                        ))),
                                  ),
                                  SizedBox(
                                    height: 75,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Peity Laundrywala',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                              Row(
                                                children: const [
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.yellow,
                                                  ),
                                                  Text("4.5 Rating")
                                                ],
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Delhi,Gurgaon',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      width: 3,
                                                      color: Colors.yellow,
                                                    ),
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(30),
                                                      bottomRight:
                                                          Radius.circular(30),
                                                    )),
                                                child: const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.0, right: 8.0),
                                                  child: Text('View Details'),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        );
                      }),
                    ),
                  )*/
                ],
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text(
                      'Happy Cutsomers',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: 200,
                        width: 40,
                        child: Center(child: Icon(Icons.arrow_left_rounded)),
                      ),
                      SizedBox(
                        height: 200,
                        width: MediaQuery.of(context).size.width - 90,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Expanded(
                                child: Container(
                                  width: 320,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: const Color.fromARGB(
                                        255, 219, 255, 203),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: const [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80'),
                                      ),
                                      Text(
                                        'Hema Sharma',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "\"This app been very helpful\n to at times of loads of laundry in my room.\"",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 121, 121, 121)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      const SizedBox(
                        height: 200,
                        width: 40,
                        child: Center(child: Icon(Icons.arrow_right_rounded)),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text(
                      'Other Home Services',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            height: 160,
                            width: 120,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 154, 209, 255),
                                borderRadius: BorderRadius.circular(25)),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      height: 90,
                                      width: 70,
                                      child: Image.asset(
                                          'assets/Images/mechanic.png')),
                                  const Text('Mechanic',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      )),
                                  const Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding: EdgeInsets.all(14.0),
                                      child: Icon(
                                          Icons.arrow_circle_right_rounded),
                                    ),
                                  )
                                ])),
                        Container(
                            height: 160,
                            width: 120,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 167, 201, 87),
                                borderRadius: BorderRadius.circular(25)),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      height: 90,
                                      width: 70,
                                      child: Image.asset(
                                          'assets/Images/plumber.png')),
                                  const Text('Plumber',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      )),
                                  const Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding: EdgeInsets.all(14.0),
                                      child: Icon(
                                          Icons.arrow_circle_right_rounded),
                                    ),
                                  )
                                ])),
                        Container(
                            height: 160,
                            width: 120,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 252, 186, 148),
                                borderRadius: BorderRadius.circular(25)),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      height: 90,
                                      width: 70,
                                      child: Image.asset(
                                          'assets/Images/electrician.png')),
                                  const Text('Electrician',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      )),
                                  const Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding: EdgeInsets.all(14.0),
                                      child: Icon(
                                          Icons.arrow_circle_right_rounded),
                                    ),
                                  )
                                ]))
                      ])
                ],
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 18.0, bottom: 18.0),
                    child: Text(
                      'Testmonials',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    height: 260,
                    width: 400,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 2,
                          )
                        ]),
                    child: Stack(
                        alignment: Alignment.center,
                        fit: StackFit.loose,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 130,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(14),
                                        topRight: Radius.circular(14))),
                                child: const Center(
                                  child: Text(
                                    "\"Lorem ipsum dolor sit amet consectetur. Volutpat \n ac egestas quis enim hendrerit\"",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 59, 59, 59)),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width: 400,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 192, 107, 231),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(14),
                                        bottomRight: Radius.circular(14)),
                                  ),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Mukul Nimker",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17),
                                          ),
                                        ),
                                        Text("CEO of Peity Services",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 78, 78, 78),
                                                fontSize: 15)),
                                        SizedBox(
                                          height: 20,
                                        )
                                      ]),
                                ),
                              )
                            ],
                          ),
                          const CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1448&q=80'),
                            radius: 30,
                          ),
                        ]),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                height: 160,
                width: 400,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 157, 54, 175),
                      Color.fromARGB(255, 0, 3, 153),
                    ]),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 2,
                      )
                    ]),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'We keep you &\n your laundary safe',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    SizedBox(
                      height: 120,
                      width: 105,
                      child: Image.asset('assets/Images/laundry2.png',
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Nearby extends StatefulWidget {
  const Nearby({super.key});

  @override
  State<Nearby> createState() => _NearbyState();
}

class _NearbyState extends State<Nearby> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

class Share extends StatefulWidget {
  const Share({super.key});

  @override
  State<Share> createState() => _ShareState();
}

class _ShareState extends State<Share> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
