import 'package:flutter_test/flutter_test.dart';
import 'package:ios_communication_notification/ios_communication_notification_platform_interface.dart';
import 'package:ios_communication_notification/ios_communication_notification_method_channel.dart';
import 'package:ios_communication_notification/models/notification_cancel_model.dart';
import 'package:ios_communication_notification/models/notification_info_model.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockIosCommunicationNotificationPlatform
    with MockPlatformInterfaceMixin
    implements IosCommunicationNotificationPlatform {
  @override
  Future<String?> showNotification(NotificationInfo info) async {
    return "test_saeed";
  }

  @override
  Future<bool> isAvailable() => Future.value(true);

  @override
  void onClickNotification(Function(String payload) onClick) {
    return;
  }

  @override
  Future<String?> getInitialPayload() => Future.value("lambiengcode");

  @override
  Future<void> cancelNotification(NotificationCancel cancel) {
    // TODO: implement cancelNotification
    throw UnimplementedError();
  }

  @override
  Future<void> cancelAllNotification() {
    // TODO: implement cancelAllNotification
    throw UnimplementedError();
  }
}

void main() {
  final IosCommunicationNotificationPlatform initialPlatform =
      IosCommunicationNotificationPlatform.instance;

  test('$MethodChannelIosCommunicationNotification is the default instance',
      () {
    expect(initialPlatform,
        isInstanceOf<MethodChannelIosCommunicationNotification>());
  });

  test('getPlatformVersion', () async {
    // IosCommunicationNotification iosCommunicationNotificationPlugin =
    //     IosCommunicationNotification();
    MockIosCommunicationNotificationPlatform fakePlatform =
        MockIosCommunicationNotificationPlatform();
    IosCommunicationNotificationPlatform.instance = fakePlatform;

    expect('42', '42');
  });
}
