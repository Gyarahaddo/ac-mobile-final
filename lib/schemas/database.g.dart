// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $FinalDBBuilderContract {
  /// Adds migrations to the builder.
  $FinalDBBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $FinalDBBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<FinalDB> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorFinalDB {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $FinalDBBuilderContract databaseBuilder(String name) =>
      _$FinalDBBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $FinalDBBuilderContract inMemoryDatabaseBuilder() =>
      _$FinalDBBuilder(null);
}

class _$FinalDBBuilder implements $FinalDBBuilderContract {
  _$FinalDBBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $FinalDBBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $FinalDBBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<FinalDB> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$FinalDB();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$FinalDB extends FinalDB {
  _$FinalDB([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CustomerDAO? _customerDAOInstance;

  AirplaneDAO? _airplaneDAOInstance;

  FlightDAO? _flightDAOInstance;

  ReservationDAO? _reservationDAOInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `customers` (`id` TEXT NOT NULL, `firstname` TEXT NOT NULL, `lastname` TEXT NOT NULL, `address` TEXT NOT NULL, `birthday` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `airplanes` (`id` TEXT NOT NULL, `model` TEXT NOT NULL, `capacity` INTEGER NOT NULL, `maxSpeed` INTEGER NOT NULL, `range` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `flights` (`id` TEXT NOT NULL, `flightCode` TEXT NOT NULL, `fromCity` TEXT NOT NULL, `toCity` TEXT NOT NULL, `departureTime` TEXT NOT NULL, `arrivalTime` TEXT NOT NULL, `model` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `reservations` (`id` TEXT NOT NULL, `note` TEXT NOT NULL, `customerId` TEXT NOT NULL, `flightCode` TEXT NOT NULL, `flightDate` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE INDEX `index_customers_firstname` ON `customers` (`firstname`)');
        await database.execute(
            'CREATE INDEX `index_customers_lastname` ON `customers` (`lastname`)');
        await database.execute(
            'CREATE INDEX `index_customers_address` ON `customers` (`address`)');
        await database.execute(
            'CREATE INDEX `index_airplanes_model` ON `airplanes` (`model`)');
        await database.execute(
            'CREATE INDEX `index_airplanes_capacity` ON `airplanes` (`capacity`)');
        await database.execute(
            'CREATE INDEX `index_airplanes_maxSpeed` ON `airplanes` (`maxSpeed`)');
        await database.execute(
            'CREATE INDEX `index_airplanes_range` ON `airplanes` (`range`)');
        await database.execute(
            'CREATE INDEX `index_flights_fromCity` ON `flights` (`fromCity`)');
        await database.execute(
            'CREATE INDEX `index_flights_toCity` ON `flights` (`toCity`)');
        await database.execute(
            'CREATE INDEX `index_flights_fromCity_toCity` ON `flights` (`fromCity`, `toCity`)');
        await database.execute(
            'CREATE INDEX `index_flights_model` ON `flights` (`model`)');
        await database.execute(
            'CREATE INDEX `index_reservations_customerId` ON `reservations` (`customerId`)');
        await database.execute(
            'CREATE INDEX `index_reservations_flightCode` ON `reservations` (`flightCode`)');
        await database.execute(
            'CREATE INDEX `index_reservations_flightDate` ON `reservations` (`flightDate`)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CustomerDAO get customerDAO {
    return _customerDAOInstance ??= _$CustomerDAO(database, changeListener);
  }

  @override
  AirplaneDAO get airplaneDAO {
    return _airplaneDAOInstance ??= _$AirplaneDAO(database, changeListener);
  }

  @override
  FlightDAO get flightDAO {
    return _flightDAOInstance ??= _$FlightDAO(database, changeListener);
  }

  @override
  ReservationDAO get reservationDAO {
    return _reservationDAOInstance ??=
        _$ReservationDAO(database, changeListener);
  }
}

class _$CustomerDAO extends CustomerDAO {
  _$CustomerDAO(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _customerInsertionAdapter = InsertionAdapter(
            database,
            'customers',
            (Customer item) => <String, Object?>{
                  'id': item.id,
                  'firstname': item.firstname,
                  'lastname': item.lastname,
                  'address': item.address,
                  'birthday': item.birthday
                }),
        _customerUpdateAdapter = UpdateAdapter(
            database,
            'customers',
            ['id'],
            (Customer item) => <String, Object?>{
                  'id': item.id,
                  'firstname': item.firstname,
                  'lastname': item.lastname,
                  'address': item.address,
                  'birthday': item.birthday
                }),
        _customerDeletionAdapter = DeletionAdapter(
            database,
            'customers',
            ['id'],
            (Customer item) => <String, Object?>{
                  'id': item.id,
                  'firstname': item.firstname,
                  'lastname': item.lastname,
                  'address': item.address,
                  'birthday': item.birthday
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Customer> _customerInsertionAdapter;

  final UpdateAdapter<Customer> _customerUpdateAdapter;

  final DeletionAdapter<Customer> _customerDeletionAdapter;

  @override
  Future<List<Customer>> listCustomers() async {
    return _queryAdapter.queryList('SELECT * FROM customers',
        mapper: (Map<String, Object?> row) => Customer(
            id: row['id'] as String,
            firstname: row['firstname'] as String,
            lastname: row['lastname'] as String,
            address: row['address'] as String,
            birthday: row['birthday'] as String));
  }

  @override
  Future<Customer?> getCustomerById(String id) async {
    return _queryAdapter.query('SELECT * FROM customers WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Customer(
            id: row['id'] as String,
            firstname: row['firstname'] as String,
            lastname: row['lastname'] as String,
            address: row['address'] as String,
            birthday: row['birthday'] as String),
        arguments: [id]);
  }

  @override
  Future<void> insertCustomer(Customer customer) async {
    await _customerInsertionAdapter.insert(customer, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateCustomer(Customer customer) async {
    await _customerUpdateAdapter.update(customer, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteCustomer(Customer customer) async {
    await _customerDeletionAdapter.delete(customer);
  }
}

class _$AirplaneDAO extends AirplaneDAO {
  _$AirplaneDAO(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _airplaneInsertionAdapter = InsertionAdapter(
            database,
            'airplanes',
            (Airplane item) => <String, Object?>{
                  'id': item.id,
                  'model': item.model,
                  'capacity': item.capacity,
                  'maxSpeed': item.maxSpeed,
                  'range': item.range
                }),
        _airplaneUpdateAdapter = UpdateAdapter(
            database,
            'airplanes',
            ['id'],
            (Airplane item) => <String, Object?>{
                  'id': item.id,
                  'model': item.model,
                  'capacity': item.capacity,
                  'maxSpeed': item.maxSpeed,
                  'range': item.range
                }),
        _airplaneDeletionAdapter = DeletionAdapter(
            database,
            'airplanes',
            ['id'],
            (Airplane item) => <String, Object?>{
                  'id': item.id,
                  'model': item.model,
                  'capacity': item.capacity,
                  'maxSpeed': item.maxSpeed,
                  'range': item.range
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Airplane> _airplaneInsertionAdapter;

  final UpdateAdapter<Airplane> _airplaneUpdateAdapter;

  final DeletionAdapter<Airplane> _airplaneDeletionAdapter;

  @override
  Future<List<Airplane>> listAirplanes() async {
    return _queryAdapter.queryList('SELECT * FROM airplanes',
        mapper: (Map<String, Object?> row) => Airplane(
            id: row['id'] as String,
            model: row['model'] as String,
            capacity: row['capacity'] as int,
            maxSpeed: row['maxSpeed'] as int,
            range: row['range'] as int));
  }

  @override
  Future<Airplane?> getAirplaneById(String id) async {
    return _queryAdapter.query('SELECT * FROM airplanes WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Airplane(
            id: row['id'] as String,
            model: row['model'] as String,
            capacity: row['capacity'] as int,
            maxSpeed: row['maxSpeed'] as int,
            range: row['range'] as int),
        arguments: [id]);
  }

  @override
  Future<void> insertAirplane(Airplane airplane) async {
    await _airplaneInsertionAdapter.insert(airplane, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateAirplane(Airplane airplane) async {
    await _airplaneUpdateAdapter.update(airplane, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteAirplane(Airplane airplane) async {
    await _airplaneDeletionAdapter.delete(airplane);
  }
}

class _$FlightDAO extends FlightDAO {
  _$FlightDAO(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _flightInsertionAdapter = InsertionAdapter(
            database,
            'flights',
            (Flight item) => <String, Object?>{
                  'id': item.id,
                  'flightCode': item.flightCode,
                  'fromCity': item.fromCity,
                  'toCity': item.toCity,
                  'departureTime': item.departureTime,
                  'arrivalTime': item.arrivalTime,
                  'model': item.model
                }),
        _flightUpdateAdapter = UpdateAdapter(
            database,
            'flights',
            ['id'],
            (Flight item) => <String, Object?>{
                  'id': item.id,
                  'flightCode': item.flightCode,
                  'fromCity': item.fromCity,
                  'toCity': item.toCity,
                  'departureTime': item.departureTime,
                  'arrivalTime': item.arrivalTime,
                  'model': item.model
                }),
        _flightDeletionAdapter = DeletionAdapter(
            database,
            'flights',
            ['id'],
            (Flight item) => <String, Object?>{
                  'id': item.id,
                  'flightCode': item.flightCode,
                  'fromCity': item.fromCity,
                  'toCity': item.toCity,
                  'departureTime': item.departureTime,
                  'arrivalTime': item.arrivalTime,
                  'model': item.model
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Flight> _flightInsertionAdapter;

  final UpdateAdapter<Flight> _flightUpdateAdapter;

  final DeletionAdapter<Flight> _flightDeletionAdapter;

  @override
  Future<List<Flight>> listFlights() async {
    return _queryAdapter.queryList('SELECT * FROM flights',
        mapper: (Map<String, Object?> row) => Flight(
            id: row['id'] as String,
            flightCode: row['flightCode'] as String,
            fromCity: row['fromCity'] as String,
            toCity: row['toCity'] as String,
            departureTime: row['departureTime'] as String,
            arrivalTime: row['arrivalTime'] as String,
            model: row['model'] as String));
  }

  @override
  Future<Flight?> getFlightById(String id) async {
    return _queryAdapter.query('SELECT * FROM flights WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Flight(
            id: row['id'] as String,
            flightCode: row['flightCode'] as String,
            fromCity: row['fromCity'] as String,
            toCity: row['toCity'] as String,
            departureTime: row['departureTime'] as String,
            arrivalTime: row['arrivalTime'] as String,
            model: row['model'] as String),
        arguments: [id]);
  }

  @override
  Future<void> insertFlight(Flight flight) async {
    await _flightInsertionAdapter.insert(flight, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateFlight(Flight flight) async {
    await _flightUpdateAdapter.update(flight, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteFlight(Flight flight) async {
    await _flightDeletionAdapter.delete(flight);
  }
}

class _$ReservationDAO extends ReservationDAO {
  _$ReservationDAO(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _reservationInsertionAdapter = InsertionAdapter(
            database,
            'reservations',
            (Reservation item) => <String, Object?>{
                  'id': item.id,
                  'note': item.note,
                  'customerId': item.customerId,
                  'flightCode': item.flightCode,
                  'flightDate': item.flightDate
                }),
        _reservationUpdateAdapter = UpdateAdapter(
            database,
            'reservations',
            ['id'],
            (Reservation item) => <String, Object?>{
                  'id': item.id,
                  'note': item.note,
                  'customerId': item.customerId,
                  'flightCode': item.flightCode,
                  'flightDate': item.flightDate
                }),
        _reservationDeletionAdapter = DeletionAdapter(
            database,
            'reservations',
            ['id'],
            (Reservation item) => <String, Object?>{
                  'id': item.id,
                  'note': item.note,
                  'customerId': item.customerId,
                  'flightCode': item.flightCode,
                  'flightDate': item.flightDate
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Reservation> _reservationInsertionAdapter;

  final UpdateAdapter<Reservation> _reservationUpdateAdapter;

  final DeletionAdapter<Reservation> _reservationDeletionAdapter;

  @override
  Future<List<Reservation>> listReservations() async {
    return _queryAdapter.queryList('SELECT * FROM reservations',
        mapper: (Map<String, Object?> row) => Reservation(
            id: row['id'] as String,
            note: row['note'] as String,
            customerId: row['customerId'] as String,
            flightCode: row['flightCode'] as String,
            flightDate: row['flightDate'] as String));
  }

  @override
  Future<Reservation?> getReservationById(String id) async {
    return _queryAdapter.query('SELECT * FROM reservations WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Reservation(
            id: row['id'] as String,
            note: row['note'] as String,
            customerId: row['customerId'] as String,
            flightCode: row['flightCode'] as String,
            flightDate: row['flightDate'] as String),
        arguments: [id]);
  }

  @override
  Future<void> insertReservation(Reservation reservation) async {
    await _reservationInsertionAdapter.insert(
        reservation, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateReservation(Reservation reservation) async {
    await _reservationUpdateAdapter.update(
        reservation, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteReservation(Reservation reservation) async {
    await _reservationDeletionAdapter.delete(reservation);
  }
}
