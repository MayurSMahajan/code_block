import 'package:highlight/languages/all.dart';

/// List of all the supported languages in Codeblock
final supportedLanguages = [
  'Assembly',
  'Bash',
  'BASIC',
  'C',
  'C#',
  'CPP',
  'Clojure',
  'CS',
  'CSS',
  'Dart',
  'Docker',
  'Elixir',
  'Elm',
  'Erlang',
  'Fortran',
  'Go',
  'GraphQL',
  'Haskell',
  'HTML',
  'Java',
  'JavaScript',
  'JSON',
  'Kotlin',
  'LaTeX',
  'Lisp',
  'Lua',
  'Markdown',
  'MATLAB',
  'Objective-C',
  'OCaml',
  'Perl',
  'PHP',
  'PowerShell',
  'Python',
  'R',
  'Ruby',
  'Rust',
  'Scala',
  'Shell',
  'SQL',
  'Swift',
  'TypeScript',
  'Visual Basic',
  'XML',
  'YAML',
];

/// A filtered version of `supportedLanguages`
final languages = supportedLanguages
    .map((e) => e.toLowerCase())
    .toSet()
    .intersection(allLanguages.keys.toSet())
    .toList()
  ..add('auto')
  ..add('c')
  ..sort();
