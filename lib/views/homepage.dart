import 'package:api_app/models/Category.dart';
import 'package:api_app/services/category_service.dart';
import 'package:flutter/material.dart';
import 'package:api_app/services/logout_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Category> listCategory = [];
  final cs = CategoryService();

  final logout = LogoutService();

  getData() async {
    listCategory = await cs.getData();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: cs.getData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView(
                      children: (snapshot.data ?? [])
                          .map(
                            (e) => Card(
                              margin: EdgeInsets.all(4.0),
                              color: Colors.blueGrey[50],
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 330,
                                      child: Text(
                                        e.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        var data = await Navigator.of(context)
                                            .pushNamed('/category/update',
                                                arguments: [e.id, e.name]);
                                        if (data != null) {
                                          await getData();
                                          setState(() {});
                                        }
                                      },
                                      color: Colors.blue,
                                      icon: const Icon(Icons.edit),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        await cs.requestDelete(e);
                                        setState(() {});
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                    
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
              child: MaterialButton(
                minWidth: 500,
                height: 60,
                child: Text(
                  "Add New Category",
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                color: Colors.blue,
                onPressed: () {
                  Navigator.pushNamed(context, '/category/add');
                },
              ),
            ),
            MaterialButton(
              minWidth: 500,
              height: 60,
              child: Text(
                "Logout",
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              color: Colors.red,
              onPressed: () {
                logout.postDataLogout().then(
                      (value) =>
                          Navigator.of(context).popAndPushNamed('/login'),
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
