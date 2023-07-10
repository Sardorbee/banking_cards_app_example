import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoo/services/api/api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "My Cards",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          8,
        ),
        child: Column(
          children: [
            FutureBuilder(
              future: CardService.fetchdata(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final carddata = snapshot.data;

                  // return _buildContactList(contacts!, context);
                  if (carddata.isEmpty) {
                    return const Center(
                      child: Text(
                        "You have no games yet",
                        style: TextStyle(color: Colors.black38, fontSize: 16),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: carddata.length,
                        itemBuilder: (BuildContext context, int index) {
                          final data = carddata[index];
                          final colorr1 = "${data.colors.colorA}".substring(1);
                          final colorr2 = "${data.colors.colorB}".substring(1);
                          final colorA = "0xFF$colorr1";
                          final colorB = "0xFF$colorr2";

                          return Container(
                            height: 220,
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(10)),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(int.parse(colorA)),
                                      Color(int.parse(colorB)),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(int.parse(colorA)),
                                      spreadRadius: 4,
                                      blurRadius: 3,
                                      offset: const Offset(0, 3),
                                    ),
                                    // BoxShadow(
                                    //   color: Color(int.parse(colorB)),
                                    //   spreadRadius: 2,
                                    //   blurRadius: 3,
                                    //   offset: Offset(0, 3),
                                    // ),
                                  ]),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        data.bankName,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Container(
                                        height: 40,
                                        child: Image.network(
                                          data.iconImage,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "****",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        "${data.cardNumber}".substring(14),
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${data.moneyAmount.toString()}  SO'M",
                                        style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  const Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Expires",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        DateFormat('yy/MM')
                                            .format(data.expireDate),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        data.cardType,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
