import 'package:flutter/material.dart';
import 'home_page.dart';
import 'rules_page.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  static AudioPlayer advancedPlayer = new AudioPlayer();
  AudioCache audioCache = new AudioCache(fixedPlayer:advancedPlayer);

  String two='2.mp3';
  String one='';
  void initState(){
    super.initState();
    audioCache. play(two);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scratch and Win"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              height: 256,
              width: 256,
              child: Stack(
              children: [
                Center(child: CircularProgressIndicator(),),
                Center(child:FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: ''))
              ],
            ),
            ),
            SizedBox(
              height: 94,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  color: Colors.red[400],
                  padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  onPressed: () {setState(() {
                    advancedPlayer.pause();
                  });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => HomePage()));
                  },
                  child: Text("Play game"),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  color: Colors.red[400],
                  padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  onPressed: () {advancedPlayer.stop(); audioCache.play('dice.wav');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => RulesPage()));
                  },
                  child: Text("Rules"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
