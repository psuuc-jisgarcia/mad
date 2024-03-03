import 'package:garcia_judge/models/product.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static const dbName = 'products.db';
  static const dbVersion = 2;
  static const tbProduct = 'product';
  static const prodCode = 'code';
  static const prodName = 'nameDesc';
  static const prodPrice = 'price';

  static Future<Database> openDb() async {
    var path = join(await getDatabasesPath(), DbHelper.dbName);
    var createSql =
        'CREATE TABLE IF NOT EXISTS $tbProduct ($prodCode TEXT PRIMARY KEY, $prodName TEXT NOT NULL, $prodPrice DECIMAL(10,2))';
    var db = await openDatabase(
      path,
      version: DbHelper.dbVersion,
      onCreate: (db, version) {
        db.execute(createSql);
        print('table $tbProduct created');
      },
      onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion < newVersion) {
          db.execute('DROP TABLE IF EXISTS $tbProduct');
          db.execute(createSql);
        }
      },
    );
    return db;
  }

  static void insertProduct(Product product) async {
    final db = await openDb();
    db.insert(tbProduct, product.toMap());
    print('inserted product');
  }

  static Future<List<Map<String, dynamic>>> fetchProducts() async {
    final db = await openDb();
    return await db.query(
      tbProduct,
    );
  }

  static Future<void> deleteProduct(String productCode) async {
    final db = await openDb();
    await db.delete(
      tbProduct,
      where: '$prodCode = ?',
      whereArgs: [productCode.toString()],
    );
  }
}
