import 'package:flutter/material.dart';
import 'package:pronolol/api/firebase.dart';
import 'package:pronolol/match_item.dart';
import 'package:pronolol/models/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (User.name == null) {
        User.showSelectUserModal(context);
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('pronolol'),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: FilledButton(
                    onPressed: () async {
                      await User.showSelectUserModal(context);
                      setState(() {});
                    },
                    child: Text(User.name ?? "")),
              )
            ],
            bottom: const TabBar(tabs: [
              Tab(
                text: "À venir",
              ),
              Tab(
                text: "Passés",
              )
            ]),
          ),
          body: TabBarView(children: [
            FutureBuilder(
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                    itemCount: FirebaseApi.futureMatches.length,
                    itemBuilder: (ctx, i) =>
                        MatchItem(FirebaseApi.futureMatches[i], false),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
              future: FirebaseApi.getFutureMatches(),
            ),
            FutureBuilder(
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                    itemCount: FirebaseApi.pastOrPredictedMatches.length,
                    itemBuilder: (ctx, i) =>
                        MatchItem(FirebaseApi.pastOrPredictedMatches[i], true),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
              future: FirebaseApi.getPastMatches(),
            ),
          ])),
    );
  }
}
