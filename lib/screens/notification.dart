import 'package:ecommerce_1/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final List<Map<String, String>> notifications = [
    {
      'sender': 'Admin',
      'message': 'Your order has been shipped!',
      'date': '2023-03-01',
      'time': '10:30 AM',
    },
    {
      'sender': 'Support',
      'message': 'Your ticket has been resolved.',
      'date': '2023-03-02',
      'time': '02:15 PM',
    },
    {
      'sender': 'Promo',
      'message': 'Get 20% off on your next purchase!',
      'date': '2023-03-03',
      'time': '09:00 AM',
    },
  ];
  late NavigationService _navigationService;
  final GetIt _getIt = GetIt.instance;
  @override
  void initState() {
    super.initState();
    _navigationService = _getIt<NavigationService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            _navigationService.goBack();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notification_important),
            onPressed: () {
              _navigationService.pushReplacedNamed("/notifications");
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(notification['sender'] ?? ''),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notification['message'] ?? ''),
                  const SizedBox(height: 4),
                  Text(
                    '${notification['date']} at ${notification['time']}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.check),
                    onPressed: () {
                      // Handle action button press
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      // Handle delete button press
                    },
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
