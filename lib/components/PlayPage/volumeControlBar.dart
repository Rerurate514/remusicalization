import 'package:flutter/material.dart';
import 'package:musicalization/Widgets/InkCard.dart';
import 'package:musicalization/Widgets/standardSpace.dart';
import 'package:musicalization/logic/musicPlayer.dart';

class VolumeControlBar extends StatefulWidget {
  final Function() closeFragment;

  const VolumeControlBar({super.key, required this.closeFragment});

  @override
  _VolumeControlBarState createState() => _VolumeControlBarState();
}

class _VolumeControlBarState extends State<VolumeControlBar> {
  final MusicPlayer _player = MusicPlayer.getEmptyInstance();

  int _value = 0;

  _VolumeControlBarState(){
    try{
      _value = _player.nowVolume;
    }
    catch(e){
      _value = 40;
    }
  }

  @override
  void initState(){
    super.initState();
  }

  void _changeSliderValue(double value){
    setState(() {
      _value = value.toInt();
    });
    
    _player.changeVolume(_value.toInt());
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.75,
      margin: const EdgeInsets.all(20),
      child: Align(
        alignment: Alignment.bottomRight,
        child: buildContent(size),
      )
    );
  }

  Widget buildContent(Size size){
    return Card(
      child: SizedBox(
        width: size.width * 0.3,
        height: size.height * 0.4,
        child: Column(
          children: [
            const StandardSpace(),
            buildSlider(),
            buildIcon(),
            buildCloseBtn(),
          ],
        ),
      ),
    );
  }

  Widget buildSlider(){
    return RotatedBox(
      quarterTurns: 3,
      child: Slider(
        value: _value.toDouble(),
        onChanged: (value) => _changeSliderValue(value),
        max: 100,
        min: 0,
      ),
    );
  }

  Widget buildIcon(){
    return const Padding(
      padding: EdgeInsets.all(8),
      child: Icon(Icons.volume_up),
    );
  }

  Widget buildCloseBtn(){
    return InkCard(
      onTap: widget.closeFragment, 
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          "Close",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      )
    );
  }
}
