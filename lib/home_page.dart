import 'package:flutter/material.dart';
import 'dart:math';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  AudioCache audioCache = new AudioCache();
  AudioPlayer advancedPlayer = new AudioPlayer();
  AssetImage blank = AssetImage("images/blank.png");
  AssetImage unlucky = AssetImage("images/sad.png");
  AssetImage lucky = AssetImage("images/money.png");

  List<String> itemArray;
  int luckyNumber;
  int count=0;
  String message="";
  generateRandomNumber(){
    int random=Random().nextInt(25);
    setState(() {
      luckyNumber=random;
      print(luckyNumber);
    });
  }

  @override
  void initState(){
    super.initState();
    itemArray=List<String>.generate(25, (index)=>"empty");
    generateRandomNumber();
  }

  displayMessage(){
    setState(() {
      message="You have reached Maximum tries";
      Delay();
    });
  }

  Delay(){
    Future.delayed(const Duration(milliseconds: 1600),(){
      setState(() {
        this.resetGame();
        count=0;
      });
    });
  }

  AssetImage getImage(int index){
    String currentState=itemArray[index];
    switch(currentState){
      case "lucky":
      return lucky;
      break;
      case "unlucky":
      return unlucky;
      break;
    }
    return blank;
  }

  playgame(int index){
    if(luckyNumber==index){
      setState(() {
        itemArray[index]="lucky";
        audioCache.play('cash.wav');
        this.message="Yay you got it";
        Delay();
      });
    }else if(luckyNumber!=index && count<=5){
      setState(() {
        itemArray[index]="unlucky";
        count++;
      });
      if(count==5){
        audioCache.play('aww.mp3');
        displayMessage();
      }
      if(count==4){
        this.message="last one and you are gone";
      }
      if(count==3){
        this.message="2 more left. think wisely";
      }
      if(count==2){
        this.message="yes you can win";
      }
      if(count==1){
        this.message="there is a long way to go";
      }
    }
  }

  resetGame(){
    setState(() {
      itemArray=List<String>.filled(25,"empty");
      this.message="";
      this.count=0;
    });
    generateRandomNumber();
  }

  showAll(){
    setState(() {
      itemArray=List<String>.filled(25,"unlucky");
      itemArray[luckyNumber]="lucky";
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        title: Text(
          "Scratch and Win",
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10,
                crossAxisCount: 5,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
              ),
              itemCount: 25,
              itemBuilder: (context, i) => SizedBox(
                width: 50,
                height: 50,
                child: RaisedButton(
                  padding: EdgeInsets.all(1),
                  onPressed: () {
                    playgame(i);
                  },
                  child: Image(
                    image: this.getImage(i),
                    height: 40, width: 40,
                  ),
                ),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(100, 12, 100, 12),
                color: Colors.red[400],
                child: Text(
                  this.message,style: TextStyle(fontSize: 10),
                ),
              )
            ],
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  child: RaisedButton(
                    onPressed: () {
                      this.resetGame();
                    },
                    padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                    color: Colors.black,
                    child: Text(
                      "Reset",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: RaisedButton(
                    onPressed: () {
                      this.showAll();
                    },
                    padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                    color: Colors.black,child: Text("Show all",style:TextStyle(color: Colors.white),),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
