import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final Map<String, dynamic> character;

  const DetailScreen({required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character['name'], style: TextStyle(fontFamily: 'HarryP')),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'character_image_${character['name']}',
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Color(0xFF641e1e), // border color
                            width: 4.0, // border width
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(26),
                          child: Image.network(
                            character['image'],
                            height: 300,
                            width: 300,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Card(
                  elevation: 4,
                  color: Color(0xFFc39a1c), // Set card background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: Color(0xFF641e1e), // border color
                      width: 2.0, // border width
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          'Name: ${character['name']}',
                          style: TextStyle(
                            fontFamily: 'HarryP',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFefeee9), // Set text color
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'House: ${character['house']}',
                          style: TextStyle(
                            fontFamily: 'HarryP',
                            fontSize: 18,
                            color: Color(0xFFefeee9), // Set text color
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Actor: ${character['actor']}',
                          style: TextStyle(
                            fontFamily: 'HarryP',
                            fontSize: 18,
                            color: Color(0xFFefeee9), // Set text color
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Ancestry: ${character['ancestry']}',
                          style: TextStyle(
                            fontFamily: 'HarryP',
                            fontSize: 18,
                            color: Color(0xFFefeee9), // Set text color
                          ),
                        ),
                        // Add other details as needed
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
