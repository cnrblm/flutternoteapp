class Note {
  int _id;
  String _title;
  String _content;

  Note(this._title, this._content);

  Note.fromDb(int id, String title, String content) {
    this._id = id;
    this._title = title;
    this._content = content;
  }

  String get title => _title;
  String get content => _content;
  int get id => _id;

  Note.map(dynamic obj) {
    this._title = obj['title'];
    this._content = obj['content'];
  }

  @override
  String toString() {
    return '{ ${this.title}, ${this.content} }';
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["title"] = _title;
    map["content"] = _content;
    return map;
  }
}
