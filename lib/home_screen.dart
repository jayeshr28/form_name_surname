import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SharedPreferences sharedPreferences;
  late List<String> dataList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialiseSharedPref();
  }

  Future initialiseSharedPref() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      dataList = sharedPreferences.getStringList('dataList')!;
    });
  }

  Future clearField(int index) async {
    sharedPreferences = await SharedPreferences.getInstance();
    dataList.removeAt(index);
    setState(() {
      sharedPreferences.setStringList('dataList', dataList);
      // sharedPreferences.getStringList('dataList');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: dataList.isNotEmpty
              ? ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (ctx, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(
                          dataList[index],
                          style: TextStyle(fontSize: 20),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            clearField(index);
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Text("No Items in List"),
                )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NameForm()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
