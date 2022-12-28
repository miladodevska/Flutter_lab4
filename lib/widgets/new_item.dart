import 'package:lab3_193059/model/list_item.dart';
import 'package:flutter/material.dart';
import 'package:nanoid/nanoid.dart';
import 'package:flutter/widgets.dart';

class NovoPolaganje extends StatefulWidget {
  final Function addPolaganje;

  NovoPolaganje(this.addPolaganje);

  @override
  State<StatefulWidget> createState() => _NovoPolaganjeState();
}

class _NovoPolaganjeState extends State<NovoPolaganje> {
  final _imeNaPredmetController = TextEditingController();
  final _datumVremeController = TextEditingController();


  void _submitData() {
    if (_imeNaPredmetController.text.isEmpty || _datumVremeController.text.isEmpty) {
      return;
    }

    int datum = '-'.allMatches(_datumVremeController.text).length;
    int vreme = ':'.allMatches(_datumVremeController.text).length;

    if(_datumVremeController.text.length < 16 || datum != 2 || vreme != 1){
      print("Date format is invalid!");
      return;
    }

    final String vnesenoImeNaPredmet = _imeNaPredmetController.text;
    final String vnesenDatumIVreme = _datumVremeController.text + ':00';
    DateTime dateTime = DateTime.parse(vnesenDatumIVreme);

    final newExam = ListKolokviumi(
        id: nanoid(5),
        imeNaPredmet: vnesenoImeNaPredmet,
        datumVreme: dateTime);
      widget.addPolaganje(newExam);
      Navigator.of(context).pop();
    }



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          TextField(
            controller: _imeNaPredmetController,
            decoration: InputDecoration(labelText: "Name of the subject"),
            onSubmitted: (_) => _submitData(),
          ),
          TextField(
            controller: _datumVremeController,
            decoration: InputDecoration(
                labelText: "Date and time, format: 2022-01-01 15:00"),
            onSubmitted: (_) => _submitData(),
          ),
          TextButton(child: Text("Add new"), onPressed: _submitData
          ),
        ],
      ),
    );
  }
}
