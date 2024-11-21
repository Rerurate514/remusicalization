extension ListShower on List {
  void printLog(){
    if(this.isEmpty) print("List is empty");
    this.forEach((var ele){
      print("showList = $ele");
    });
  }
}
