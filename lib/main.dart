import 'package:flutter/material.dart';
import 'package:pop_value_back/countries_list_api.dart';
import 'package:pop_value_back/countries_list_screen.dart';

void main() => runApp(
  const MaterialApp(
    home: MyApp(),
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dialog Box and return value',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  String? selectedLanguage;

  List<String> languages = ["java", "C", "C++", "Python"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter SimpleDialog Example")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.white,
              height: 50,
              width: 150,
              child: InkWell(
                  onTap: () async {
                     selectedLanguage = await Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => CountiresFromApiScreen()));
                    setState(() {

                    });
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${selectedLanguage ?? 'Select'}   "),
                        const Icon(
                          Icons.arrow_drop_down,
                        ),
                      ],
                    ),
                  )
                //  DropdownButtonFormField(
                //   items: [],
                //   hint: Text("Select"),
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showMyAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: StatefulBuilder(
            //* dialog is on different widget Tree. check dev-tools
            builder: (context, setStateD) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Language"),
                  const SizedBox(width: 12),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...List.generate(
                        languages.length,
                            (index) => item(
                          text: languages[index], //sent String
                          isSelected: languages[index] ==
                              selectedLanguage, //check it is selected or not
                          ontap: () {
                            /// for inner dialog changes
                            setStateD(() {
                              selectedLanguage = languages[index];
                            });
                            Navigator.of(context)
                                .pop(); // if you wish to close the dilog on Select

                            setState(() {
                              //* for class state changes
                              selectedLanguage = languages[index];
                            });
                            print(selectedLanguage);
                          },
                        ),
                      )
                    ],
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget item(
      {required String text,
        required bool isSelected,
        required Function ontap}) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 4,
      ),
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
