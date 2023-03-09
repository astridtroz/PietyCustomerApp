import 'package:flutter/material.dart';

TextEditingController _controller = TextEditingController();

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTab = 0;

  final List<Widget> screens = [
    const MainScreen(),
    const Nearby(),
    const Share(),
    const Profile()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const MainScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: Container(
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
  @override
  Widget build(BuildContext context) {
    _controller.text = "Delhi,Gurgaon,Sector14";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 134, 4),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12))),
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'Hello, Mukul',
            style: TextStyle(color: Colors.white, fontSize: 31),
          ),
          const Text(
            'Your Local Name',
            style: TextStyle(color: Colors.white54),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.location_pin,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 40,
                    width: 200,
                    child: TextFormField(
                      controller: _controller,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white))),
                    ),
                  )
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
                children: [
                  SizedBox(
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          label: Text('Search Laundry and More'),
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
                    child: Text('Top Services', style: TextStyle(fontSize: 27)),
                  ),
                  Column(
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 70,
                                width: 100,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [BoxShadow(blurRadius: 5)],
                                    shape: BoxShape.circle),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Image.asset(
                                    'assets/icons/Wash_Fold.png',
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
                          Column(
                            children: [
                              Container(
                                height: 70,
                                width: 100,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [BoxShadow(blurRadius: 5)],
                                    shape: BoxShape.circle),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/icons/ironing.png',
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
                          Column(
                            children: [
                              Container(
                                height: 70,
                                width: 100,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [BoxShadow(blurRadius: 5)],
                                    shape: BoxShape.circle),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image.asset(
                                    'assets/icons/Dry_Cleaning.png',
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
                          Column(
                            children: [
                              Container(
                                height: 70,
                                width: 100,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [BoxShadow(blurRadius: 5)],
                                    shape: BoxShape.circle),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/icons/Carpet_Cleaning.png',
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
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 70,
                                  width: 100,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [BoxShadow(blurRadius: 5)],
                                      shape: BoxShape.circle),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'assets/icons/Laundary.png',
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
                            Column(
                              children: [
                                Container(
                                  height: 70,
                                  width: 100,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [BoxShadow(blurRadius: 5)],
                                      shape: BoxShape.circle),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'assets/icons/Sofa_Clean.png',
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
                          ],
                        ),
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
                      'Popular Laundary Nearby',
                      style: TextStyle(
                        fontSize: 27,
                      ),
                    ),
                  ),
                  SizedBox(
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
                                          'assets/Images/washing.png',
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
                      'Happy Cutsomers',
                      style: TextStyle(
                        fontSize: 27,
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
                                        "\"This app been very helpful\n to at times of loads of luandry in my room.\"",
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
                                      child: Image.asset('assets/Images/mechanic.png')),
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
                                      child: Image.asset('assets/Images/water_tap.png')),
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
                                      child: Image.asset('assets/Images/electrician.png')),
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
                    padding: EdgeInsets.all(18.0),
                    child: Text(
                      'Testmonials',
                      style: TextStyle(
                        fontSize: 27,
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
                                            child: 
                                          Text("\"Lorem ipsum dolor sit amet consectetur. Volutpat \n ac egestas quis enim hendrerit\"",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 59, 59, 59)),
                                          ),

                                          ),
                                          
                                          
                                          ),
                              Expanded(
                                child: Container(
                                  width: 400,
                                  
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 192, 107, 231),
                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(14), bottomRight: Radius.circular(14)),
                                  ),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text("Mukul Nimker", style: TextStyle(color: Colors.white,fontSize: 17),),
                                        ),
                                        Text("CEO of Peity Services", style: TextStyle(color: Color.fromARGB(255, 78, 78, 78),fontSize: 15)),
                                        SizedBox(height: 20,)
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
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 157, 54, 175),
                      Color.fromARGB(255, 0, 3, 153),
                    ]
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 2,
                    )]
                ),
              
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('We keep you &\n your laundary safe', style: TextStyle(color: Colors.white, fontSize: 25),),
                  Image.asset('assets/Images/washing.png')
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
