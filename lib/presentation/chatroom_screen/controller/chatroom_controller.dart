import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:volco/core/utils/supabase_handler.dart';
import 'package:volco/presentation/chatroom_screen/models/chatroom_model.dart';

class ChatroomController extends GetxController {
  var isLoading = true.obs;
  late int eventId; // Made nullable so we can check it
  User? user;
  RxBool isUserisRegistered = false.obs;
  var messages = <ChatMessage>[].obs;
  var messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final SupabaseClient supabaseClient = SupabaseHandler().supabaseClient;
  final SupabaseService supabaseService = SupabaseService();

  @override
  void onInit() async {
    super.onInit();
    await _fetchUserDetails();
    // Do not call subscribeToMessages here because eventId is still null.
    fetchMessages(); // This might return empty until eventId is set.
    messages.listen((_) => scrollToBottom());
    isLoading.value = false;
  }

  /// Fetch messages for this chatroom
  Future<void> fetchMessages() async {
    if (eventId == null) {
      print("Event ID is not set. Skipping fetchMessages.");
      return;
    }
    isLoading.value = true;
    try {
      final response = await supabaseClient
          .from('messages')
          .select(
          'message_id, chatroom_id, sender_id, sender_name, message, created_at')
          .eq('chatroom_id', eventId)
          .order('created_at', ascending: true);

      messages.assignAll(
          response.map((json) => ChatMessage.fromJson(json)).toList());

      // Scroll to bottom after messages are loaded
      Future.delayed(Duration(milliseconds: 300), () {
        scrollToBottom();
      });
    } catch (e) {
      print('Error fetching messages: $e');
    } finally {
      isLoading.value = false;
    }
  }
  /// Send a new message
  Future<void> sendMessage() async {
    if (messageController.text.trim().isEmpty) return;
    if (user?.id == null) return;

    final senderId = user!.id;
    final senderName = user?.userMetadata?['full_name'] ?? 'Unknown';

    try {
      await supabaseClient.from('messages').insert({
        'chatroom_id': eventId,
        'sender_id': senderId,
        'sender_name': senderName,
        'message': messageController.text.trim(),
      });
      messageController.clear();

      // Scroll to bottom after a small delay
      Future.delayed(Duration(milliseconds: 300), () {
        scrollToBottom();
      });
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  /// Subscribe to real-time message updates.
  void subscribeToMessages() {
    if (eventId == null) {
      print("Event ID is null, cannot subscribe to messages.");
      return;
    }
    supabaseClient
        .from('messages')
        .stream(primaryKey: ['message_id'])
        .eq('chatroom_id', eventId)
        .order('created_at', ascending: true)
        .listen((data) {
      messages.assignAll(
          data.map((json) => ChatMessage.fromJson(json)).toList());

      // Ensure we scroll down when new messages arrive
      Future.delayed(Duration(milliseconds: 300), () {
        scrollToBottom();
      });
    });
  }

  /// Set event ID and subscribe to messages afterwards.
  void seteventId(int id) {
    eventId = id;
    subscribeToMessages(); // Now that eventId is set, subscribe.
    fetchMessages(); // Optionally, fetch messages immediately.
  }

  Future<void> _fetchUserDetails() async {
    try {
      user = await SupabaseService().getUserData();
      if (user != null) {
        print('User metadata: ${user?.userMetadata}');
      }
    } catch (error) {
      print('Error fetching user details: $error');
    }
  }

  void scrollToBottom() {
    if (scrollController.hasClients) {
      Future.delayed(Duration(milliseconds: 100), () {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 150),
          curve: Curves.easeOut,
        );
      });
    }
  }
  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
