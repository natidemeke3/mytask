import 'package:flutter/material.dart';

class listing extends StatelessWidget {
  const listing({super.key});

  @override
  Widget build(BuildContext context) {
    return showable_widget();
  }
}

showable_widget() {
  List todolist = ["do homework", "program in my pc"];
  List showable_list = [];
  for (String element in todolist) {
    showable_list.add(Container(child: Text(element)));
  }
  return showable_list;
}
