import 'package:flutter/material.dart';
import 'package:pronolol/api/postgres.dart';
import 'package:pronolol/items/pickem_item.dart';
import 'package:pronolol/modals/side_drawer_modal.dart';
import 'package:pronolol/models/user_model.dart';
import 'package:pronolol/utils/tournaments.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PickemsPage extends StatefulWidget {
  final Tournaments tournament;

  const PickemsPage(this.tournament, {super.key});

  @override
  State<PickemsPage> createState() => _PickemsPageState();
}

class _PickemsPageState extends State<PickemsPage> {
  void _disconnection() async {
    User.currentUser = null;
    SharedPreferences instance = await SharedPreferences.getInstance();
    instance.clear();
    Restart.restartApp();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          drawer: const SideDrawer(),
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: _disconnection,
                icon: const Icon(Icons.exit_to_app),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(User.currentUser!.emoji),
              ),
            ],
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Questions'),
                Tab(text: 'Playoffs'),
                Tab(text: 'Classement')
              ],
            ),
          ),
          body: TabBarView(
            children: [
              RefreshIndicator(
                child: FutureBuilder(
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (ctx, i) =>
                              PickemItem(snapshot.data![i]));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                  future: PostgresApi.getPickemsQuestions(Tournaments.msi),
                ),
                onRefresh: () {
                  return Future(() {
                    setState(() {});
                  });
                },
              ),
              const Text('Pas encore dispo'),
              const Text('Pas encore dispo')
            ],
          ),
        ));
  }
}
