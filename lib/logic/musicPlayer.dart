import 'package:audioplayers/audioplayers.dart';
import 'package:musicalization/enums/musicMode.dart';
import 'package:musicalization/enums/transition.dart';
import 'package:musicalization/models/index.dart';
import 'package:musicalization/models/schema.dart';

class MusicPlayer{
  MusicPlayer._();

  final _player = _AudioPlayerManager();

  double get currentSeconds => _player.currentSeconds;
  double get durationSeconds => _player.durationSeconds;

  MusicMode get musicMode => _player.musicMode;

  String get listName => _player.listName;
  Music get currentMusic => _player.currentMusic;

  factory MusicPlayer.setMusicList(
    List<Music> musicList, 
    [String listName = "",
    Function()? reRenderUICallback]){

    final ins = MusicPlayer._();
    ins._setMusicList(musicList);
    ins._setRerenderUICallback(reRenderUICallback);

    return ins;
  }

  factory MusicPlayer.getEmptyInstance(){
    final ins = MusicPlayer._();
    return ins;
  }

  factory MusicPlayer.getInstanceWithReRender(Function() reRenderUICallback){
    final ins = MusicPlayer._();
    ins._setRerenderUICallback(reRenderUICallback);
    return ins;
  }

  void _setMusicList(List<Music> musicList){
    _player.setMusicList(musicList);
  }

  void _setRerenderUICallback(
    Function()? reRenderUI
  ) {
    _player.setReRenderUICallback(reRenderUI ?? () {});
  }


  void start(int? listIndex){
    _player.start(listIndex);
  }

  void pause() {
    _player.pause();
  }

  void resume(){
    _player.resume();
  }

  void seek(double newCurrenrSeconds){
    _player.seekMusic(newCurrenrSeconds);
  }

  void toggleMusicMode(){
    _player.toggleMusicMode();
  }
}

class _AudioPlayerManager{
  final AudioPlayer _audioPlayer = AudioPlayer();
  final _CurrentListenerResistry _clr = _CurrentListenerResistry();
  final _DurationListenerResistry _dlr = _DurationListenerResistry();
  final _PlayerCompletionListenerResistry _pclr = _PlayerCompletionListenerResistry();


  List<Music> _musicList = [];
  Index _index = Index(list: []);

  bool isPlaying = false;
  MusicMode musicMode = MusicMode.NORMAL;

  bool _isExcutable = true;

  String _listName = "";

  Function()? _reRenderUI;

  double get currentSeconds => _clr.currentSeconds;
  double get durationSeconds => _dlr.durationSeconds;

  String get listName => "";
  Music get currentMusic => _musicList[_index.value];


  static _AudioPlayerManager? _instance;

  _AudioPlayerManager._(){
    _clr.setPlayingMusicCurrentListener(_audioPlayer);
    _dlr.setPlayingMusicDurationListener(_audioPlayer);
    _initCompListener();
  }

  factory _AudioPlayerManager(){
    _instance ??= _AudioPlayerManager._();
    return _instance!;
  }



  void setMusicList(List<Music> musicList, [String listName = ""]){
    _musicList = musicList;
    _index = Index(list: _musicList);
    _listName = listName;
  }

  void setReRenderUICallback(Function() reRenderUI){
    _reRenderUI = reRenderUI;
  }

  void _initCompListener(){
    _pclr.setPlayerCompletionListener(
      _audioPlayer, 
      musicMode, 
      _moveNext, 
      _moveRandom,
      _reRenderUI
    );
  }


  Future<void> start(int? listIndex) async {
    listIndex ??= 0;

    final String musicPath = _musicList[listIndex].path;

    if(!_isExcutable) return;
    _isExcutable = false;

    //短時間連続でplayメソッドを呼び出すとエラーになるため200msのディレイを追加
    Future.delayed(const Duration(milliseconds: 200), () async {
      try {
        isPlaying = true;
        await _audioPlayer.play(DeviceFileSource(musicPath));
      } catch (e, stackTrace) {
        throw Exception("Failed to $e, musicPath = $musicPath, stackTrace = $stackTrace");
      }
      _isExcutable = true;
    });
  }

  Future<void> pause() async {
    isPlaying = false;
    _audioPlayer.pause();
  }

  Future<void> resume() async {
    isPlaying = true;
    _audioPlayer.resume();
  }


  Future<void> seekMusic(double newCurrentSeconds) async {
    _audioPlayer.seek(Duration(seconds: newCurrentSeconds.toInt()));
  }


  Future<void> moveMusicList(Transition transition) async {
    switch(transition){
      case Transition.NEXT: _moveNext();
      case Transition.PREVIOUS: _movePrevious();
      case Transition.RANDOM: _moveRandom();
    }
  }

  Future<void> _moveNext() async {
    _index.increase();
    start(_index.value);
  }

  Future<void> _movePrevious() async {
    _index.dicrease();
    start(_index.value);
  }

  Future<void> _moveRandom() async {
    _index.random();
    start(_index.value);
  }


  Future<void> toggleMusicMode() async {
    final MusicModeSetter setter = MusicModeSetter();

    switch(musicMode){
      case MusicMode.NORMAL: {
        musicMode = setter.changeLoopMode(_audioPlayer);
      }
      case MusicMode.LOOP: {
        musicMode = setter.changeShuffleMode(_audioPlayer);
      }
      case MusicMode.SHUFFLE: {
        musicMode = setter.changeNormalMode(_audioPlayer);
      }
    }

    _initCompListener();
  }


  Future<void> changeVolume(int volume) async {
    if(volume > 100 || volume < 0) return;
    _audioPlayer.setVolume(volume / 100);
  }
}

class MusicModeSetter{
  MusicMode changeNormalMode(AudioPlayer audioPlayer) {
    audioPlayer.setReleaseMode(ReleaseMode.release);
    return MusicMode.NORMAL;
  }

  MusicMode changeLoopMode(AudioPlayer audioPlayer) {
    audioPlayer.setReleaseMode(ReleaseMode.loop);
    return MusicMode.LOOP;
  }

  MusicMode changeShuffleMode(AudioPlayer audioPlayer) {
    audioPlayer.setReleaseMode(ReleaseMode.release);
    return MusicMode.SHUFFLE;
  }
}

class _CurrentListenerResistry {
  double _currentSeconds = 0.0;
  double get currentSeconds => _currentSeconds;

  void setPlayingMusicCurrentListener(AudioPlayer audioPlayer) {
    audioPlayer.onPositionChanged.listen((Duration duration) {
      _currentSeconds = duration.inSeconds.toDouble();
    });
  }
}

class _DurationListenerResistry {
  double _durationSeconds = 0.0;
  double get durationSeconds => _durationSeconds;

  void setPlayingMusicDurationListener(AudioPlayer audioPlayer) {
    audioPlayer.onDurationChanged.listen((Duration duration) {
      _durationSeconds = duration.inSeconds.toDouble();
    });
  }
}

class _PlayerCompletionListenerResistry {
  void setPlayerCompletionListener(
    AudioPlayer audioPlayer,
    MusicMode musicMode,
    Function() moveNext,
    Function() moveRandom,
    Function()? reRenderUI
  ) {
    audioPlayer.onPlayerComplete.listen((event) {
      switch(musicMode){
        case MusicMode.NORMAL: moveNext();
        case MusicMode.LOOP: () {};
        case MusicMode.SHUFFLE: moveRandom();
      }

      if(reRenderUI != null) reRenderUI();
    }); 
  }
}
