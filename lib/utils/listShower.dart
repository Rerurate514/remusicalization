extension ListShower<T> on List<T> {
  void printLog(){
    if(this.isEmpty) print("List is empty");
    this.forEach((T ele){
      print("showList = $ele");
    });
  }
}
