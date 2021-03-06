import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/weather_data.dart';
import './weather_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  var cityName;

  void onButtonPress() async {
    bool isValid = _formKey.currentState.validate();

    if (isValid) {
      _formKey.currentState.save();
      try{
      await Provider.of<WeatherData>(context, listen: false).getData(cityName);

      }catch(error){
        showDialog(context: context,builder: (context){
          return AlertDialog( title: Text("City Not Found"),content: Text("The City you searched for is not found, please check the City Name and try again!"),);
        });
        // clears the data of the form
        _formKey.currentState.reset();
       
        return;
      }

      Navigator.of(context).pushNamed(WeatherPage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    var device = MediaQuery.of(context).size;

    return Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        image: new DecorationImage(
            image: AssetImage("Assets/bugsursky.jpg"), fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
  
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(100),
              width: device.width * 0.8,
              height: device.height * 0.20,
              decoration: new BoxDecoration(
                color: Colors.transparent,
                image: new DecorationImage(
                  image: AssetImage("Assets/1cloudy.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  //color: Colors.white,
                  decoration: new BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.4),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      //decorationColor: Colors.white,
                      // backgroundColor: Colors.white,
                    ),
                    onSaved: (value) {
                      cityName = value;
                    },
                    validator: (value) {
                      if (value.length < 2) {
                        return "Please Enter a Valid City";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      // hoverColor: Colors.white,
                      // fillColor: Colors.white,
                       focusColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),

                      // icon: Icon(
                      //   Icons.search,
                      //   color: Colors.white,
                      // ),
                      labelText: "Enter City",

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            FlatButton(
              onPressed: onButtonPress,
              color: Color.fromRGBO(255, 255, 255, 0.4),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0),
              ),
              child: Text(
                "Find Weather Data",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
