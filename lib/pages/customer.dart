/// CST2335 Final Project.
///
/// Created: July 25, 2025
/// Group Members:
///  - Lingfeng "Galahad" Zhao (zhao0291@algonquinlive.com)
///  - Jesse Proulx (prou0212@algonquinlive.com)
///  - Xinghan Xu (xu000334@algonquinlive.com)
///  - Luca Barbesin (barb0285@algonquinlive.com)
library;

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:ac_mobile_final/components/navbar.dart';
import 'package:ac_mobile_final/components/message.dart';
import 'package:ac_mobile_final/components/footer.dart';
import 'package:ac_mobile_final/services/datasource.dart';
import 'package:ac_mobile_final/services/appcache.dart';
import 'package:ac_mobile_final/schemas/customer.dart';
import 'package:ac_mobile_final/schemas/reservation.dart';
import 'package:ac_mobile_final/pages/customerOps/detail.dart';
import 'package:ac_mobile_final/pages/customerOps/input.dart';
import 'package:ac_mobile_final/pages/customerOps/update.dart';

/// The main page to manage customers.
///
/// Provides insert, update, and detail view of customer records.
class CustomerPage extends StatefulWidget {
  /// Creates a [CustomerPage].
  const CustomerPage({
    super.key,
  });

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  /// UUID generator for customer IDs.
  final uuid = Uuid();
  /// Data source instance to interact with the backend.
  final DataSource _dataSource = DataSource.instance;

  // Controllers for insert.
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();

  // Controllers for update.
  final TextEditingController _firstnameUpdate = TextEditingController();
  final TextEditingController _lastnameUpdate = TextEditingController();
  final TextEditingController _addressUpdate = TextEditingController();
  final TextEditingController _birthdayUpdate = TextEditingController();

  /// List of all customer records.
  List<Customer> customers = [];
  /// List of all reservation records.
  List<Reservation> reservations = [];
  /// Currently selected customer for detail.
  Customer? selectedCustomer;


  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await _dataSource.syncAll();
      await AppCache.syncFromCustomerCache();

      reservations = DataSource.reservations;

