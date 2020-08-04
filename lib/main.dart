import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
//import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

typedef void OnError(Exception exception);

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home:  LocalAudio(),
    ));
    FlutterStatusbarcolor.setStatusBarColor(Colors.lightGreen);
}

class LocalAudio extends StatefulWidget {
  @override
  _LocalAudio createState() =>  _LocalAudio();
}

class _LocalAudio extends State<LocalAudio> {
  Duration _duration = new Duration();
  Duration _position = new Duration();
  AudioPlayer advancedPlayer;
  AudioCache audioCache;

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  void initPlayer() {
    advancedPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);

    advancedPlayer.durationHandler = (d) => setState(() {
          _duration = d;
        });

    advancedPlayer.positionHandler = (p) => setState(() {
          _position = p;
        });
  }

  String localFilePath;

  Widget _tab(List<Widget> children) {
    return Column(
      
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: children
                .map((w) => Container(child: w, padding: EdgeInsets.all(10.0)))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _btn(String txt, VoidCallback onPressed) {
    return ButtonTheme(
      minWidth: 50.0,
      child: Container( 
        width: 150,
        height: 45,
        child: RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Text(txt),
            //color: Colors.redAccent,
            textColor: Colors.yellow,
            onPressed: onPressed),
      ),
    );
  }

  Widget slider() {
    return Slider(
        activeColor: Colors.greenAccent,
        inactiveColor: Colors.black,
        value: _position.inSeconds.toDouble(),
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            seekToSecond(value.toInt());
            value = value;
          });
        });
  }
  

  Widget LocalAudio() {
    return _tab([
      _btn('Play', () => audioCache.play('krishnaflu-pa2luqdy-37180.mp3')),
      _btn('Pause', () => advancedPlayer.pause()),
      _btn('Stop', () => advancedPlayer.stop()),
      slider()
    ]);
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);

    advancedPlayer.seek(newDuration);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      
      length: 1,
      child: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
        image: DecorationImage(
	      image: NetworkImage("https://p7.hiclipart.com/preview/871/676/57/google-play-music-app-store-media-player-music.jpg"),
        fit: BoxFit.cover)
  ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: Icon(Icons.queue_music),
            elevation: 10,
            backgroundColor: Colors.blueGrey,
            title: Center(child: Text('Audio Player')),
          ),
          body: TabBarView(
            children: [LocalAudio()],
          ),
        ),
      ),
    );
  }
}