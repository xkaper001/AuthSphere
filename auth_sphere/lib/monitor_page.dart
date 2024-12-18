import 'dart:developer';

import 'package:auth_sphere/response.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MonitorPage extends StatefulWidget {
  const MonitorPage({super.key});

  @override
  State<MonitorPage> createState() => _MonitorState();
}

class _MonitorState extends State<MonitorPage> {
  late WebSocketChannel _channel;
  List<String> fileUpdates = [];

  @override
  void initState() {
    super.initState();
    _channel = WebSocketChannel.connect(Uri.parse("ws://localhost:8000/ws"));
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late IconData icon;
    late Color color;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Monitoring the website',
          style: TextStyle(color: Colors.white, fontSize: 36),
        ),
        const SizedBox(
          height: 48,
        ),
        const SizedBox(height: 10),
        Expanded(
          child: StreamBuilder(
            stream: _channel.stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Connecting...");
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else if (snapshot.hasData) {
                fileUpdates.add(snapshot.data.toString());
              }

              return ListView.builder(
                itemCount: fileUpdates.length,
                itemBuilder: (context, index) {
                  final res = Response.fromJson(fileUpdates[index]);
                  switch (res.eventType) {
                    case "auth_failure":
                      log("File updated: ${res.details}");
                      icon = Icons.error_rounded;
                      color = Colors.amber;
                      break;
                    case "auth_failure_multiple":
                      log("File deleted: ${res.details}");
                      icon = Icons.warning_rounded;
                      color = Colors.red;
                      break;
                    case "auth_success":
                      log("File created: ${res.details}");
                      icon = Icons.info;
                      color = Colors.grey;
                      break;
                    default:
                      log("Unknown event: ${res.eventType}");
                  }
                  log(res.toString());
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      tileColor: color,
                      iconColor: Colors.black,
                      leading: Icon(icon),
                      title: Text(
                        res.eventType,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "${res.details} from IP ${res.ipAddress}",
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        FilledButton(
          onPressed: () {},
          style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.white),
            padding: WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
          child: const Text(
            "Stop",
            style: TextStyle(color: Colors.black, fontSize: 24),
          ),
        )
      ],
    );
  }
}
