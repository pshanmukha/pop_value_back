import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pop_value_back/countries_list_response.dart';

class CountiresFromApiScreen extends StatefulWidget {
  const CountiresFromApiScreen({Key? key}) : super(key: key);

  @override
  _CountiresFromApiScreenState createState() => _CountiresFromApiScreenState();
}

class _CountiresFromApiScreenState extends State<CountiresFromApiScreen> {
final ScrollController _scrollController = ScrollController();

  String? selectedCountry;

  GooglePlaceDetailsFromPlaceIdResponse ? countriesData;
  List<Datum> ldata =[];

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(seconds: 5), (){
      getAllCategory().then((countriesData) {
        print(countriesData!.data!.values.toList()[0].country);
        setState(() {
          ldata = countriesData!.data!.values.toList();
          print(ldata);
        });
      });
    });


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counties"),
      ),
      body: ldata.length == 0 ? Center(child: CircularProgressIndicator(),)
          : SafeArea(
          child: Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(5),
            child: Scrollbar(
              isAlwaysShown: true,
              controller: _scrollController,
              child: ListView.builder(
                  controller: _scrollController,
                  itemCount: ldata.length,
                  itemBuilder: (context,index) {
                    return Card(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: item(
                          text: ldata[index].country!, //sent String
                          isSelected: ldata[index].country! ==
                              selectedCountry,
                          ontap: () {

                            setState(() {
                              selectedCountry = ldata[index].country!;
                            });
                            Navigator.of(context).pop(selectedCountry);
                            print(selectedCountry);
                          },
                        ),
                      ),
                    );
                  }
              ),
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
            Container(
                height: 30,
                child: Center(child: Text(text))),
            const SizedBox(
              width: 10,
            ),
            if (isSelected)
              Container(
                height: 30,
                child: const Icon(Icons
                    .check,size: 25,),
              ),
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
    final parsedJson = json.decode(response.body);
    final countriesData = GooglePlaceDetailsFromPlaceIdResponse.fromJson(parsedJson);
    print("data : ${countriesData.data!.values.toList()[0].country}");
    return countriesData;
  }

}

