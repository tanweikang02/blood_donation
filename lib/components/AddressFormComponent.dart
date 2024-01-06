import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:medilab_prokit/model/Address.dart';
import 'package:medilab_prokit/providers/appointment_provider.dart';
import 'package:medilab_prokit/screens/MLBookAppointmentScreen.dart';
import 'package:provider/provider.dart';

class AddressFormComponent extends StatefulWidget {
  final callChildMethodController controller;
  AddressFormComponent({required this.controller});
  @override
  _AddressFormComponentState createState() =>
      _AddressFormComponentState(controller);
}

class _AddressFormComponentState extends State<AddressFormComponent> {
  Address address = Address();
  List<String> cities = [];
  String? stateName;

  _AddressFormComponentState(callChildMethodController _controller) {
    _controller.method = returnAddressToParentComponent;
  }

  Future<List<String>> getCitiesAPI(String state) async {
    // Make API call to get state name and cities
    final response = await http
        .get(Uri.parse('https://jian.sh/malaysia-api/state/v1/${state}.json'));

    if (response.statusCode == 200) {
      // Successful response, parse the JSON data
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> citiesData = data['administrative_districts'];

      setState(() {
        address.state = data['name'];
        cities = citiesData.map((city) => city.toString()).toList();
      });
    } else {
      // Error handling
      print('Failed to load data: ${response.statusCode}');
    }

    return [];
  }

  dynamic returnAddressToParentComponent() {
    context
        .read<AppointmentProvider>()
        .changeAddress(newAddress: address.getFullAddress());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Form(
              child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Address",
                  hintText: "Street Address",
                ),
                onChanged: (value) {
                  setState(() {
                    address.address1 = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Address 2 (Optional)",
                  hintText: "Apartment, suite, unit, building, floor, etc.",
                ),
                onChanged: (value) {
                  setState(() {
                    address.address2 = value;
                  });
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 15), // Add padding top
                decoration: ShapeDecoration(
                  shape: UnderlineInputBorder(),
                ),
                child: DropdownButton(
                  hint: Text("State"),
                  borderRadius: BorderRadius.circular(10),
                  underline: SizedBox(),
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(child: Text("Johor"), value: "johor"),
                    DropdownMenuItem(child: Text("Kedah"), value: "kedah"),
                    DropdownMenuItem(
                        child: Text("Kelantan"), value: "kelantan"),
                    DropdownMenuItem(child: Text("Malacca"), value: "malacca"),
                    DropdownMenuItem(
                        child: Text("Negeri Sembilan"),
                        value: "negeri_sembilan"),
                    DropdownMenuItem(child: Text("Pahang"), value: "pahang"),
                    DropdownMenuItem(child: Text("Perak"), value: "perak"),
                    DropdownMenuItem(child: Text("Perlis"), value: "perlis"),
                    DropdownMenuItem(child: Text("Penang"), value: "penang"),
                    DropdownMenuItem(child: Text("Sabah"), value: "sabah"),
                    DropdownMenuItem(child: Text("Sarawak"), value: "sarawak"),
                    DropdownMenuItem(
                        child: Text("Selangor"), value: "selangor"),
                    DropdownMenuItem(
                        child: Text("Terengganu"), value: "terengganu"),
                    DropdownMenuItem(
                        child: Text("Kuala Lumpur"), value: "kuala_lumpur"),
                    DropdownMenuItem(child: Text("Labuan"), value: "labuan"),
                    DropdownMenuItem(
                        child: Text("Putrajaya"), value: "putrajaya"),
                  ],
                  value: stateName,
                  onChanged: (value) => {
                    setState(() {
                      address.city = null;
                      cities = [];
                      stateName = value.toString();
                    }),
                    getCitiesAPI(value.toString())
                  },
                ),
              ),
              LayoutBuilder(builder: (c, b) {
                return Wrap(
                  spacing: 10,
                  children: [
                    SizedBox(
                        width: (b.maxWidth / 2) - 5,
                        child: Container(
                          margin: EdgeInsets.only(top: 15), // Add padding top
                          decoration: ShapeDecoration(
                            shape: UnderlineInputBorder(),
                          ),
                          child: DropdownButton(
                            hint: Text("City"),
                            borderRadius: BorderRadius.circular(10),
                            underline: SizedBox(),
                            isExpanded: true,
                            items: cities.map((String city) {
                              return DropdownMenuItem<String>(
                                child: new Text(city),
                                value: city,
                              );
                            }).toList(),
                            value: address.city,
                            onChanged: (value) => {
                              setState(() {
                                address.city = value.toString();
                              })
                            },
                          ),
                        )),
                    SizedBox(
                        width: (b.maxWidth / 2) - 5,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Postcode",
                          ),
                          onChanged: (value) {
                            setState(() {
                              address.postcode = value;
                            });
                          },
                        ))
                  ],
                );
              })
            ],
          )),
        ],
      ),
    );
  }
}
