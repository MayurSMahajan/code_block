// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

/// The theme applied to the code block
class CodeBlockTheme {
  final TextStyle root;
  final TextStyle comment;
  final TextStyle quote;
  final TextStyle tag;
  final TextStyle attribute;
  final TextStyle keyword;
  final TextStyle selector_tag;
  final TextStyle literal;
  final TextStyle name;
  final TextStyle variable;
  final TextStyle template_variable;
  final TextStyle code;
  final TextStyle string;
  final TextStyle meta_string;
  final TextStyle regexp;
  final TextStyle link;
  final TextStyle title;
  final TextStyle symbol;
  final TextStyle bullet;
  final TextStyle number;
  final TextStyle section;
  final TextStyle meta;
  final TextStyle type;
  final TextStyle built_in;
  final TextStyle builtin_name;
  final TextStyle params;
  final TextStyle attr;
  final TextStyle subst;
  final TextStyle formula;
  final TextStyle addition;
  final TextStyle deletion;
  final TextStyle selector_id;
  final TextStyle selector_class;
  final TextStyle doctag;
  final TextStyle strong;
  final TextStyle emphasis;

  const CodeBlockTheme({
    required this.root,
    required this.comment,
    required this.quote,
    required this.tag,
    required this.attribute,
    required this.keyword,
    required this.selector_tag,
    required this.literal,
    required this.name,
    required this.variable,
    required this.template_variable,
    required this.code,
    required this.string,
    required this.meta_string,
    required this.regexp,
    required this.link,
    required this.title,
    required this.symbol,
    required this.bullet,
    required this.number,
    required this.section,
    required this.meta,
    required this.type,
    required this.built_in,
    required this.builtin_name,
    required this.params,
    required this.attr,
    required this.subst,
    required this.formula,
    required this.addition,
    required this.deletion,
    required this.selector_id,
    required this.selector_class,
    required this.doctag,
    required this.strong,
    required this.emphasis,
  });

  Map<String, TextStyle> _toMap() => {
        'root': root,
        'comment': comment,
        'quote': quote,
        'tag': tag,
        'attribute': attribute,
        'keyword': keyword,
        'selector-tag': selector_tag,
        'literal': literal,
        'name': name,
        'variable': variable,
        'template-variable': template_variable,
        'code': code,
        'string': string,
        'meta_string': meta_string,
        'regexp': regexp,
        'link': link,
        'title': title,
        'symbol': symbol,
        'bullet': bullet,
        'number': number,
        'section': section,
        'meta': meta,
        'type': type,
        'built_in': built_in,
        'builtin-name': builtin_name,
        'params': params,
        'attr': attr,
        'subst': subst,
        'formula': formula,
        'addition': addition,
        'deletion': deletion,
        'selector-id': selector_id,
        'selector-class': selector_class,
        'doctag': doctag,
        'strong': strong,
        'emphasis': emphasis,
      };

  String toKey(String key) => key.replaceAll('-', '_');

  TextStyle? operator [](String key) => _toMap()[toKey(key)];
}
