class Index{
  final List list;

  int _value = 0;
  int get value => _value;

  Index({required this.list});

  int get len => list.length;

  void increase(){
    _value++;
    if(len < _value) _value -= len;
  }

  void dicrease(){
    _value--;
    if(0 > _value) _value = len - _value;
  }
}
