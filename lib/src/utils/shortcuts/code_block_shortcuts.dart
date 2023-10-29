import 'package:appflowy_editor/appflowy_editor.dart';

import 'character_shortcuts/character_shortcuts.dart';
import 'command_shortcuts/command_shortcuts.dart';

final List<CharacterShortcutEvent> codeBlockCharacterEvents = [
  ...bracesInCodeblock,
  enterInCodeBlock,
  ...ignoreKeysInCodeBlock,
  ...ignoreBracesInCodeblock,
];

final List<CommandShortcutEvent> codeBlockCommandEvents = [
  insertNewParagraphNextToCodeBlockCommand,
  ...navigationShortcutsInCodeblock,
  pasteInCodeblock,
  selectAllInCodeBlockCommand,
  tabToInsertSpacesInCodeBlockCommand,
  tabToDeleteSpacesInCodeBlockCommand,
];
