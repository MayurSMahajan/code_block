import 'package:appflowy_editor/appflowy_editor.dart';

import 'character_shortcuts/character_shortcuts.dart';
import 'command_shortcuts/command_shortcuts.dart';

final List<CharacterShortcutEvent> codeBlockCharacterEvents = [
  ...bracesInCodeblock,
  enterInCodeBlock,
  ...ignoreKeysInCodeBlock,
];

final List<CommandShortcutEvent> codeBlockCommandEvents = [
  insertNewParagraphNextToCodeBlockCommand,
  pasteInCodeblock,
  selectAllInCodeBlockCommand,
  tabToInsertSpacesInCodeBlockCommand,
  tabToDeleteSpacesInCodeBlockCommand,
];
