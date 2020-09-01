import 'package:flutter/material.dart';
import 'package:flutter_notebook/data/database_helper.dart';
import 'package:flutter_notebook/models/note.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Note>> records;

  @override
  void initState() {
    records = DatabaseHelper().getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Notes'),
      ),
      body: FutureBuilder<List<Note>>(
        future: records,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                final title = snapshot.data[index].title;
                return Dismissible(
                  direction: DismissDirection.endToStart,
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    setState(() {
                      DatabaseHelper().removeNote(snapshot.data[index].id);
                      snapshot.data.removeAt(index);
                    });
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("$title deleted")));
                  },
                  background: slideLeftBackground(),
                  child: Card(
                    child: ListTile(
                      title: Text(
                        snapshot.data[index].title,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(snapshot.data[index].content.length > 20
                          ? snapshot.data[index].content.substring(0, 20) +
                              " ..."
                          : snapshot.data[index].content),
                      onTap: () {
                        Navigator.pushNamed(context, "/shownote",
                            arguments: snapshot.data[index]);
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            return CircularProgressIndicator();
          }
          return CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/addnote').then((value) {
            setState(() {
              records = DatabaseHelper().getAll();
            });
          });
        },
        child: Icon(Icons.plus_one),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }
}
