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
      backgroundColor: const Color(0xFFF4EEFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF424874),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Home Page',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                              margin: const EdgeInsets.all(4.0),
                              color: const Color(0xFFDCD6F7),
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
                                      color: const Color(0xFF424874),
                                      icon: const Icon(Icons.edit),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () async => showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title:
                                              const Text('Deleting Category'),
                                          backgroundColor:
                                              const Color(0xFFDCD6F7),
                                          content: const Text(
                                              'Are sure want to delete this category?'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, 'No'),
                                              child: const Text(
                                                'No',
                                                style: TextStyle(
                                                    color: Color(0xFF424874)),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () async => {
                                                await cs.requestDelete(e),
                                                setState(() {}),
                                                Navigator.pop(context, 'Yes'),
                                              },
                                              child: const Text(
                                                'Yes',
                                                style: TextStyle(
                                                    color: Color(0xFF424874)),
                                              ),
                                            ),
                                          ],
                                        ),
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
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 15),
              child: MaterialButton(
                minWidth: 500,
                height: 50,
                child: Text(
                  "Add New Category",
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                color: const Color(0xFFA6B1E1),
                onPressed: () {
                  Navigator.pushNamed(context, '/category/add');
                },
              ),
            ),
            MaterialButton(
              minWidth: 500,
              height: 50,
              child: Text(
                "Logout",
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              color: const Color(0xFF424874),
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
