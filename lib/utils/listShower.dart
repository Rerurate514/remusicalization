extension ListShower<T> on List<T> {
  void printLog(){
    if(isEmpty) print("List is empty");
    forEach((T ele){
      print("showList = $ele");
    });
  }
}