      setState(() {
        customers = DataSource.customers;

        if (AppCache.firstname != '') _firstnameController.text = AppCache.firstname;
      });
    });
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _addressController.dispose();
    _birthdayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool tabletLayout = screenWidth > 600;

    final localizations = AppLocalizations.of(context)!;

    /// Clears the current selection.
    void unselect() {
      setState(() {
        selectedCustomer = null;
      });
    }

    /// Selects a customer to show details.
    void selected(Customer customer) {
      setState(() {
        selectedCustomer = customer;
      });
    }

    /// Deletes a customer if no reservation is linked.
    Future<void> removeCustomer(Customer? customer) async {
      if (customer == null) return;

      Reservation? targetReservation = reservations
          .cast<Reservation?>()
          .firstWhere((res) => res?.customerId == customer.id,
        orElse: () => null,
      );

      if (targetReservation == null) {
        await _dataSource.deleteCustomer(customer);

        setState(() {
          customers = DataSource.customers;
        });
      } else {
        SnackMessage.showMessage(
            context,
            localizations.msg2customerHasReservation,
            3
        );
      }
    }

    /// Inserts a new customer based on the form inputs.
    Future<void> insertCustomer() async {
      if (_firstnameController.text.trim().isEmpty) {
        SnackMessage.showMessage(context, localizations.msg2noFirstname, 1);
        return;
      }

      if (_lastnameController.text.trim().isEmpty) {
        SnackMessage.showMessage(context, localizations.msg2noLastname, 1);
        return;
      }

      if (_addressController.text.trim().isEmpty) {
        SnackMessage.showMessage(context, localizations.msg2noAddress, 1);
        return;
      }

      if (_birthdayController.text.trim().isEmpty) {
        SnackMessage.showMessage(context, localizations.msg2noBirthday, 1);
        return;
      }

      await _dataSource.addCustomer(
        Customer(
          id: uuid.v1(),
          firstname: _firstnameController.text,
          lastname: _lastnameController.text,
          address: _addressController.text,
          birthday: _birthdayController.text,
        ),
      );

      AppCache.firstname = _firstnameController.text;
      AppCache.lastname = _lastnameController.text;
      AppCache.address = _addressController.text;
      AppCache.birthday = _birthdayController.text;

      await AppCache.syncToCustomerCache();

      SnackMessage.showMessage(context, localizations.msg2addCustomer, 2);

      setState(() {
        customers = DataSource.customers;
      });
    }

    /// Updates an existing customer with the new form values.
    Future<void> updateCustomer(Customer customer) async {
      if (_firstnameUpdate.text.trim().isEmpty &&
          _lastnameUpdate.text.trim().isEmpty &&
          _addressUpdate.text.trim().isEmpty &&
          _birthdayUpdate.text.trim().isEmpty
      ) {
        SnackMessage.showMessage(context, localizations.msg2noUpdateCustomer, 2);
        return;
      }

      String newFirstname = customer.firstname;
      String newLastname = customer.lastname;
      String newAddress = customer.address;
      String newBirthday = customer.birthday;

      if (_firstnameUpdate.text.trim().isNotEmpty) newFirstname = _firstnameUpdate.text;
      if (_lastnameUpdate.text.trim().isNotEmpty) newLastname = _lastnameUpdate.text;
      if (_addressUpdate.text.trim().isNotEmpty) newAddress = _addressUpdate.text;
      if (_birthdayUpdate.text.trim().isNotEmpty) newBirthday = _birthdayUpdate.text;

      await _dataSource.updateCustomer(
        Customer(
          id: customer.id,
          firstname: newFirstname,
          lastname: newLastname,
          address: newAddress,
          birthday: newBirthday,
        ),
      );

      setState(() {
        customers = DataSource.customers;
        _firstnameUpdate.clear();
        _lastnameUpdate.clear();
        _addressUpdate.clear();
        _birthdayUpdate.clear();
      });
    }

    /// Resets the customer form and clears cached fields.
    Future<void> resetCustomer() async {
      AppCache.firstname = '';
      AppCache.lastname = '';
      AppCache.address = '';
      AppCache.birthday = '';
      await AppCache.syncToCustomerCache();

      setState(() {
        _firstnameController.clear();
        _lastnameController.clear();
        _addressController.clear();
        _birthdayController.clear();
      });
    }

    final portraitView = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 0.5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                'assets/images/customer_btn.png',
                height: 150,
                fit: BoxFit.cover,
              )
            ),
            InputsBar(
              firstnameController: _firstnameController,
              lastnameController: _lastnameController,
              addressController: _addressController,
              birthdayController: _birthdayController,
              onClick: insertCustomer,
              onReset: resetCustomer,
            ),
            ...customers.asMap().entries.map((entry) => Container(
              margin: EdgeInsets.all(10.0),
              child: Card(
                elevation: 0.5,
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  title: Text(
                    '${entry.value.firstname} ${entry.value.lastname}',
                    style: GoogleFonts.roboto(),
                  ),
                  subtitle: Text(
                    entry.value.address,
                    style: GoogleFonts.roboto(),
                  ),
                  onLongPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateCustomer(
                          onUpdate: () => updateCustomer(entry.value),
                          customer: entry.value,
                          firstnameController: _firstnameUpdate,
                          lastnameController: _lastnameUpdate,
                          addressController: _addressUpdate,
                          birthdayController: _birthdayUpdate,
                        ),
                      ),
                    );
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomerDetail(
                          customer: entry.value,
                          onCancel: unselect,
                          onRemove: () => removeCustomer(entry.value),
                          navBar: true,
                          goBack: true,
                        )
                      )
                    );
                  },
                ),
              ),
            )),
            CopyrightFooter(content: localizations.copyright),
          ],
        ),
      )
    );

    final landscapeView = SafeArea(
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                      elevation: 0.5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset(
                        'assets/images/customer_btn.png',
                        height: 150,
                        fit: BoxFit.cover,
                      )
                  ),
                  InputsBar(
                    firstnameController: _firstnameController,
                    lastnameController: _lastnameController,
                    addressController: _addressController,
                    birthdayController: _birthdayController,
                    onClick: insertCustomer,
                    onReset: resetCustomer,
                  ),
                  ...customers.asMap().entries.map((entry) => Container(
                    margin: EdgeInsets.all(10.0),
                    child: Card(
                      elevation: 0.5,
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        title: Text(
                          '${entry.value.firstname} ${entry.value.lastname}',
                          style: GoogleFonts.roboto(),
                        ),
                        subtitle: Text(
                          entry.value.address,
                          style: GoogleFonts.roboto(),
                        ),
                        onLongPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateCustomer(
                                onUpdate: () => updateCustomer(entry.value),
                                customer: entry.value,
                                firstnameController: _firstnameUpdate,
                                lastnameController: _lastnameUpdate,
                                addressController: _addressUpdate,
                                birthdayController: _birthdayUpdate,
                              ),
                            ),
                          );
                        },
                        onTap: () {
                          selected(entry.value);
                        },
                      ),
                    ),
                  )),
                  CopyrightFooter(content: localizations.copyright),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: CustomerDetail(
              customer: selectedCustomer,
              onCancel: unselect,
              onRemove: () => removeCustomer(selectedCustomer),
              navBar: false,
              goBack: false,
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: MainNav(
        title: localizations.btn2customer,
        returnButton: true,
      ),
      body: tabletLayout ? landscapeView : portraitView,
    );
  }
}