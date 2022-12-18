import 'package:api_app/services/category_service.dart';
import 'package:flutter/material.dart';

class UpdateCategory extends StatefulWidget {
  const UpdateCategory({super.key});

  @override
  State<UpdateCategory> createState() => _UpdateCategoryState();
}

class _UpdateCategoryState extends State<UpdateCategory> {
  final TextEditingController _categoryname = TextEditingController();
  final _updatekey = GlobalKey<FormState>();

  final CategoryService cs = CategoryService();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List<dynamic>;

    if (args[1] != null) {
      _categoryname.text = args[1];
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Update Category"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Update Category',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Form(
            key: _updatekey,
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Category should not empty';
                      }
                    },
                    controller: _categoryname,
                    decoration: const InputDecoration(
                      labelText: 'Category name',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: Colors.blue,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 35,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.blue,
                        ),
                      ),
                      onPressed: () async {
                        if (_updatekey.currentState!.validate()) {
                          cs.requestUpdate(args[0], _categoryname.text).then(
                                (value) => Navigator.of(context).pop(true),
                              );
                        }
                      },
                      child: const Text('Update'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
