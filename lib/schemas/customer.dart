import 'package:floor/floor.dart';

@Entity(
  tableName: 'customers',
  primaryKeys: ['id'],
  indices: [
    Index(value: ['firstname']),
    Index(value: ['lastname']),
    Index(value: ['address']),
  ],
)
class Customer {
  final String id;
  final String firstname;
  final String lastname;
  final String address;
  final String birthday;

  Customer({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.address,
    required this.birthday,
  });
}

@dao
abstract class CustomerDAO {
  @Query('SELECT * FROM customers')
  Future<List<Customer>> listCustomers();

  @Query('SELECT * FROM customers WHERE id = :id')
  Future<Customer?> getCustomerById(String id);

  @Update()
  Future<void> updateCustomer(Customer customer);

  @insert
  Future<void> insertCustomer(Customer customer);

  @delete
  Future<void> deleteCustomer(Customer customer);
}