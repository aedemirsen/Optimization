import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'model/input.dart';
import 'optimizer.dart';

class Optimization extends StatelessWidget {
  Optimization({Key? key, required this.email}) : super(key: key);

  String? email;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MyHomePage(
      title: 'Profil Optimizasyon Sistemi',
      email: '',
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.email})
      : super(key: key);

  final String title;
  final String email;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Widget> _storageLines;
  late List<Widget> _profileLines;

  late List<List<TextEditingController>> _storageTextControllers;
  late List<List<TextEditingController>> _profileTextControllers;

  late bool _warning, _optimized, _missingItem;
  int? _type;

  late Optimizer optimizer;

  List<DataRow>? _rows, _missingRow;

  int _toplamFire = 0;

  @override
  void initState() {
    _storageTextControllers = [];
    _profileTextControllers = [];

    _storageLines = [];
    _storageLines.add(_line(0));

    _profileLines = [];
    _profileLines.add(_line(1));

    _rows = [];
    _missingRow = [];

    _warning = false;
    _optimized = false;
    _missingItem = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size(width, 200),
        child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.6,
                child: Image.asset(
                  '1.jpg',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 80.0),
              child: Align(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      widget.email,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                alignment: Alignment.centerLeft,
              ),
            ),
          ],
        ),
      ),
      body: Visibility(
        visible: _warning,
        child: _alert(_type),
        replacement: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 4, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'STOK BİLGİSİ',
                              style: TextStyle(
                                fontFamily: 'Arial',
                                fontSize: 20,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 8),
                          ),
                          SingleChildScrollView(
                            child: Container(
                              width: double.infinity,
                              height: 400,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Colors.blue,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 8.0,
                                  bottom: 8.0,
                                ),
                                child: ListView(
                                  shrinkWrap: true,
                                  children: [
                                    ..._storageLines,
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          //delete button
                                          Builder(
                                            builder: (context) {
                                              if (_storageLines.length != 1) {
                                                return _deleteButton(0);
                                              } else {
                                                return const SizedBox.shrink();
                                              }
                                            },
                                          ),
                                          _storageLines.length != 1
                                              ? const Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 8,
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          //add button
                                          _addButton(0),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(4, 8, 8, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'PROFİL BİLGİSİ',
                              style: TextStyle(
                                fontFamily: 'Arial',
                                fontSize: 20,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 8),
                          ),
                          SingleChildScrollView(
                            child: Container(
                              width: double.infinity,
                              height: 400,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Colors.blue,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 8.0,
                                  bottom: 8.0,
                                ),
                                child: ListView(
                                  shrinkWrap: true,
                                  children: [
                                    ..._profileLines,
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          //delete button
                                          Builder(
                                            builder: (context) {
                                              if (_profileLines.length != 1) {
                                                return _deleteButton(1);
                                              } else {
                                                return const SizedBox.shrink();
                                              }
                                            },
                                          ),
                                          _profileLines.length != 1
                                              ? const Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 8,
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          //add button
                                          _addButton(1),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: CupertinoButton(
                    child: const Text('Optimizasyonu Başlat'),
                    onPressed: _optimize,
                  ),
                ),
              ),
              const Divider(),
              Visibility(
                visible: _optimized,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      //Kesim sonucu text
                      const Center(
                        child: Text(
                          'Kesim Sonucu',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      //Kesim sonucu tablo
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: SizedBox(
                          width: width,
                          child: DataTable(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.blue,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            dataTextStyle: const TextStyle(
                              fontFamily: 'Arial',
                            ),
                            columns: const [
                              DataColumn(
                                label: Text(
                                  'Kesilecek Profil',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Kesilecek Ölçüler',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Fire',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Kesim Sayısı',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                            rows: _rows!,
                          ),
                        ),
                      ),
                      //toplam fire tablo
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: DataTable(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          dataTextStyle: const TextStyle(
                            fontFamily: 'Arial',
                          ),
                          columns: [
                            const DataColumn(
                              label: Text(
                                'Toplam Fire :',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                _toplamFire.toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                          rows: const [],
                        ),
                      ),
                      //Eksik profiller tablo
                      Visibility(
                        visible: _missingItem,
                        child: Column(
                          children: [
                            const Center(
                              child: Text(
                                'Eksik Profiller',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  fontFamily: 'Arial',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: DataTable(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.red,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                dataTextStyle: const TextStyle(
                                  fontFamily: 'Arial',
                                ),
                                columns: const [
                                  DataColumn(
                                    label: Text(
                                      'Gerekli Uzunluk',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Adet',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                                rows: _missingRow!,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _optimize() {
    //clear
    _rows!.clear();
    _missingRow!.clear();
    _missingItem = false;

    Input input = Input();

    List<int> storage = [];
    for (var s in _storageTextControllers) {
      if (s[0].text == "") {
        setState(() {
          _warning = true;
          _type = 0;
        });
      } else if (s[1].text == "") {
        setState(() {
          _warning = true;
          _type = 0;
        });
      } else {
        for (int i = 0; i < int.parse(s[1].text); i++) {
          storage.add(int.parse(s[0].text));
        }
      }
    }
    input.storage = storage;
    List<int> profile = [];
    for (var s in _profileTextControllers) {
      if (s[0].text == "") {
        setState(() {
          _warning = true;
          _type = 1;
        });
      } else if (s[1].text == "") {
        setState(() {
          _warning = true;
          _type = 1;
        });
      } else {
        for (int i = 0; i < int.parse(s[1].text); i++) {
          profile.add(int.parse(s[0].text));
        }
      }
    }
    input.profile = profile;

    //Optimization
    optimizer = Optimizer(input);

    if (storage.isNotEmpty && profile.isNotEmpty) {
      optimizer.optimize();

      Map<int, int> storageMap = optimizer.storageMap(input);
      Map<int, int> cutMap = optimizer.output.usedItemMap();
      Map<int, int> missingItems = optimizer.missingMap(storageMap, cutMap);

      List<String> cuts = optimizer.output.kesimBicimi;
      for (var cut in cuts) {
        List<DataCell> _cells = [];
        var splitted = cut.split('#');
        //1
        var dc1 = DataCell(
          Text(splitted[0]),
        );
        _cells.add(dc1);
        //2
        var dc2 = DataCell(
          Text(splitted[1]),
        );
        _cells.add(dc2);
        //3
        var dc3 = DataCell(
          Text(splitted[2]),
        );
        _cells.add(dc3);
        //4
        var dc4 = DataCell(
          Text(splitted[3]),
        );
        _cells.add(dc4);

        _rows!.add(DataRow(cells: _cells));
      }

      for (var missing in missingItems.entries) {
        List<DataCell> _cells = [];
        //1
        var dc1 = DataCell(
          Text(missing.key.toString()),
        );
        _cells.add(dc1);
        //2
        var dc2 = DataCell(
          Text(missing.value.toString()),
        );
        _cells.add(dc2);
        _missingRow!.add(DataRow(cells: _cells));
      }

      setState(() {
        _optimized = true;
        _toplamFire = optimizer.output.toplamAtikUzunluk;
        if (missingItems.isNotEmpty) {
          _missingItem = true;
        }
      });
    }
  }

  _line(type) {
    //generate 2 text editing controller
    var len = TextEditingController();
    var quantity = TextEditingController();
    List<TextEditingController> line = [len, quantity];
    //type 0 => storage
    //type 1 => profile
    if (type == 0) {
      _storageTextControllers.add(line);
    } else {
      _profileTextControllers.add(line);
    }
    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.only(left: 8, right: 4)),
            Flexible(
              flex: 2,
              child: SizedBox(
                height: 30,
                child: CupertinoTextField(
                  controller: len,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                  placeholder: 'Profil Uzunluğu',
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                  ],
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(left: 4, right: 4)),
            Flexible(
              flex: 2,
              child: SizedBox(
                height: 30,
                child: CupertinoTextField(
                  controller: quantity,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                  placeholder: 'Profil Adeti',
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                  ],
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(left: 4, right: 8)),
          ],
        ),
      ],
    );
  }

  _deleteButton(type) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: SizedBox(
        width: 30,
        height: 30,
        child: FloatingActionButton(
          heroTag: null,
          elevation: 0,
          backgroundColor: Colors.red,
          child: const Icon(CupertinoIcons.minus),
          onPressed: () {
            setState(() {
              //storage
              if (type == 0) {
                if (_storageLines.length > 1) {
                  _storageLines.removeLast();
                  _storageLines = [..._storageLines];
                  _storageTextControllers.removeLast();
                  _storageTextControllers = [..._storageTextControllers];
                }
              }
              //profile
              else {
                if (_profileLines.length > 1) {
                  _profileLines.removeLast();
                  _profileLines = [..._profileLines];
                  _profileTextControllers.removeLast();
                  _profileTextControllers = [..._profileTextControllers];
                }
              }
            });
          },
        ),
      ),
    );
  }

  _addButton(type) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: SizedBox(
        width: 30,
        height: 30,
        child: FloatingActionButton(
          heroTag: null,
          elevation: 0,
          backgroundColor: Colors.blue,
          child: const Icon(CupertinoIcons.add),
          onPressed: () {
            setState(() {
              //storage
              if (type == 0) {
                _storageLines = [..._storageLines, _line(0)];
              }
              //profile
              else {
                _profileLines = [..._profileLines, _line(1)];
              }
            });
          },
        ),
      ),
    );
  }

  _alert(type) {
    return AlertDialog(
      title: const Text('Uyarı'),
      content: type == 0
          ? const Text('Eksik Stok Bilgisi!')
          : const Text('Eksik Profil Bilgisi!'),
      actions: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              _warning = false;
            });
          },
          child: const Text('Tamam'),
        )
      ],
    );
  }
}