import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:toast/toast.dart';
import '../BluetoothDeviceListEntry.dart';
import 'package:altto_app/components/globals.dart' as globals;
// import 'dart:mirrors';
import 'dart:convert'; // to use ASCII

class DiscoveryPage extends StatefulWidget {
  /// If true, discovery starts on page start, otherwise user must press action button.
  final bool start;

  const DiscoveryPage({this.start = true});

  @override
  _DiscoveryPage createState() => new _DiscoveryPage();
}

class _DiscoveryPage extends State<DiscoveryPage> {
  StreamSubscription<BluetoothDiscoveryResult> _streamSubscription;
  List<BluetoothDiscoveryResult> results = List<BluetoothDiscoveryResult>();
  bool isDiscovering;

  _DiscoveryPage();

  @override
  void initState() {
    super.initState();

    isDiscovering = widget.start;
    if (isDiscovering) {
      _startDiscovery();
    }
  }

  void _restartDiscovery() {
    setState(() {
      results.clear();
      isDiscovering = true;
    });

    _startDiscovery();
  }

  void _startDiscovery() {
    _streamSubscription = FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      setState(() { results.add(r); });
    });

    _streamSubscription.onDone(() {
      setState(() { isDiscovering = false; });
    });
  }

  // @TODO . One day there should be `_pairDevice` on long tap on something... ;)

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and cancel discovery
    _streamSubscription?.cancel();

    super.dispose();
  }

  // @TODO review flutter_bluetooth_serial original code for connection protocol

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isDiscovering ? Text('Procurando Dispositivos') : Text('Dispositivos encontrados'),
        actions: <Widget>[
          (
            isDiscovering ?
              FittedBox(child: Container(
                margin: new EdgeInsets.all(16.0),
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
              ))
            :
              IconButton(
                icon: Icon(Icons.replay),
                onPressed: _restartDiscovery
              )
          )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children:  [
                Text("Comunicação: "),
                Text(""),
                Text("Wi-Fi"),
                Switch(
                  value: globals.using_bluetooth,
                  onChanged: (value) {
                    globals.using_bluetooth = value;
                  },
                ),
                Text("Bluetooth"),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            Expanded (
              child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (BuildContext context, index) {
                  BluetoothDiscoveryResult result = results[index];
                  return BluetoothDeviceListEntry(
                      device: result.device,
                      rssi: result.rssi,
                      onTap: () async {
                        try {
                          globals.connection = await BluetoothConnection.toAddress(result.device.address); // Create connection
                          Toast.show("Dispositivo Conectado", context);
                          globals.connection.input.listen((List<int> data) {
                            Toast.show('ASCII Data: ${ascii.decode(data)}', context);
                            globals.connection.output.add(ascii.encode('string')); // Write to the bluetooth device

                            if (ascii.decode(data).contains('!')) {
                              globals.connection.finish(); // Finish connection
                              Toast.show('Desconectado por dispositivo local', context);
                            }
                          }).onDone(() {
                            Toast.show('Desconectado por dispositivo remoto', context);
                          });
                        }
                        catch (exception) {
                          Toast.show('Erro ao conectar: ${exception}', context, duration: 5*Toast.LENGTH_LONG);
                        }

                        Navigator.of(context).pop(result.device);
                      },
                      onLongPress: () async {
                        try {
                          bool bonded = false;
                          if (result.device.isBonded) {
                            print('Desconectando com ${result.device.address}...');
                            await FlutterBluetoothSerial.instance.removeDeviceBondWithAddress(result.device.address);
                            print('Desconectado de ${result.device.address}!');
                          }
                          else {
                            print('Conectando com ${result.device.address}...');
                            bonded = await FlutterBluetoothSerial.instance.bondDeviceAtAddress(result.device.address);
                            print('Conexão com ${result.device.address} ${bonded ? 'realizada com sucesso' : 'falhou!'}.');
                          }
                          setState(() {
                            results[results.indexOf(result)] = BluetoothDiscoveryResult(
                                device: BluetoothDevice(
                                  name: result.device.name ?? '',
                                  address: result.device.address,
                                  type: result.device.type,
                                  bondState: bonded ? BluetoothBondState.bonded : BluetoothBondState.none,
                                ),
                                rssi: result.rssi
                            );
                          });
                        }
                        catch (ex) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Erro ao conectar'),
                                content: Text("${ex.toString()}"),
                                actions: <Widget>[
                                  new FlatButton(
                                    child: new Text("Fechar"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                  );
                },
            ),
            )
        ],
      )
    ),
    );
  }
}
