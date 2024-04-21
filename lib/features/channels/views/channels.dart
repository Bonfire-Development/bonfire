import 'package:bonfire/features/channels/repositories/channels.dart';
import 'package:bonfire/shared/models/channel.dart';
import 'package:bonfire/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChannelsList extends ConsumerStatefulWidget {
  const ChannelsList({super.key});

  @override
  ConsumerState<ChannelsList> createState() => _ChannelsListState();
}

class _ChannelsListState extends ConsumerState<ChannelsList> {
  @override
  Widget build(BuildContext context) {
    var topPadding = MediaQuery.of(context).padding.top;
    var channelWatch = ref.watch(channelsProvider);

    var channels = channelWatch.valueOrNull ?? [];

    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(36)),
            color: Theme.of(context).custom.colorTheme.foreground),
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 12),
          itemCount: channels.length,
          itemBuilder: (context, index) {
            return (channels[index].type != BonfireChannelType.guildCategory)
                ? ChannelButton(name: channels[index].name)
                : Text(channels[index].name);
            ;
          },
        ),
      ),
    );
  }
}

class ChannelButton extends StatefulWidget {
  String name;
  ChannelButton({super.key, required this.name});

  @override
  State<ChannelButton> createState() => _ChannelButtonState();
}

class _ChannelButtonState extends State<ChannelButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2, left: 8, right: 30),
      child: SizedBox(
        width: double.infinity,
        height: 35,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            minimumSize: Size.zero,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            foregroundColor: Theme.of(context).custom.colorTheme.textColor1,
            backgroundColor: Theme.of(context).custom.colorTheme.cardSelected,
          ),
          onPressed: () {},
          child: SizedBox(
            height: 35,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(widget.name,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).custom.textTheme.bodyText2),
              ),
            ),
          ),
        ),
      ),
    );
  }
}