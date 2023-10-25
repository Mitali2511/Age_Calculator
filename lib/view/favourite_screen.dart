import 'package:agecalculator/provider/calculator_provider.dart';
import 'package:flutter/material.dart';

class FavScreen extends StatefulWidget {
  FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  List<Map<String, dynamic>> userinfo = [];
  

  refreshData() {
    final data = CalculatorProvider.userlist.keys.map((key) {
      final items = CalculatorProvider.userlist.get(key);
      return {"key": key, "name": items["name"], "birthdate": items["birth"]};
    }).toList();
    setState(() {
      userinfo = data.reversed.toList();
    });
  }

  @override
  void initState() {
    refreshData();
    print(userinfo);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Saved"),
      ),
      body: CalculatorProvider.userlist.isEmpty
          ? Center(
              child: Container(
                  width: 400,
                  height: 300,
                  child: Image.asset("assets/images/nodata.jpg")),
            )
          : ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: CalculatorProvider.userlist.length,
              reverse: false,
              itemBuilder: (context, index) {
                return Dismissible(
                  background:
                      Container(color: Colors.red, child: Icon(Icons.delete)),
                  direction: DismissDirection.endToStart,
                  key: UniqueKey(),
                  onDismissed: (direction) async {
                    await CalculatorProvider.userlist.deleteAt(index);
                    userinfo.removeAt(index);

                    setState(() {});
                  },
                  child: Card(
                    color: Color.fromARGB(255, 205, 215, 224),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${userinfo[index]["name"]}\n${userinfo[index]["birthdate"]}",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}
