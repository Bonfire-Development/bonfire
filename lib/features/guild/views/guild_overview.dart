import 'dart:math';

import 'package:bonfire/theme/text_theme.dart';
import 'package:bonfire/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bonfire/features/guild/controllers/current_guild.dart';

class GuildOverview extends ConsumerStatefulWidget {
  const GuildOverview({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GuildOverviewState();
}

class _GuildOverviewState extends ConsumerState<GuildOverview> {
  @override
  Widget build(BuildContext context) {
    var currentGuild = ref.watch(currentGuildControllerProvider);
    String guildTitle = currentGuild?.name ?? "Not in a server";

    return Padding(
      padding: const EdgeInsets.only(right: 30.0),
      child: SizedBox(
          width: double.infinity,
          child: Container(
            height: 60,
            decoration: BoxDecoration(
                color: Theme.of(context).custom.colorTheme.foreground,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30), topRight: Radius.circular(8)),
                border: Border(
                    bottom: BorderSide(
                        color:
                            Theme.of(context).custom.colorTheme.brightestGray,
                        width: 1.0))),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      guildTitle,
                      style: CustomTextTheme().titleSmall.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                  Transform.rotate(
                      angle: pi / 2,
                      child: const Icon(Icons.expand_less_rounded))
                ],
              ),
            ),
          )),
    );
  }
}
