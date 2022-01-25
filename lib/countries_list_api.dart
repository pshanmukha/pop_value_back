import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CountiresFromApiScreen extends StatefulWidget {
  const CountiresFromApiScreen({Key? key}) : super(key: key);

  @override
  _CountiresFromApiScreenState createState() => _CountiresFromApiScreenState();
}

class _CountiresFromApiScreenState extends State<CountiresFromApiScreen> {

  String? selectedLanguage;
  Future ? countryList;
  List<String> languages = ["java", "C", "C++", "Python"];

  @override
  void initState() {
    // TODO: implement initState
    countryList = getAllCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counties"),
      ),
      body: SafeArea(
          child: Container(
            child: FutureBuilder(
                future: countryList,
                builder: (context, AsyncSnapshot snapshot) {
                  if(snapshot.hasData) {
                    return Center(
                      child: ListView.builder(
                          itemCount: languages.length,
                          itemBuilder: (context,index) {
                            return item(
                              text: languages[index], //sent String
                              isSelected: languages[index] ==
                                  selectedLanguage,
                              ontap: () {

                                setState(() {
                                  selectedLanguage = languages[index];
                                });
                                Navigator.of(context).pop(selectedLanguage);
                                print(selectedLanguage);
                              },
                            );
                          }
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Unable to Process your request, Please try after sometime"),);
                  }
                  return Center(child: CircularProgressIndicator(),);
                }
            ),
          )
      ),
    );
  }

  Widget item(
      {required String text,
        required bool isSelected,
        required Function ontap}) {
    return Container(
      child: InkWell(
        onTap: () => ontap(),
        child: Row(
          children: [
            Text(text),
            const SizedBox(
              width: 10,
            ),
            if (isSelected)
              const Icon(Icons
                  .check), // show only check while it is selected, or you can use the same logic on Main row item
          ],
        ),
      ),
    );
  }

  Future getAllCategory() async {
    var allCountiesUrl = Uri.parse('https://api.first.org/data/v1/countries');
    var response = await http.get(allCountiesUrl);
    log("All Countries response : ${response.statusCode.toString()}");
    log("All Countries body : ${response.body}");
    return json.decode(response.body);
  }

}

