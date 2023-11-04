<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

## Our Goal

The goal of this project is to develop a Code Block in Flutter as a standalone package that AppFlowy and other Flutter applications can use. Code Block is a feature that allows you to write and display code snippets.

## Features

- [x] Syntax Highlighting
- [x] Multiple Programming Language Support
- [x] Copy All Code
- [x] Paste Multiple lines of code
- [x] Export code
- [x] Import code
- [x] Cool Dark and Light Theme
- [ ] Copy the entire Code Block 
- [ ] Line numbering
- [ ] Auto-Indentation

## Getting started

To use this package you need a project with [AppFlowy Editor](https://github.com/AppFlowy-IO/appflowy-editor).

## Usage

1. Import the package:

```dart
import 'package:code_block/code_block.dart';
```

2. Add Codeblock item to Selection Menu Items of AppFlowyEditor:

```dart
late final List<SelectionMenuItem> slashMenuItems = [
    ...standardSelectionMenuItems,
    codeBlockItem,
];
```

3. Add Codeblock shortcuts to AppFlowy Editor Shortcuts:

```dart
List<CharacterShortcutEvent> get characterShortcutEvents => [
        // code block
        ...codeBlockCharacterEvents,

        // customize the slash menu command
        customSlashCommand(
          slashMenuItems,
        ),

        ...standardCharacterShortcutEvents
          ..removeWhere(
            (element) => element == slashCommand,
          ), // remove the default slash command.
      ];

  final List<CommandShortcutEvent> commandShortcutEvents = [
    ...codeBlockCommandEvents,
    ...standardCommandShortcutEvents,
  ];

```

> It is important that you customize the slash menu command, this way you will be able to add Codeblock Item to the Selection Menu Items.

4. Add `CodeblockComponentBuilder` to AppFlowy Editor's Block Component Builder Map.

```dart
final customBlockComponentBuilderMap = {
    CodeBlockKeys.type: CodeBlockComponentBuilder(
      editorState: editorState,
    ),
  };

  final builders = {
    ...standardBlockComponentBuilderMap,
    ...customBlockComponentBuilderMap,
  };
```

5. Make sure you pass the shortcuts and blockComponentBuilderMap to AppFlowyEditor class.

```dart
// gets the block component builder map from a method
blockComponentBuilders = customBlockComponentBuilderMap();

AppFlowyEditor(
      editorState: editorState,
      autoFocus: true,
      characterShortcutEvents: characterShortcutEvents,
      commandShortcutEvents: commandShortcutEvents,
      blockComponentBuilders: blockComponentBuilders,
    );

```

6. That's it, check out your codeblock in action by pressing the slash menu in your editor page and selecting the Codeblock option.

## Additional information

Find out more about this here:
 https://appflowy.gitbook.io/docs/essential-documentation/contribute-to-appflowy/appflowy-mentorship-program/mentorship-2022/mentee-projects/code-block
