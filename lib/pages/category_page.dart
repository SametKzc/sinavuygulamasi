import 'package:flutter/material.dart';
import 'package:flutter_sinav_uygulamasi/models/category.dart';
import 'package:flutter_sinav_uygulamasi/pages/add_quiz.dart';
import 'package:flutter_sinav_uygulamasi/widgets/widgets.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  TextEditingController categoryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => Card(
          elevation: 0.0,
          child: ListTile(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddQuiz(
                categoryModel: categories[index],
              )
              ));
            },
            title: Text(
              categories[index].name,
              style: Theme.of(context).textTheme.headline6,
            ),
            trailing: CircleAvatar(
              child: Text("${categories[index].quizList.length}"),
            ),
          ),
        ),
        itemCount: categories.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showCategory,
        child: Icon(Icons.add),
      ),
    );
  }

  showCategory() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Category"),
        content: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: categoryController,
          ),
        ),
        actions: [
          TextButton(

            onPressed: () {
              categoryController.clear();
              Navigator.pop(context);
            },
            child: Text("CANCEL"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                categories.add(CategoryModel(
                  name: categoryController.text,
                  quizList: [],
                ));
              });
              categoryController.clear();
              Navigator.pop(context);
            },
            child: Text("ADD"),
          ),
        ],
      ),
    );
  }
}
