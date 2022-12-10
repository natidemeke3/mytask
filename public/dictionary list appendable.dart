main() {
  var number = {};
  List numbers = ["1", "2"];
  List dic = ["hello", "hi"];

  for (String dictionary in dic) {
    for (String intiger in numbers) {
      int indexofdictionary = dic.indexOf(dictionary);
      int indexofintiger = numbers.indexOf(intiger);
      if (indexofdictionary == indexofintiger) {
        number[dictionary] = intiger;
      }
    }
  }

  print(number);
}
