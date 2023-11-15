import 'package:appflowy_editor/appflowy_editor.dart';

import 'character_shortcuts/character_shortcuts.dart';
import 'command_shortcuts/command_shortcuts.dart';

/// Collection of all the Character Shortcut Events in Codeblock
final List<CharacterShortcutEvent> codeBlockCharacterEvents = [
  ...bracesInCodeblock,
  enterInCodeBlock,
  ...ignoreKeysInCodeBlock,
  ...ignoreBracesInCodeblock,
];

/// Collection of all the Command Shortcut Events in Codeblock
final List<CommandShortcutEvent> codeBlockCommandEvents = [
  insertNewParagraphNextToCodeBlockCommand,
  ...navigationShortcutsInCodeblock,
  pasteInCodeblock,
  selectAllInCodeBlockCommand,
  tabToInsertSpacesInCodeBlockCommand,
  tabToDeleteSpacesInCodeBlockCommand,
];
