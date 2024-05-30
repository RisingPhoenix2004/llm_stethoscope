import 'package:flutter/material.dart';
import 'package:llm_stethoscope/home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

class MyDLModel extends StatefulWidget {
  const MyDLModel({super.key});

  @override
  State<MyDLModel> createState() => _MyDLModelState();
}

class _MyDLModelState extends State<MyDLModel> {
  String selectedAudio = "-Select-";
  // List<String> audioOptions = ['audio1', 'audio2', 'audio3']; // Example options
  List<String> audioOptions = [
    "-Select-",
    'Audio 1',
    'Audio 2',
  ];
  int SelectedGT = -1;
  final AudioPlayer player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DL Model',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            SizedBox(height: 30,),
            ListTile(
              title: Center(child: const Text('Home')),
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHome()));},
            ),
            SizedBox(height: 30,),
            ListTile(
              title: Center(child: const Text('DL Model')),
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>MyDLModel()));},
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select an Audio:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness != Brightness.dark ? Colors.white : Colors.black, // Use a color that suits your theme
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedAudio,
                  isExpanded: true,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedAudio = newValue!;
                      SelectedGT = getSelectedGT(selectedAudio);
                    });
                  },
                  items: audioOptions.map<DropdownMenuItem<String>>(
                        (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Play Selected Audio:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            if (selectedAudio != "-Select-")
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      // Specify the asset path

                      String audioPath = './assets/$selectedAudio.wav';
                      await player.setVolume(1.5);
                      player.play(AssetSource(audioPath));
                    },
                    child: Text('Play'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      player.pause();
                    },
                    child: Text('Pause'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      player.resume();
                    },
                    child: Text('Resume'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      player.stop();
                    },
                    child: Text('Stop'),
                  ),
                ],
              ),
            ElevatedButton(
              onPressed: () {
                // Call a function to send the selected audio to the Flask server
                sendAudioToServer(context, selectedAudio, SelectedGT);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.cyan, // Button text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              ),
              child: Text('Send Audio to Server'),
            ),
          ],
        ),
      ),
    );
  }

  int getSelectedGT(String audioName) {
    int index = audioOptions.indexOf(audioName);
    return (index >= 0 && index < audioOptions.length) ? index : -1;
  }

  Future<void> sendAudioToServer(BuildContext context, String selectedAudio, int SelectedGT) async {
    try {
      ByteData byteData = await rootBundle.load('assets/$selectedAudio.wav');
      List<int> audioBytes = byteData.buffer.asUint8List();

      String apiUrl = 'http://192.168.205.62:1000/upload';

      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      request.files.add(http.MultipartFile.fromBytes(
        'audio',
        audioBytes,
        filename: '$selectedAudio.wav',
      ));


      var response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        print('Audio successfully sent to the server');
        print('Server response: ${response.body}');
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        print(jsonResponse['predicted_class']);

        showDialog(
          context: context,
          builder: (BuildContext context) {
            String pred = jsonResponse['predicted_class'];
            return AlertDialog(
              title: const Text('Server Response'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    SizedBox(height: 8),
                    Text("Prediction: $pred"),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        print('Failed to send audio. Server returned: ${response.statusCode}');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to send audio. Server returned: ${response.statusCode}'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Error sending audio to server: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Error sending audio to server: $e'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<List<int>> getAudioBytes(String audioName) async {
    String audioPath = 'assets/$audioName.wav';
    ByteData byteData = await rootBundle.load(audioPath);
    List<int> audioBytes = byteData.buffer.asUint8List();
    return audioBytes;
  }
}
