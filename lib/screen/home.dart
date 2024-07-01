import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'detail.dart'; // Assuming DetailScreen is now in detail.dart
import 'login.dart'; // Assuming your login screen is in login.dart
import 'user_profile.dart'; // Assuming your user profile screen is in user_profile.dart

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List characters = [];
  List filteredCharacters = []; // List for filtered characters
  TextEditingController searchController = TextEditingController(); // Controller for search input

  @override
  void initState() {
    super.initState();
    fetchCharacters();
  }

  fetchCharacters() async {
    final response =
    await http.get(Uri.parse('https://hp-api.herokuapp.com/api/characters'));
    if (response.statusCode == 200) {
      setState(() {
        characters = json.decode(response.body).take(10).toList();
        filteredCharacters = characters; // Initialize filtered list with all characters
      });
    } else {
      throw Exception('Failed to load characters');
    }
  }

  void filterSearchResults(String query) {
    List searchResult = characters.where((character) {
      String name = character['name'].toLowerCase();
      return name.contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredCharacters = searchResult;
    });
  }

  void logout() {
    // Implement logout logic here, e.g., clearing session/token
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  void navigateToUserProfile() {
    // Navigate to user profile page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserProfilePage(userId: 1,)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Harry Potter Characters'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
          ),
        ],
      ),
      backgroundColor: Color(0xFFefeee9),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  filterSearchResults(value);
                },
                style: TextStyle(color: Color(0xFFc39a1c)), // Set text color
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ImageIcon(
                      AssetImage('assets/search.png'),
                      size: 20,
                      color: Color(0xFFc39a1c),
                    ),
                  ),
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Color(0xFFc39a1c)), // Set hint text color
                  border: InputBorder.none,
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0), // Padding for input text
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCharacters.length,
              itemBuilder: (context, index) {
                bool isOddIndex = index.isOdd; // Check if index is odd or even
                Color cardColor = isOddIndex
                    ? Color(0xFFc39a1c)
                    : Color(0xFF641e1e); // Dark and light colors based on odd/even index
                Color textColor = isOddIndex
                    ? Color(0xFF641e1e)
                    : Color(0xFFefeee9); // Text color based on card color
                Color borderColor = isOddIndex
                    ? Color(0xFFc39a1c)
                    : Color(0xFF641e1e); // Border color based on index

                return Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Card(
                    elevation: 4,
                    color: cardColor, // Set card color based on index
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: borderColor, // Set border color based on index
                        width: 2.0, // border width
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(
                                character: filteredCharacters[index]),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: <Widget>[
                            Hero(
                              tag:
                              'character_image_${filteredCharacters[index]['name']}',
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: borderColor, // Set border color based on index
                                    width: 2.0, // border width
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        filteredCharacters[index]['image']),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    filteredCharacters[index]['name'],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'HarryP',
                                      color: textColor,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    filteredCharacters[index]['house'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: textColor,
                                      fontFamily: 'HarryP',
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    filteredCharacters[index]['species'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: textColor,
                                      fontFamily: 'HarryP',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Logout and User Profile Buttons
          Padding(
            padding: const EdgeInsets.all(19.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                  onPressed: navigateToUserProfile,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color(0xFFefeee9),
                    backgroundColor: Color(0xFF641e1e), // Text color
                  ),
                  child: Text('User Profile',
                      style: TextStyle(fontFamily: 'HarryP', fontSize: 18)),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: logout,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color(0xFFefeee9),
                    backgroundColor: Color(0xFF641e1e), // Text color
                  ),
                  child: Text('Logout',
                      style: TextStyle(fontFamily: 'HarryP', fontSize: 18)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
