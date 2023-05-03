import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  TextEditingController _pickaddress = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _pickaddress.text = "Delhi,gurgaoan,sector14";
    TextEditingController dateinput = TextEditingController();
    //text editing controller for text field

    @override
    void initState() {
      dateinput.text = ""; //set the initial value of text field
      super.initState();
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 220, 255, 221),
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_rounded),
        title: const Text('Checkout'),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Customer Profile',
                      style: TextStyle(
                        color: Color.fromARGB(255, 77, 77, 77),
                        fontSize: 21,
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.dashed,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Name',
                        style: TextStyle(
                            color: Color.fromARGB(255, 77, 77, 77),
                            fontSize: 16),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Nishant kaul',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Contact No',
                        style: TextStyle(
                            color: Color.fromARGB(255, 77, 77, 77),
                            fontSize: 16),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        '6156378940',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Pickup Address',
                        style: TextStyle(
                            color: Color.fromARGB(255, 77, 77, 77),
                            fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                        height: 34,
                        child: TextFormField(
                          controller: _pickaddress,
                          decoration: InputDecoration(
                              suffix: TextButton(
                                child: const Text(
                                  'Change',
                                  style: TextStyle(color: Colors.blue),
                                ),
                                onPressed: () {},
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.green, width: 2.6),
                                  borderRadius: BorderRadius.circular(6)),
                              border: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.green, width: 12),
                              )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Available Date & Time',
                      style: TextStyle(
                        color: Color.fromARGB(255, 77, 77, 77),
                        fontSize: 21,
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.dashed,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0, top: 8),
                      child: Text(
                        'Select Delivery Date & Time*',
                        style: TextStyle(
                            color: Color.fromARGB(255, 77, 77, 77),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                          height: 34,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 50,
                                width: 100,
                                child: Center(
                                    child: TextField(
                                  controller:
                                      dateinput, //editing controller of this TextField
                                  decoration: const InputDecoration(
                                      labelText: "Date", //label text of field
                                      border: OutlineInputBorder()),
                                  readOnly:
                                      true, //set it true, so that user will not able to edit text
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(
                                            2000), //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime(2101));

                                    if (pickedDate != null) {
                                      print(
                                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                      String formattedDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickedDate);
                                      print(
                                          formattedDate); //formatted date output using intl package =>  2021-03-16
                                      //you can implement different kind of Date Format here according to your requirement

                                      setState(() {
                                        dateinput.text =
                                            formattedDate; //set output date to TextField value.
                                      });
                                    } else {
                                      print("Date is not selected");
                                    }
                                  },
                                )),
                              ),
                              Container(
                                height: 50,
                                width: 100,
                                child: Center(
                                    child: TextField(
                                  controller:
                                      dateinput, //editing controller of this TextField
                                  decoration: const InputDecoration(
                                      //icon of text field
                                      labelText: "Time", //label text of field
                                      border: OutlineInputBorder()),
                                  readOnly:
                                      true, //set it true, so that user will not able to edit text
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(
                                            2000), //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime(2101));

                                    if (pickedDate != null) {
                                      print(
                                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                      String formattedDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickedDate);
                                      print(
                                          formattedDate); //formatted date output using intl package =>  2021-03-16
                                      //you can implement different kind of Date Format here according to your requirement

                                      setState(() {
                                        dateinput.text =
                                            formattedDate; //set output date to TextField value.
                                      });
                                    } else {
                                      print("Date is not selected");
                                    }
                                  },
                                )),
                              ),
                            ],
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Selected Services',
                          style: TextStyle(
                            color: Color.fromARGB(255, 77, 77, 77),
                            fontSize: 21,
                            decoration: TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.dashed,
                          ),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Add Services',
                              style: TextStyle(color: Colors.blue),
                            ))
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0, top: 8),
                      child: Text(
                        '(Your Minimum Order amount is: 300.0)',
                        style: TextStyle(
                            color: Color.fromARGB(255, 77, 77, 77),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 11.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13),
                                    color: Colors.white,
                                    border: Border.all()),
                                child: Padding(
                                  padding: const EdgeInsets.all(17.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: const [
                                            Icon(
                                              Icons.circle,
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 8.0),
                                              child: Text('Sofa Cleaning',
                                                  style:
                                                      TextStyle(fontSize: 21)),
                                            ),
                                          ]),
                                      Row(
                                        children: const [
                                          Icon(
                                            Icons.remove_circle_outline,
                                            color: Colors.grey,
                                          ),
                                          Text(
                                            '0',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          Icon(
                                            Icons.add_circle_outlined,
                                            color: Colors.amber,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 11.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13),
                                    color: Colors.white,
                                    border: Border.all()),
                                child: Padding(
                                  padding: const EdgeInsets.all(17.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: const [
                                            Icon(
                                              Icons.circle,
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 8.0),
                                              child: Text('Wash & Fold',
                                                  style:
                                                      TextStyle(fontSize: 21)),
                                            ),
                                          ]),
                                      Row(
                                        children: const [
                                          Icon(
                                            Icons.remove_circle_outline,
                                            color: Colors.amber,
                                          ),
                                          Text(
                                            '1',
                                            style:
                                                TextStyle(color: Colors.green),
                                          ),
                                          Icon(
                                            Icons.add_circle_outlined,
                                            color: Colors.amber,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 11.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13),
                                    color: Colors.white,
                                    border: Border.all()),
                                child: Padding(
                                  padding: const EdgeInsets.all(17.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: const [
                                            Icon(
                                              Icons.circle,
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 8.0),
                                              child: Text('Wash & Iron',
                                                  style:
                                                      TextStyle(fontSize: 21)),
                                            ),
                                          ]),
                                      Row(
                                        children: const [
                                          Icon(
                                            Icons.remove_circle_outline,
                                            color: Colors.amber,
                                          ),
                                          Text(
                                            '6',
                                            style:
                                                TextStyle(color: Colors.green),
                                          ),
                                          Icon(
                                            Icons.add_circle_outlined,
                                            color: Colors.amber,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: Colors.black),
                            )),
                        TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Apply',
                              style: TextStyle(color: Colors.white),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Delivery Type',
                      style: TextStyle(
                        color: Color.fromARGB(255, 77, 77, 77),
                        fontSize: 21,
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.dashed,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                height: 60,
                                width: 140,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.amber,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Regular Delivery'),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text('50.00'),
                                          Text('48.0 hours')
                                        ],
                                      )
                                    ],
                                  ),
                                )),
                            Container(
                                height: 60,
                                width: 140,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: Colors.white,
                                    border: Border.all()),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Express Delivery'),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text('100.00'),
                                          Text('12.0 hours')
                                        ],
                                      )
                                    ],
                                  ),
                                )),
                          ]),
                    )
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height * 0.09,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                    'Check all the clothes after reciveing infront of delivery partner.'),
              ),
              Container(
                width: 100,
                child: TextButton(
                  child: Text(
                    'Place order',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: TextButton.styleFrom(backgroundColor: Colors.orange),
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
