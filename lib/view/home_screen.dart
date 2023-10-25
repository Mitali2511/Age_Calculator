import 'package:agecalculator/commom%20widgets/utility.dart';
import 'package:agecalculator/provider/calculator_provider.dart';
import 'package:agecalculator/view/favourite_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List element = [];

  List<Map<String, dynamic>> userinfo = [];
  refreshData() {
    final data = CalculatorProvider.userlist.keys.map((key) {
      final items = CalculatorProvider.userlist.get(key);
      return {"key": key, "name": items["name"], "birthdate": items["birth"]};
    }).toList();

    setState(() {
      userinfo = data.reversed.toList();
      print("${userinfo.length},inside refresh");
    });
  }

  TextEditingController name = TextEditingController();
  TextEditingController currentDate = TextEditingController();
  TextEditingController getDate = TextEditingController();

  int days = 0;
  int months = 0;
  int years = 0;
  int nextBirthMonth = 0;
  int nextBirthDays = 0;
  DateTime? selectDate;

  Map<String, dynamic>? totalAge;
  Map<String, dynamic>? nextBirthDate;
  Map<String, dynamic>? totalLife;

  getCurrentDate() {
    DateTime currentDate = DateTime.now();
    this.currentDate.text = DateFormat('dd-MM-yyyy').format(currentDate);

    setState(() {});
  }

  @override
  void initState() {
    getCurrentDate();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FavScreen()));
              },
              child: const Icon(
                Icons.favorite,
                color: Colors.white,
                size: 30.0,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            const Icon(
              Icons.share,
              color: Colors.white,
              size: 30.0,
            ),
          ],
          backgroundColor: const Color.fromARGB(255, 91, 72, 177),
          title: const Text(
            'Age Calculator',
            style: TextStyle(color: Colors.white),
          ),
        ),
