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
      backgroundColor: const Color(0xFFF4EEFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF424874),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Edit Category Page',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Update Category',
            style: TextStyle(
              color: const Color(0xFF424874),
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
                            width: 1, color: const Color(0xFF424874),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: const Color(0xFF424874),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF424874),
                        ),
                      ),
                      onPressed: () async {
                        if (_updatekey.currentState!.validate()) {
                          cs.requestUpdate(args[0], _categoryname.text).then(
                                (value) => Navigator.of(context).pop(true),
                              );
                        }
                      },
                      child: const Text('Submit', style: TextStyle(fontSize: 18),
                      ),
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
