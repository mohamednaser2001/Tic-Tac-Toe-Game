import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends  StatefulWidget{

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
/*
  static var myNewFont= GoogleFonts.pressStart2P(
    textStyle: TextStyle(color: Colors.white,letterSpacing: 3,fontSize: 15),
  );
  */
  static var myFont = GoogleFonts.pressStart2p(
    textStyle: TextStyle(
      fontSize: 15.0,
      color: Colors.white,
      letterSpacing: 3,
      fontWeight: FontWeight.bold,
    ),
  );

  bool isTurn=true;
  int oScore=0;
  int xScore=0;
  int count=0;
  List<String> changeXO = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Player X',
                          style: GoogleFonts.pressStart2p(
                           textStyle: myFont,
                          ),
                        ),
                        SizedBox(height: 20.0,),
                        Text(
                          xScore.toString(),
                          style: myFont
                        ),
                      ],
                    ),
                    SizedBox(width: 35,),
                    Column(
                      children: [
                        Text(
                          'Player O',
                          style: myFont,
                        ),
                        SizedBox(height: 20,),
                        Text(
                          oScore.toString(),
                          style: myFont,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: GridView.builder(
                  itemBuilder: (BuildContext context,int index){
                    return GestureDetector(
                      onTap: (){
                        setXOrO(index); 
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color:Colors.grey),
                        ),
                        child: Center(
                            child: Text(
                          changeXO[index],
                          style: myFont,
                        )),
                      ),
                    );
                  },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemCount: 9,
                ),
              ),
            ),

            Center(
              child: Padding(
                padding: const EdgeInsets.all(35.0),
                child: Text(
                    'TIC TAC TOE',
                  style: myFont,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setXOrO (int i){

    if(isTurn&&changeXO[i]==''){
      setState(() {
        changeXO[i]='o';
        isTurn =!isTurn;
      });
    }
    else if(!isTurn && changeXO[i]==''){
      setState(() {
        changeXO[i]='x';
        isTurn =!isTurn;
      });
    }
    count++;
    checkWinner();
  }

  void checkWinner(){
    if(changeXO[0]==changeXO[1] && changeXO[0]==changeXO[2] && changeXO[0]!='' ){
      _showDialog(changeXO[0]);
    }
    if(changeXO[3]==changeXO[4] && changeXO[3]==changeXO[5] && changeXO[3]!='' ){
      _showDialog(changeXO[3]);
    }
    if(changeXO[6]==changeXO[7] && changeXO[6]==changeXO[8] && changeXO[6]!='' ){
      _showDialog(changeXO[6]);
    }

    if(changeXO[0]==changeXO[3] && changeXO[0]==changeXO[6] && changeXO[0]!='' ){
      _showDialog(changeXO[0]);
    }
    if(changeXO[1]==changeXO[4] && changeXO[1]==changeXO[7] && changeXO[1]!='' ){
      _showDialog(changeXO[1]);
    }
    if(changeXO[2]==changeXO[5] && changeXO[2]==changeXO[8] && changeXO[2]!='' ){
      _showDialog(changeXO[2]);
    }

    if(changeXO[0]==changeXO[4] && changeXO[0]==changeXO[8] && changeXO[0]!='' ){
      _showDialog(changeXO[0]);
    }
    if(changeXO[2]==changeXO[4] && changeXO[2]==changeXO[6] && changeXO[2]!='' ){
      _showDialog(changeXO[2]);
    }

    if(count==9){
      _showNoWinner();
      clearBoard();
    }

  }

  void _showNoWinner(){      // will called at the end of condition of check winner method
    showDialog(
        barrierDismissible: false,
        context:context,
        builder: (context){
          return AlertDialog(
            title: Text('No Winner'),
            actions: [
              TextButton(
                  onPressed: (){
                    count=0;
                    clearBoard();
                    Navigator.of(context).pop();
                  },
                  child: Text('Play again'),
              ),
            ],
          );
        }
    );

  }

  void _showDialog(String winner){      // will called at the end of condition of check winner method

    showDialog(
       barrierDismissible: false,
         context:context,
      builder: (context){
           return AlertDialog(
             title: Text('$winner is a winner'),
             actions: [
               TextButton(
                 onPressed: (){
                   Navigator.of(context).pop();
                 },
                 child: Text('Play again'),
               ),
             ],
           );
      }
     );
    count=0;
    clearBoard();
    if(winner =='o'){
      setState(() {
        oScore++;
      });
     }else if(winner=='x'){
      setState(() {
        xScore++;
      });
     }
  }

  void clearBoard(){
    for(int i=0;i<9;i++){
      changeXO[i]='';
    }
  }


}