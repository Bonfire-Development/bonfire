import 'package:bonfire/features/guild/repositories/member.dart';
import 'package:bonfire/features/messaging/views/components/avatar.dart';
import 'package:bonfire/features/messaging/views/embed.dart';
import 'package:bonfire/shared/utils/role_color.dart';
import 'package:bonfire/theme/theme.dart';
import 'package:firebridge/firebridge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prism/flutter_prism.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markdown_viewer/markdown_viewer.dart';
import 'package:url_launcher/url_launcher.dart';

class MessageBox extends ConsumerStatefulWidget {
  Message? message;
  bool showSenderInfo = true;
  Logger logger = Logger("MessageBox");
  MessageBox({super.key});

  @override
  ConsumerState<MessageBox> createState() => _MessageBoxState();

  void setMessage(Message message) {
    this.message = message;
  }

  void setShowSenderInfo(bool showSenderInfo) {
    this.showSenderInfo = showSenderInfo;
  }
}

class _MessageBoxState extends ConsumerState<MessageBox> {
  String dateTimeFormat(DateTime time) {
    String section1;
    String section2;

    if (time.day == DateTime.now().day) {
      section1 = 'Today';
    } else if (time.day == DateTime.now().day - 1) {
      section1 = 'Yesterday';
    } else {
      section1 = '${time.month}/${time.day}/${time.year}';
    }

    var twelveHour = time.hour > 12 ? time.hour - 12 : time.hour;
    var section3 = time.hour > 12 ? 'PM' : 'AM';

    if (twelveHour == 0) {
      twelveHour = 12;
    }

    section2 = ' at $twelveHour:${time.minute} $section3';

    if (time.minute < 10) {
      section2 = ' at $twelveHour:0${time.minute} $section3';
    }

    return section1 + section2;
  }

  void launchCustomUrl(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      print('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var embeds = widget.message!.embeds;

    String name = widget.message!.author.username;

    Color textColor = Colors.white;

    var member = ref.watch(getMemberProvider(widget.message!.author.id));
    var roles = ref.watch(getGuildRolesProvider).valueOrNull ?? [];

    String? roleIconUrl;

    member.when(
      data: (member) {
        name = member?.nick ?? member?.user?.globalName ?? name;
        textColor = getRoleColor(member!, roles as List<Role>);
        roleIconUrl = getRoleIconUrl(member, roles);
      },
      loading: () {},
      error: (error, stack) {},
    );

    return Column(
      children: [
        SizedBox(
          height: widget.showSenderInfo ? 16 : 0,
        ),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            side: const BorderSide(
              color: Color.fromARGB(0, 255, 255, 255),
              width: 0.5,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (widget.showSenderInfo == true)
                  ? Avatar(
                      key: Key(widget.message!.author.avatarHash ?? ""),
                      author: widget.message!.author)
                  : const Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: SizedBox(
                        width: 45,
                      ),
                    ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.showSenderInfo
                      ? SizedBox(
                          width: width - 100,
                          child: Wrap(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(left: 6),
                                  child: Text(
                                    name,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                              // emoji
                              if (roleIconUrl != null)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 6, top: 2),
                                  child: Image.network(
                                    roleIconUrl!,
                                    width: 22,
                                    height: 22,
                                  ),
                                ),
                              Padding(
                                // I dislike the top padding, should fix alignment
                                padding: const EdgeInsets.only(left: 6, top: 4),
                                child: Text(
                                  dateTimeFormat(
                                      widget.message!.timestamp.toLocal()),
                                  textAlign: TextAlign.left,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                  style: const TextStyle(
                                    color: Color.fromARGB(189, 255, 255, 255),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                  Padding(
                    padding: const EdgeInsets.only(left: 6, top: 0),
                    child: SizedBox(
                      width: width - 105,
                      child: MarkdownViewer(
                        widget.message!.content,
                        enableTaskList: true,
                        enableSuperscript: false,
                        enableSubscript: false,
                        enableFootnote: false,
                        enableImageSize: false,
                        selectable: false,
                        enableKbd: false,
                        syntaxExtensions: const [],
                        elementBuilders: const [],
                        highlightBuilder: (text, language, infoString) {
                          final prism = Prism(
                              style: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? const PrismStyle.dark()
                                  : const PrismStyle());

                          try {
                            var rendered =
                                prism.render(text, language ?? 'plain');
                            return rendered;
                          } catch (e) {
                            // fixes grammar issue?
                            return <TextSpan>[TextSpan(text: text)];
                          }
                        },
                        onTapLink: (href, title) {
                          print("Tapped link: $href");
                          launchUrl(Uri.parse(href!),
                              mode: LaunchMode.externalApplication);
                        },
                        styleSheet: MarkdownStyle(
                          paragraph:
                              Theme.of(context).custom.textTheme.bodyText1,
                          codeBlock:
                              Theme.of(context).custom.textTheme.bodyText1,
                          codeblockDecoration: BoxDecoration(
                              color: Theme.of(context)
                                  .custom
                                  .colorTheme
                                  .foreground,
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                  ),
                  // add per embed
                  for (var embed in embeds)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: EmbedWidget(
                        embed: embed,
                      ),
                    )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
