import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  double latitude = 44.34;
  double longitude = 10.99;
 double temp_min =277.4;
 double temp_max = 278.75;
  String _temperature = 'Loading...'; 
  bool _isLoading = true;
  int humidity=67;
  List<Map<String,dynamic>> city=[];
  String searchQuery = "";
  
  
  @override
  void initState() {
    super.initState();
    fetchWeatherData(latitude, longitude);
   
  }

  // Function to fetch weather data
  Future<void> fetchWeatherData(double lat, double lon) async {
    final apiKey = 'cce53be76edd9f1b9ec4142127e2da14'; 
    final url ="https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=cce53be76edd9f1b9ec4142127e2da14"; 
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _temperature = data['main']['temp'].toString();
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      setState(() {
        _temperature = 'Error fetching data';
        _isLoading = false;
      });
      // print('Error: $e');
    }
  }
  Future<void>fetchCity(String query) async{
    final apiKey = 'cce53be76edd9f1b9ec4142127e2da14';
    final url ="https://api.openweathermap.org/data/2.5/weather?q=kochi&appid=cce53be76edd9f1b9ec4142127e2da14";
    try {
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        final data = json.decode(response.body) as List;
        setState(() {
          city = data.map((city)=>{"name":city["name"],"lat":city["lat"],"lon":city["lon"]}).toList();
        });
      }else{
        setState(() {
          city=[];
        });
      }
    }
    catch(e){
      setState(() {
        city=[];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 2, 31, 81),
      
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SearchBar(hintText: "search",onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
                if(value.isNotEmpty){
                  fetchCity(value);
                }else{
                  setState(() {
                    city=[];
                  });
                }
              },
              ),
              )),
              if(city.isNotEmpty)
              Expanded(child: ListView.builder(
                itemCount:city.length,
                itemBuilder: (context,index){
                  final City = city[index];
                  return ListTile(title: Text(City["name"],style: TextStyle(color: Colors.white),),
                  onTap: () {
                    setState(() {
                      latitude = City["lat"];
                      longitude=City["lon"];
                      _isLoading=true;
                      city=[];
                    });
                    fetchWeatherData(latitude, longitude);
                  },
                  );
                })),
          
          Padding(
            padding: const EdgeInsets.only(bottom: 23),
            child: Container(
              child:Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Image(image:  NetworkImage("https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/64/67/cc/6467cc2a-c0ed-cdaf-77d3-9e0846b96cc6/AppIcon-0-0-1x_U007emarketing-0-11-0-0-85-220.png/256x256bb.jpg"),),
              )
            ),
          ),
           SizedBox(height: 15),
          _isLoading
              ? CircularProgressIndicator()
              : Text(
                  ' $_temperature°',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.white ),
                ),
          Text("temp_min:$temp_min",style: TextStyle(fontSize: 20,color: Colors.white),),
          Text("temp_max:$temp_max", style: TextStyle(fontSize: 20,color: Colors.white),),
          Text("Humidity:$humidity",style: TextStyle(fontSize: 20,color: Colors.white),),
          SizedBox(height: 18),
          TextField(
            onChanged: (value) {
              setState(() {
                
                latitude = double.tryParse(value) ?? latitude;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Latitude',hintStyle: TextStyle(color: Colors.white)
            ),
          ),
          SizedBox(height: 10),
          TextField(
            onChanged: (value) {
              setState(() {
                
                longitude = double.tryParse(value) ?? longitude;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Longitude',hintStyle: TextStyle(color: Colors.white)
            ),
           
          ),
         
          
        ],
      ),
    );
  }
}