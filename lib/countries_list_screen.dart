import 'package:flutter/material.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  _CountriesListState createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {

  String? selectedLanguage;

  List<String> languages = ["Java", "C", "C++", "Dart", "Python", "JavaScript", "C/CPP", "PHP", "Swift", "C# (C- Sharp)", "Ruby", "Objective-C", "SQL", "Go", "Kotlin", "R", "Matlab", "Groovy", "Assembly language", "Visual Basic", "Perl", "Pascal", "Scala", "Shell"];
  List<String>? newLanguagesData;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    newLanguagesData = [...languages];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Container(
                    padding: const EdgeInsets.only(top: 5),
                    color: Colors.white,
                    child:  Center(
                      child: TextField(
                        controller: _textController,
                        onChanged: onItemChanged,
                        autocorrect: false,
                        enableSuggestions: false,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search,color: Colors.grey,size: 30,),
                          hintText: "Search here...",
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                        style: const TextStyle(decoration: TextDecoration.none),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(5),
                child: Scrollbar(
                  isAlwaysShown: true,
                  controller: _scrollController,
                  child: ListView.builder(
                      controller: _scrollController,
                    itemCount: newLanguagesData!.length,
                      itemBuilder: (context,index) {
                        return Card(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            child: item(
                              text: newLanguagesData![index], //sent String
                              isSelected: newLanguagesData![index] ==
                                  selectedLanguage,
                              ontap: () {

                                setState(() {
                                  selectedLanguage = newLanguagesData![index];
                                });
                                Navigator.of(context).pop(selectedLanguage);
                                print(selectedLanguage);
                              },
                            ),
                          ),
                        );
                      }
                  ),
                ),
        ),
              ),
            ],
          )
      ),
    );
  }

  Widget item({required String text, required bool isSelected, required Function ontap}) {
    return InkWell(
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
    );
  }

  onItemChanged(String value) {
    setState(() {
      newLanguagesData = languages
          .where((string) => string.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }
}
