import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class LogService {
  final DatabaseReference _logRef = FirebaseDatabase.instance.ref('logs'); // Reference to the 'logs' node

  // Function to add a log entry
  Future<void> addLog(String message) async {
    try {
      final logEntry = {
        'timestamp': DateTime.now().toIso8601String(), // Current timestamp
        'message': message,
      };

      await _logRef.push().set(logEntry); // Push the log to Firebase
      print('Log added successfully: $message');
    } catch (e) {
      print('Failed to add log: $e');
    }
  }

  // Function to fetch all logs
  Future<List<Map<String, dynamic>>> fetchLogs() async {
    try {
      final snapshot = await _logRef.get(); // Get all logs from Firebase
      if (snapshot.exists) {
        List<Map<String, dynamic>> logs = [];
        Map<String, dynamic> response = Map<String, dynamic>.from(snapshot.value as Map);

        response.forEach((key, value) {
          logs.add(Map<String, dynamic>.from(value));
        });

        return logs;
      }
    } catch (e) {
      print('Failed to fetch logs: $e');
    }

    return [];
  }
}

class LogsPage extends StatefulWidget {
  const LogsPage({Key? key}) : super(key: key);

  @override
  _LogsPageState createState() => _LogsPageState();
}

class _LogsPageState extends State<LogsPage> {
  final LogService _logService = LogService();

  late Future<List<Map<String, dynamic>>> _logsFuture;

  @override
  void initState() {
    super.initState();
    _logsFuture = _logService.fetchLogs(); // Initial fetching of logs
  }

  // Method to refresh the logs
  Future<void> _refreshLogs() async {
    setState(() {
      _logsFuture = _logService.fetchLogs(); // Fetch logs again
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logs'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshLogs,
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _logsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error loading logs'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No logs found'));
            }

            final logs = snapshot.data!;

            return ListView.builder(
              itemCount: logs.length,
              itemBuilder: (context, index) {
                final log = logs[index];
                final timestamp = log['timestamp'];
                final message = log['message'];

                return ListTile(
                  title: Text(message),
                  subtitle: Text(timestamp),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
