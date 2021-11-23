import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tableBook = 'my_book';
final String columnId = '_id';
final String columnName = 'name';
final String columnAuthor = 'author';
final String columnPublishingHouse = 'publishingHouse';

class MyBook {
  int? id;
  String? name;
  String? author;
  String? publishingHouse;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      columnName: name,
      columnAuthor: author,
      columnPublishingHouse: publishingHouse
    };
    map[columnId] = id;
    return map;
  }

  MyBook.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    name = map[columnName];
    author = map[columnAuthor];
    publishingHouse = map[columnPublishingHouse];
  }

  MyBook(int id, String name, String author, String publishingHouse) {
    this.id = id;
    this.name = name;
    this.author = author;
    this.publishingHouse = publishingHouse;
  }
}

class MyBookSqlite {
  Database? db;

  openSqlite() async {
    var databasePath = await getDatabasesPath();
    print(databasePath);
    String path = join(databasePath, 'books.db');
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE $tableBook (
            $columnId INTEGER PRIMARY KEY, 
            $columnName TEXT, 
            $columnAuthor TEXT, 
            $columnPublishingHouse TEXT)
          ''');
      }
    );
  }
  //插入一本书
  Future<MyBook> insert(MyBook book) async {
    book.id = await db!.insert(tableBook, book.toMap());
    return book;
  }

  //查找所有书
  Future<List<MyBook>?> queryAll() async {
    List<Map<String, dynamic>> maps = await db!.query(tableBook, columns: [
      columnId,
      columnName,
      columnAuthor,
      columnPublishingHouse
    ]);
    if (maps.length == 0) {
      return null;
    }
    List<MyBook> books = [];
    for (int i=0; i < maps.length; i++) {
      MyBook item = MyBook.fromMap(maps[i]);
      books.add(item);
    }
    return books;
  }

  //根据ID找书
  Future<MyBook?> getBookByID(int id) async {
    List<Map<String, dynamic>> maps = await db!.query(
      tableBook,
      columns: [
        columnId,
        columnName,
        columnAuthor,
        columnPublishingHouse
      ]
    );
    if (maps.length > 0) {
      return MyBook.fromMap(maps.first);
    }
    return null;
  }

  //根据ID删除一本书
  Future<int> deleteByID(int id) async {
    return db!.delete(tableBook, where: '$columnId = ?', whereArgs: [id]);
  }

  //更新书的信息
  Future<int> updateByBook(MyBook book) async {
    return await db!.update(tableBook, book.toMap(), where: '$columnId = ?', whereArgs: [book.id]);
  }

  //关闭数据库，避免内存泄漏
  close() async {
    await db!.close();
  }

}