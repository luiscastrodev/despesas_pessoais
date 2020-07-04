import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate;

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

 

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).viewInsets.bottom;
    print( "printlll $size" );
     return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 205,
          ),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Titulo',
                  prefixIcon: Icon(Icons.title),
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: _valueController,
                decoration: InputDecoration(
                  labelText: 'Valor',
                  prefixIcon: Icon(Icons.monetization_on),
                ),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Text(_selectedDate == null
                        ? 'Nenhuma Data selecionada'
                        : DateFormat('dd/MM/y').format(_selectedDate)),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: _showDatePicker,
                      child: Text(
                        'Selecionar Data',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: RaisedButton(
                  onPressed: () {
                    print(_titleController.text);
                    print(_valueController.text);
                    widget.onSubmit(
                      _titleController.text,
                      double.parse(_valueController.text),
                      _selectedDate,
                    );
                  },
                  child: Text(
                    'Nova Transação',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).buttonColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
