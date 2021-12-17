import 'package:apod/view/pages/particuler_date_page.dart';
import 'package:apod/view/pages/today_picture_page.dart';
import 'package:apod/view/ui_helpers/ui_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Lottie.asset('assets/lotties/nasa.json'),
                const Text("Welcome to the Astronomy Picture of the Day App",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
                const SizedBox(height: 60.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.maxFinite, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) => const TodayPicturePage()));
                  },
                  child: const Text(
                    "Today's Astronomy Picture",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.maxFinite, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                          builder: (BuildContext context,
                              void Function(void Function()) setStateSheet) {
                            return Center(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    const Text('Your Date Astronomy Picture'),
                                    ListTile(
                                      contentPadding: const EdgeInsets.all(8.0),
                                      title: const Text(
                                        'Your Date Astronomy Picture',
                                        style: TextStyle(color: Colors.black38),
                                      ),
                                      subtitle: Text(_selectedDate ==
                                              null //ternary expression to check if date is null
                                          ? 'Please pick your Date!'
                                          : 'Your Selected Date : ${_selectedDate!.formatMyDate()}'),
                                      trailing: IconButton(
                                          onPressed: () {
                                            showDatePicker(
                                                    context: context,
                                                    helpText:
                                                        'Select your date',
                                                    fieldLabelText:
                                                        'Select your date',
                                                    initialDate: DateTime.now(),
                                                    //which date will display when user open the picker
                                                    firstDate: DateTime(1996),
                                                    //what will be the previous supported year in picker
                                                    lastDate: DateTime
                                                        .now()) //what will be the up to supported date in picker
                                                .then((pickedDate) {
                                              //then usually do the future job
                                              if (pickedDate == null) {
                                                //if user tap cancel then this function will stop
                                                return;
                                              }
                                              setStateSheet(() {
                                                //for rebuilding the ui
                                                _selectedDate = pickedDate;
                                              });
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.calendar_today,
                                          )),
                                    ),
                                    _selectedDate == null
                                        ? const SizedBox()
                                        : ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              minimumSize: const Size(
                                                  double.maxFinite, 60),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      fullscreenDialog: true,
                                                      builder: (context) =>
                                                          ParticulerPicturePage(
                                                            date: _selectedDate!
                                                                .formatMyDate(),
                                                          )));
                                            },
                                            child: Text(
                                              " ${_selectedDate!.formatMyDate()} Astronomy Picture",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0,
                                              ),
                                            ),
                                          ),
                                    const SizedBox(height: 8.0),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize:
                                            const Size(double.maxFinite, 56.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "close",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  child: const Text(
                    "Your Date Astronomy Picture",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
