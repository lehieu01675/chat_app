import 'package:chatapp/src/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShowIDWidget extends StatelessWidget {
  final bool isSearch;
  final List<UserModel> searchListContactUser;
  final List<UserModel> listContactUser;
  final int index;

  const ShowIDWidget({
    super.key,
    required this.isSearch,
    required this.searchListContactUser,
    required this.index,
    required this.listContactUser,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SelectableText(
          'ID: ${isSearch ? searchListContactUser[index].checkId : listContactUser[index].checkId}',
          style: const TextStyle(fontSize: 12),
        ),
        InkWell(
          onTap: () async {
            await Clipboard.setData(ClipboardData(
                    text: isSearch
                        ? searchListContactUser[index].checkId
                        : listContactUser[index].checkId))
                .then(
              (value) => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.black54,
                  content: Center(
                    child: Text(
                      'ID copied',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ),
            );
          },
          child: const Icon(Icons.copy, size: 20),
        )
      ],
    );
  }
}
