class Index{
  final List list;

  int _index = 0;
  int get index => _index;

  Index({required this.list});

  int get len => list.length;

  void increase(){
    _index++;
    if(len < _index) _index -= len;
  }

  void dicrease(){
    _index--;
    if(0 > _index) _index = len - _index;
  }
}
