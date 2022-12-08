import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

// import 'package:todo/lists.dart';

//this is a task managment app with features like local storage where a user can store his/her task and also they can remove it by just only long pressing the card.

void main(List<String> args) async {
  //this is hive storage where the local database is run
  await Hive.initFlutter();
  var local_storgae = await Hive.openBox("my_local_database");

  runApp(todo());
}

class todo extends StatefulWidget {
  todo({super.key});

  @override
  State<todo> createState() => _todoState();
}

List to = [];

class _todoState extends State<todo> {
  @override
  List<String> actions = [];

  bool added = false;
  static bool isdata = false;
  //adable input is a static variable where the text of textfield(search bar) is stored in.
  static TextEditingController addable_input = TextEditingController();
  //both of these lists down here are used to store the texts from the adable_input.

  //todo_elements is a list of widgets that is used to store mycard widgets
  var todo_elements = <Widget>[
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: TextField(
          controller: addable_input,
        ),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(12)),
      ),
    ),
  ];
  //removeitem(function) we put removabel argument then this function will remove the argument from the priviously printed list.

  Widget build(BuildContext context) {
    final boxing = Hive.box("my_local_database");

    bool once = false;
    if (boxing.get(1) == null && once == false) {
      boxing.put(1, []);
      once = true;
    } else {}
    List<dynamic> local_previous = boxing.get(1);

    //mycard(function) that returns singlechildscrollview , is the main part of the code where the code of each card is created. we enter text argument which will display a card with the text on it.

    print("line 64: action = $actions");

    dynamic mycard(String text) {
      bool youcanscroll = false;
      if (text.length >= 59) {
        youcanscroll = true;
      }

      if (youcanscroll) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(right: 2000),
          child: GestureDetector(
            //on long press of this widget it will do the following actions by setstate
            onLongPress: () {
              setState(() {
                if (local_previous.contains(text)) {
                  //now if the list privioulyprinted contains the text on mycard(text) we are calling the function removeitem with the text argument in it,
                  var hi = local_previous.indexOf(text);
                  todo_elements.removeAt(hi + 2);
                  local_previous.remove(text);
                  boxing.put(1, local_previous);
                  actions.remove(text);
                }
              });
            },

            child: Column(
              children: [
                SizedBox(height: 12),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 20),
                          Center(
                              child: Text(
                            text,
                            style: TextStyle(fontSize: 40),
                          )),
                          SizedBox(width: 20)
                        ],
                      ),
                    )),
              ],
            ),
          ),
        );
      } else {
        return GestureDetector(
          //on long press of this widget it will do the following actions by setstate
          onLongPress: () {
            setState(() {
              if (local_previous.contains(text)) {
                //now if the list privioulyprinted contains the text on mycard(text) we are calling the function removeitem with the text argument in it,
                var hi = local_previous.indexOf(text);
                todo_elements.removeAt(hi + 2);
                local_previous.remove(text);
                boxing.put(1, local_previous);
                actions.remove(text);
              }
            });
          },
          child: Column(
            children: [
              SizedBox(height: 12),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 20),
                        Center(
                            child: Text(
                          text,
                          style: TextStyle(fontSize: 40),
                        )),
                        SizedBox(width: 20)
                      ],
                    ),
                  )),
            ],
          ),
        );
      }
    }

    print("line 65: local_previous =$local_previous");
//we are using for loop to append the todo_element with mycard(element) where element is a string in list.
    //now we are trying to append the todo_element list with a add button so that we can append the appendable text from the user to the actions list

    print("line 172: actions = $actions");
    print("line 164: to = $to");
    if (!added) {
      todo_elements.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Container(
                  width: 120,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        to.add(addable_input.text);
                        actions.add(addable_input.text);
                        actions = actions;
                        local_previous.add(addable_input.text);
                        boxing.put(1, local_previous);
                        addable_input.clear();
                        print(local_previous);
                      });
                    },
                    child: Center(
                      child: Text(
                        "add",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )),
            ),
          ],
        ),
      );
      added = true;
    }

    if (isdata == false) {
      for (String element in local_previous) {
        todo_elements.add(mycard(element));
      }
      isdata = true;
    }
    if (isdata) {
      for (String el in actions) {
        todo_elements.add(mycard(el));
        actions.remove(el);
        actions = actions;
      }
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("My tasks")),
          backgroundColor: Colors.black,
        ),
        body: ListView(
          children: [
            Column(
              children: todo_elements,
            )
          ],
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Container(
                  width: 120,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        List working = boxing.get(1);

                        addable_input.clear();
                      });
                    },
                    child: Center(
                      child: Text(
                        "add",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
