import 'package:flutter/material.dart';
import 'package:flutter_notebook/data/database_helper.dart';
import 'package:flutter_notebook/models/note.dart';

class AddNotePage extends StatefulWidget {
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  BuildContext _ctx;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  Future<void> _submit() async {
    var db = DatabaseHelper();
    var res = db.saveUser(Note(titleController.text, contentController.text));

    _showSnackBar();
    FocusScope.of(context).unfocus(); // close keyboard
  }

  void _showSnackBar() {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Note Added"),
    ));
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;

    var saveBtn = RaisedButton(
        onPressed: _submit, child: Text("Add"), color: Colors.green);

    var addNoteForm = Column(
      children: <Widget>[
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: "Title"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                    controller: contentController,
                    decoration: InputDecoration(labelText: "Content"),
                    keyboardType: TextInputType.multiline,
                    maxLines: null),
              ),
            ],
          ),
        ),
        saveBtn
      ],
    );

    return Scaffold(
        appBar: AppBar(
          title: Text("Add Note"),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
                tooltip: MaterialLocalizations.of(context).backButtonTooltip,
              );
            },
          ),
        ),
        key: scaffoldKey,
        body: Container(
          child: addNoteForm,
        ));
  }
}
