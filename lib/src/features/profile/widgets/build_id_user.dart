import 'package:chatapp/src/l10n/app_localizations.dart';
import 'package:chatapp/src/theme/font_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IdUserWidget extends StatelessWidget {
  final String showId;

  const IdUserWidget({
    super.key,
    required this.showId,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SelectableText(
          'ID: $showId',
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        IconButton(
          onPressed: () async {
            await _copyID(context);
          },
          icon: const Icon(Icons.copy),
        )
      ],
    );
  }

  Future<void> _copyID(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: showId)).then(
      (value) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(milliseconds: 500),
          backgroundColor: Colors.white,
          content: Center(
            child: Text(
              AppLocalizations.of(context)!.copiedId,
              style: FontTheme.mineShaft15W500RobotoMono,
            ),
          ),
        ),
      ),
    );
  }
}
