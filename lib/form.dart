import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_name_surname/home_screen.dart';
import 'package:form_name_surname/user_data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NameForm extends StatefulWidget {
  const NameForm({Key? key}) : super(key: key);

  @override
  State<NameForm> createState() => _NameFormState();
}

class _NameFormState extends State<NameForm> {
  final _formkey = GlobalKey<FormState>();
  late SharedPreferences sharedPreferences;
  late List<String> dataList = [];

  TextEditingController _host = TextEditingController();
  TextEditingController _port = TextEditingController();
  TextEditingController _topic = TextEditingController();
  TextEditingController _userID = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  void initState() {
    super.initState();
    initialiseSP();
  }

  void initialiseSP() async {
    sharedPreferences = await SharedPreferences.getInstance();
    dataList = sharedPreferences.getStringList('dataList')!;
  }

  void StoreData() {
    Data data = Data(
        host: _host.text,
        port: int.parse(_port.text),
        password: _password.text,
        topic: _topic.text,
        userID: _userID.text);
    String finaldata = jsonEncode(data);

    dataList.insert(dataList.length, finaldata);
    sharedPreferences.setStringList('dataList', dataList);
  }

  Future<void> _submit() async {
    if (!_formkey.currentState!.validate()) {
      return;
    }
    _formkey.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                TextFormField(
                  controller: _host,
                  onSaved: (value) {},
                  decoration: InputDecoration(
                    hintText: 'Host',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.black12),
                        borderRadius: BorderRadius.circular(5)),
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.url,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _port,
                  keyboardType: TextInputType.number,
                  onSaved: (value) {},
                  decoration: InputDecoration(
                    hintText: 'Port',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.black12),
                        borderRadius: BorderRadius.circular(5)),
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _topic,
                  onSaved: (value) {},
                  decoration: InputDecoration(
                    hintText: 'Topic',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.black12),
                        borderRadius: BorderRadius.circular(5)),
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _userID,
                  onSaved: (value) {},
                  decoration: InputDecoration(
                    hintText: 'User ID',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.black12),
                        borderRadius: BorderRadius.circular(5)),
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _password,
                  onSaved: (value) {},
                  decoration: InputDecoration(
                    hintText: 'Password',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.black12),
                        borderRadius: BorderRadius.circular(5)),
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 50,
                  width: double.maxFinite,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        elevation: 0,
                      ),
                      onPressed: () {
                        _submit();
                        StoreData();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      },
                      child: Text(
                        "Save",
                        style: GoogleFonts.montserrat(color: Colors.black),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
