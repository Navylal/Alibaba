import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notification Page')),
      body: Center(
        child: Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...controller.notifications
                    .map((msg) => Text(msg, style: const TextStyle(fontSize: 16)))
                    .toList(),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.addNotification('New Notification!'),
                  child: const Text('Add Notification'),
                ),
              ],
            )),
      ),
    );
  }
}
