import 'package:bonfire/features/messaging/views/components/box/content/attachment/components/audio_player.dart';
import 'package:bonfire/features/messaging/views/components/box/content/attachment/components/downloader.dart';
import 'package:bonfire/features/messaging/views/components/box/content/attachment/components/image.dart';
import 'package:bonfire/features/messaging/views/components/box/content/attachment/components/desktop_video.dart';
import 'package:bonfire/features/messaging/views/components/box/content/attachment/components/mobile_video.dart';
import 'package:firebridge/firebridge.dart';
import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

class AttachmentWidget extends StatefulWidget {
  final Attachment attachment;
  const AttachmentWidget({super.key, required this.attachment});

  @override
  State<AttachmentWidget> createState() => _AttachmentWidgetState();
}

class _AttachmentWidgetState extends State<AttachmentWidget> {
  @override
  Widget build(BuildContext context) {
    // String contentType = widget.attachment.contentType? ?? "other";
    // print(widget.attachment.contentType!.split("/")[0]);
    String contentType = widget.attachment.contentType?.split("/")[0] ?? "";
    if (contentType == "audio") {
      return AudioAttachment(attachment: widget.attachment);
    }

    if (contentType == "image") {
      return ImageAttachment(attachment: widget.attachment);
    }

    // it's wayyy too laggy on mobile for some reason
    if (contentType == "video") {
      if (UniversalPlatform.isDesktopOrWeb) {
        return DesktopVideoAttachment(attachment: widget.attachment);
      } else {
        return MobileVideoAttachment(attachment: widget.attachment);
      }
    }

    return DownloadAttachment(attachment: widget.attachment);
  }
}
