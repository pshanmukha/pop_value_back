import 'package:flutter/material.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  _CountriesListState createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {

  String? selectedLanguage;

  List<String> languages = ["java", "C", "C++", "Python"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
          child: /*Container(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: [
                ...List.generate(
                  languages.length,
                      (index) => item(
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
                  ),
                )
              ],
            ),
          ),*/
        Container(
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
}
