import 'package:flutter/material.dart';
import 'package:musicalization/Widgets/standardSpace.dart';

class RegisterListNameDialog extends StatefulWidget{
  final Function(bool) isDialogContinued;
  final Function(String) setListName;

  const RegisterListNameDialog({super.key, required this.isDialogContinued, required this.setListName});

  @override
  RegisterListNameDialogState createState() => RegisterListNameDialogState();
}

class RegisterListNameDialogState extends State<RegisterListNameDialog>{
  String _tempListName = "";

  void _okBtnTapped(){

  }

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: size.height * 0.3, horizontal: size.width * 0.1),
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTitle(),
              StandardSpace(),
              buildTextField(),
              StandardSpace(),
              buildBtns(size)
            ],
          ),
        )
      )
    );
  }

  Widget buildTitle(){
    return const Text("Musicリストの名前を決定する");
  }

  Widget buildTextField(){
    return TextField(
      autofocus: true,
      decoration: const InputDecoration(
        hintText: "リスト名",
      ),
      onChanged: (text) {
        _tempListName = text;
      },
    );
  }

  Widget buildBtns(Size size){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton( 
          onPressed: () {
            widget.isDialogContinued(false);
            Navigator.pop(context);
          }, 
          child: const Text("戻る"),
        ), 
        TextButton( 
          onPressed: ()  {
            _okBtnTapped();
            widget.isDialogContinued(true);
            widget.setListName(_tempListName);
            Navigator.pop(context);
          },
          child: const Text("完了"),
        ), 
      ],
    );
  }
}
