import 'package:floor/floor.dart';

@Entity(
  tableName: 'airplanes',
  primaryKeys: ['id'],
  indices: [
    Index(value: ['model']),
    Index(value: ['capacity']),
    Index(value: ['maxSpeed']),
    Index(value: ['range']),
  ],
)
class Airplane {
  final String id;
  final String model;
  final int capacity;
  final int maxSpeed;
  final int range;

  Airplane({
    required this.id,
    required this.model,
    required this.capacity,
    required this.maxSpeed,
    required this.range,
  });
}

@dao
abstract class AirplaneDAO {
  @Query('SELECT * FROM airplanes')
  Future<List<Airplane>> listAirplanes();

  @Query('SELECT * FROM airplanes WHERE id = :id')
  Future<Airplane?> getAirplaneById(String id);

  @Update()
  Future<void> updateAirplane(Airplane airplane);

  @insert
  Future<void> insertAirplane(Airplane airplane);

  @delete
  Future<void> deleteAirplane(Airplane airplane);
}