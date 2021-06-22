import 'package:flutter/material.dart';

import '../list_of_conversation.dart';

class MeChatsTab extends StatelessWidget {
  static const routeName = '/conversation_tab';

  @override
  Widget build(BuildContext context) {
    return ListOfConversation();
  }
}
