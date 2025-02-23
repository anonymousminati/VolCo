import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/image_constant.dart';
import 'package:volco/presentation/chatroom_screen/controller/chatroom_controller.dart';
import 'package:volco/presentation/chatroom_screen/models/chatroom_model.dart';
import 'package:volco/presentation/event_description_screen/controller/event_description_controller.dart';
import 'package:volco/presentation/event_description_screen/widgets/eventDescriptionField.dart';
import 'package:volco/widgets/custom_image_view.dart';

class ChatroomScreen extends GetView<ChatroomController> {
  final int eventId;

  ChatroomScreen({
    Key? key,
    required this.eventId,

  }) : super(key: key){
    controller.seteventId(eventId);
    controller.onInit();
  }

  /// This function builds extra fields based on the category.

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              backgroundColor: appTheme.gray900,
              leading: CustomImageView(
                imagePath: ImageConstant.imgArrowLeft,
                // height: 28.h,
                width: 20.h,
                onTap: () => Get.back(),
              ),
            ),
            body: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              return Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 24.h, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 20.h,
                  children: [
                    // Back Arrow


                    Expanded(
                      child: Obx(() {
                        if (controller.isLoading.value) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (controller.messages.isEmpty) {
                          return Center(child: Text("No messages yet."));
                        }

                        return ListView.builder(
                          itemCount: controller.messages.length,
                          itemBuilder: (context, index) {
                            final message = controller.messages[index];
                            return _buildChatBubble(message, controller);
                          },
                        );
                      }),
                    ),
                    _buildMessageInput(),
                  ],
                ),
              );
            }),
          ),
          onRefresh: ()async {
            print("Refreshed") ;

          }),
    );
  }

  /// Chat bubble UI
  Widget _buildChatBubble(ChatMessage message, ChatroomController controller) {
    final bool isMe = message.senderId == controller.user?.id;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMe) ...[
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.amber,
              child: Text(
                message.senderName[0].toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(width: 8),
          ],
          Flexible(
            child: IntrinsicWidth(
              child: IntrinsicHeight(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: isMe ? Colors.blueAccent : Colors.grey[300],
                    gradient: isMe
                        ? LinearGradient(colors: [Colors.blue, Colors.blueAccent])
                        : null,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                      bottomLeft: isMe ? Radius.circular(12) : Radius.zero,
                      bottomRight: isMe ? Radius.zero : Radius.circular(12),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min, // Wrap content tightly
                    children: [
                      if (!isMe)
                        Text(
                          message.senderName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      SizedBox(height: 4),
                      Text(
                        message.message,
                        style: TextStyle(color: isMe ? Colors.white : Colors.black),
                      ),
                      SizedBox(height: 4),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          _formatTime(message.createdAt),
                          style: TextStyle(
                            fontSize: 10,
                            color: isMe ? Colors.white70 : Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (isMe) SizedBox(width: 8),
        ],
      ),
    );
  }

  /// Helper function to format time as "hh:mm AM/PM"
  String _formatTime(DateTime time) {
    return "${time.hour % 12 == 0 ? 12 : time.hour % 12}:${time.minute.toString().padLeft(2, '0')} ${time.hour >= 12 ? 'PM' : 'AM'}";
  }

  /// Message input field
  Widget _buildMessageInput() {
    return Container(

      child: Row(
        spacing:20.h ,
        children: [
          Expanded(
            child: CustomTextFormField(
              controller: controller.messageController,
              hintText: 'Type a message...',

            )
          ),
          CustomImageView(
            imagePath: ImageConstant.sendIconimg,
            height: 30.h,
            width: 30.h,
            onTap: (){
              controller.sendMessage();
            },
          ),
        ],
      ),
    );
  }
}