//body
        body: SafeArea(
          child: Column(children: [
            Container(
              height: 100,
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              color: const Color.fromARGB(255, 91, 72, 177),
              child: Column(
                children: [
                  const Text("Date of Today",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: currentDate,
                      readOnly: true,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          fillColor: Colors.white,
                          filled: true,
                          suffixIcon: GestureDetector(
                              child: const CircleAvatar(
                            foregroundColor: Colors.white,
                            backgroundColor: Color.fromARGB(255, 91, 72, 177),
                            child: Icon(Icons.calendar_month_outlined),
                          )),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Utility.customizedText(text: "Date of Birth"),
                  SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: TextField(
                        readOnly: true,
                        controller: getDate,
                        onTap: () async {
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2101),
                          );
                          selectDate = picked;
                          if (picked != null && selectDate != null) {
                            getDate.text =
                                DateFormat('dd-MM-yyyy').format(picked);
                          }
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            fillColor: Colors.white,
                            filled: true,
                            suffixIconConstraints:
                                BoxConstraints.tight(Size.fromRadius(30)),
                            suffixIcon: GestureDetector(
                                child: const CircleAvatar(
                              foregroundColor: Colors.white,
                              backgroundColor: Color.fromARGB(255, 91, 72, 177),
                              child: Icon(Icons.calendar_month_outlined),
                            )),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30))),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        child: ElevatedButton(
                            onPressed: () {
                              if (selectDate != null) {
                                totalAge =
                                    CalculatorProvider.calculateAgeDifference(
                                        selectDate!);
                                nextBirthDate =
                                    CalculatorProvider.calculateNextBirthday(
                                        selectDate!);
                                totalLife =
                                    CalculatorProvider.calculateTotalLife(
                                        selectDate!);
                              } else {
                                Fluttertoast.showToast(
                                  msg: 'Please select date',
                                  fontSize: 14,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                );
                                print('please enter values');
                              }
                              setState(() {});
                            },
                            child: const Text('Calculate'),
                            style: ElevatedButton.styleFrom(
                                elevation: 4,
                                textStyle: const TextStyle(fontSize: 16),
                                backgroundColor:
                                    const Color.fromARGB(255, 91, 72, 177),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ))),
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        child: ElevatedButton(
                            onPressed: () async {
                              if (getDate.text.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "Please select date first",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    fontSize: 16.0);
                              } else {
                                await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        scrollable: false,
                                        actions: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              OutlinedButton(
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                            255, 91, 72, 177),
                                                  ),
                                                  onPressed: () async {
                                                    bool? ispresent;
                                                    refreshData();

                                                    for (int i = 0;
                                                        i < userinfo.length;
                                                        i++) {
                                                      String newName =
                                                          userinfo[i]["name"];
                                                      if (newName ==
                                                          name.text) {
                                                        print("inside true");
                                                        ispresent = true;
                                                        element.add(true);
                                                        print(newName);
                                                        print(element);
                                                        print(name.text);
                                                      } else {
                                                        print("inside false");
                                                        element.add(false);
                                                        ispresent = false;
                                                        print(newName);
                                                        print(name.text);
                                                      }
                                                    }
                                                    print(ispresent);
                                                    print(element);
                                                    if (element
                                                        .contains(true)) {
                                                      print("contains value");
                                                      element = [];
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "username is already taken",
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity: ToastGravity
                                                              .CENTER,
                                                          timeInSecForIosWeb: 1,
                                                          fontSize: 16.0);
                                                    } else {
                                                      CalculatorProvider
                                                          .createuserList({
                                                        "name": name.text,
                                                        "birth": getDate.text
                                                      });
                                                      refreshData();
                                                      name.clear();
                                                      Navigator.pop(context);
                                                      element = [];

                                                      setState(() {});
                                                    }
                                                  },
                                                  child: const Text(
                                                    "Save",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              OutlinedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    name.clear();
                                                    setState(() {});
                                                  },
                                                  child: const Text(
                                                    "Clear",
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 91, 72, 177)),
                                                  ))
                                            ],
                                          ),
                                        ],
                                        title: const Text(
                                            "Please enter your name"),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextField(
                                              controller: name,
                                              decoration: InputDecoration(
                                                  labelText: "Name",
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15))),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            TextField(
                                              readOnly: true,
                                              controller: getDate,
                                              decoration: InputDecoration(
                                                  labelText: "Date of birth",
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15))),
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              }
                            },
                            child: const Text('Save'),
                            style: ElevatedButton.styleFrom(
                                elevation: 4,
                                textStyle: const TextStyle(fontSize: 16),
                                backgroundColor: Colors.white,
                                foregroundColor:
                                    const Color.fromARGB(255, 91, 72, 177),
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: Color.fromARGB(255, 91, 72, 177)),
                                  borderRadius: BorderRadius.circular(10),
                                ))),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //Total Age

                  Utility.customizedText(text: 'Total Age'),
                  const SizedBox(
                    height: 15,
                  ),

                  Utility.containerDecoration(
                    height: MediaQuery.sizeOf(context).height*0.1,
                    widget: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.edit_calendar_outlined,
                                    color: Color.fromARGB(255, 70, 70, 70),
                                  ),
                                  Utility.smallText(small_text: 'Year'),
                                ],
                              ),
                              Utility.customizedText(
                                  text:
                                      '${totalAge != null ? totalAge!["years"] : 0}'),
                            ],
                          ),
                          Utility.separater(height: 50.0),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.edit_calendar_outlined,
                                    color: Color.fromARGB(255, 70, 70, 70),
                                  ),
                                  Utility.smallText(small_text: 'Month'),
                                ],
                              ),
                              Utility.customizedText(
                                  text:
                                      '${totalAge != null ? totalAge!["months"] : 0}'),
                            ],
                          ),
                          Utility.separater(height: 50.0),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.edit_calendar_outlined,
                                    color: Color.fromARGB(255, 70, 70, 70),
                                  ),
                                  Utility.smallText(small_text: 'Days'),
                                ],
                              ),
                              Utility.customizedText(
                                  text:
                                      '${totalAge != null ? totalAge!["days"] : 0}'),
                            ],
                          ),
                        ]),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  //Next Birthday

                  Utility.customizedText(text: 'Next Birthday'),
                  const SizedBox(
                    height: 10,
                  ),

                  Utility.containerDecoration(
                      height: MediaQuery.sizeOf(context).height*0.09,
                      widget: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.edit_calendar_outlined,
                                    color: Color.fromARGB(255, 70, 70, 70),
                                  ),
                                  Utility.smallText(small_text: 'Months'),
                                ],
                              ),
                              Utility.customizedText(
                                  text:
                                      '${nextBirthDate != null ? nextBirthDate!["months"] : 0}'),
                            ],
                          ),
                          Utility.separater(height: 40),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.edit_calendar_outlined,
                                    color: Color.fromARGB(255, 70, 70, 70),
                                  ),
                                  Utility.smallText(small_text: 'Days'),
                                ],
                              ),
                              Utility.customizedText(
                                  text:
                                      '${nextBirthDate != null ? nextBirthDate!["days"] : 0}'),
                            ],
                          ),
                        ],
                      )),

                  //Total Life Of
                  const SizedBox(
                    height: 10,
                  ),
                  Utility.customizedText(text: 'Total Life Of'),
                  const SizedBox(
                    height: 10,
                  ),
                  Utility.containerDecoration(
                      height:MediaQuery.sizeOf(context).height*0.18,
                      widget: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Utility.smallText(small_text: 'Years'),
                              Utility.smallText(small_text: 'Months'),
                              Utility.smallText(small_text: 'Days'),
                              Utility.smallText(small_text: 'Weeks'),
                              Utility.smallText(small_text: 'Hours')
                            ],
                          ),
                          Utility.separater(height: MediaQuery.sizeOf(context).height*0.09,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Utility.customizedText(
                                  text:
                                      '${totalAge != null ? totalAge!["years"] : 0}'),
                              Utility.customizedText(
                                  text:
                                      '${totalLife != null ? totalLife!["months"] : 0}'),
                              Utility.customizedText(
                                  text:
                                      '${totalLife != null ? totalLife!["days"] : 0}'),
                              Utility.customizedText(
                                  text:
                                      '${totalLife != null ? totalLife!["weeks"] : 0}'),
                              Utility.customizedText(
                                  text:
                                      '${totalLife != null ? totalLife!["hours"] : 0}'),
                            ],
                          ),
                        ],
                      )),
                ]),
              )),
            ),
            Container(
              height: MediaQuery.sizeOf(context).height * 0.1,
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              color: const Color.fromARGB(255, 91, 72, 177),
            ),
          ]),
        ));
  }
}
