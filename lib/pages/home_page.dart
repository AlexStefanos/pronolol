import 'package:flutter/material.dart';
import 'package:pronolol/api/lolesport.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pronolol")),
      body: ListView.builder(
          itemCount: LolEsportApi.previousMatches.length,
          itemBuilder: (context, index) => Card(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.network(
                      LolEsportApi.previousMatches[index].teamA.imageUrl),
                  Text(LolEsportApi.previousMatches[index].toString()),
                  Image.network(
                      LolEsportApi.previousMatches[index].teamB.imageUrl),
                ],
              ))),
      floatingActionButton: FloatingActionButton(
          onPressed: () async => await LolEsportApi.getWebsiteData()),
    );
  }
}
