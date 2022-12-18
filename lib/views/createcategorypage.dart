import 'package:api_app/services/Category_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  @override
  final _addcategorykey = GlobalKey<FormState>();
  final TextEditingController _addcategory = TextEditingController();
  CategoryService categoryService = CategoryService();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EEFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF424874),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Add Category Page',
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
            'Add New Category',
            style: TextStyle(
              color: const Color(0xFF424874),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Form(
            key: _addcategorykey,
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                children: [
                  TextFormField(
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Category should not empty';
                      }
                    },
                    controller: _addcategory,
                    decoration: const InputDecoration(
                      labelText: 'Category name',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: Color.fromARGB(255, 61, 14, 168)),
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
                        if (_addcategorykey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          await categoryService
                              .addCategory(
                                _addcategory.text,
                              )
                              .then((value) => Navigator.of(context)
                                  .popAndPushNamed('/homepage'));
                        }
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(fontSize: 18),
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
