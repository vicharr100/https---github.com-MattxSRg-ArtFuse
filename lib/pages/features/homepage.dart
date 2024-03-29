import 'dart:convert';

import 'package:artfuse/Apikey/secretkey.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {


  List images =[];
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchApi();
  }
  Future<void> fetchApi() async {
    await http.get(Uri.parse("https://api.pexels.com/v1/curated?per_page=80"),
        headers: {'authorization': apikey}).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images =result['photos'];
      });
      print(images);
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              FontAwesomeIcons.chevronLeft,
              size: 18,
            )),
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Art ',
                style: TextStyle(
                    color: Colors.amber,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: "GrenzeGotisch"),
              ),
              TextSpan(
                text: 'Fuse',
                style: TextStyle(
                    color: Colors.white, fontSize: 25, fontFamily: "Acme"),
              ),
            ],
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                FontAwesomeIcons.clapperboard,
                size: 18,
              ))
        ],
      ),
      body: Column(
        children: [
          //{GRID VIEW OF IMAGES}
          Expanded(
              child: Container(
            child: GridView.builder(
                itemCount: 80,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 3,
                  crossAxisCount: 3,
                  childAspectRatio: 2 / 3,
                  mainAxisSpacing: 3,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Theme.of(context).shadowColor),
                        child: Image.network(images[index]['src']['tiny'], fit: BoxFit.cover,),
                  );
                }),
          )),

          //{BUTTON TO LOAD MORE IMAGES}
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.black,
                ),
                onPressed: () {},
                child: const Text(
                  "Load More",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Acme"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
