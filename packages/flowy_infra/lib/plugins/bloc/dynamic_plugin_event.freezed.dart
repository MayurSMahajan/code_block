// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'dynamic_plugin_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DynamicPluginEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() addPlugin,
    required TResult Function(String name) removePlugin,
    required TResult Function() load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? addPlugin,
    TResult? Function(String name)? removePlugin,
    TResult? Function()? load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? addPlugin,
    TResult Function(String name)? removePlugin,
    TResult Function()? load,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddPlugin value) addPlugin,
    required TResult Function(_RemovePlugin value) removePlugin,
    required TResult Function(_Load value) load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddPlugin value)? addPlugin,
    TResult? Function(_RemovePlugin value)? removePlugin,
    TResult? Function(_Load value)? load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddPlugin value)? addPlugin,
    TResult Function(_RemovePlugin value)? removePlugin,
    TResult Function(_Load value)? load,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DynamicPluginEventCopyWith<$Res> {
  factory $DynamicPluginEventCopyWith(
          DynamicPluginEvent value, $Res Function(DynamicPluginEvent) then) =
      _$DynamicPluginEventCopyWithImpl<$Res, DynamicPluginEvent>;
}

/// @nodoc
class _$DynamicPluginEventCopyWithImpl<$Res, $Val extends DynamicPluginEvent>
    implements $DynamicPluginEventCopyWith<$Res> {
  _$DynamicPluginEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_AddPluginCopyWith<$Res> {
  factory _$$_AddPluginCopyWith(
          _$_AddPlugin value, $Res Function(_$_AddPlugin) then) =
      __$$_AddPluginCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_AddPluginCopyWithImpl<$Res>
    extends _$DynamicPluginEventCopyWithImpl<$Res, _$_AddPlugin>
    implements _$$_AddPluginCopyWith<$Res> {
  __$$_AddPluginCopyWithImpl(
      _$_AddPlugin _value, $Res Function(_$_AddPlugin) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_AddPlugin implements _AddPlugin {
  _$_AddPlugin();

  @override
  String toString() {
    return 'DynamicPluginEvent.addPlugin()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_AddPlugin);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() addPlugin,
    required TResult Function(String name) removePlugin,
    required TResult Function() load,
  }) {
    return addPlugin();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? addPlugin,
    TResult? Function(String name)? removePlugin,
    TResult? Function()? load,
  }) {
    return addPlugin?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? addPlugin,
    TResult Function(String name)? removePlugin,
    TResult Function()? load,
    required TResult orElse(),
  }) {
    if (addPlugin != null) {
      return addPlugin();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddPlugin value) addPlugin,
    required TResult Function(_RemovePlugin value) removePlugin,
    required TResult Function(_Load value) load,
  }) {
    return addPlugin(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddPlugin value)? addPlugin,
    TResult? Function(_RemovePlugin value)? removePlugin,
    TResult? Function(_Load value)? load,
  }) {
    return addPlugin?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddPlugin value)? addPlugin,
    TResult Function(_RemovePlugin value)? removePlugin,
    TResult Function(_Load value)? load,
    required TResult orElse(),
  }) {
    if (addPlugin != null) {
      return addPlugin(this);
    }
    return orElse();
  }
}

abstract class _AddPlugin implements DynamicPluginEvent {
  factory _AddPlugin() = _$_AddPlugin;
}

/// @nodoc
abstract class _$$_RemovePluginCopyWith<$Res> {
  factory _$$_RemovePluginCopyWith(
          _$_RemovePlugin value, $Res Function(_$_RemovePlugin) then) =
      __$$_RemovePluginCopyWithImpl<$Res>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$_RemovePluginCopyWithImpl<$Res>
    extends _$DynamicPluginEventCopyWithImpl<$Res, _$_RemovePlugin>
    implements _$$_RemovePluginCopyWith<$Res> {
  __$$_RemovePluginCopyWithImpl(
      _$_RemovePlugin _value, $Res Function(_$_RemovePlugin) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$_RemovePlugin(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_RemovePlugin implements _RemovePlugin {
  _$_RemovePlugin({required this.name});

  @override
  final String name;

  @override
  String toString() {
    return 'DynamicPluginEvent.removePlugin(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RemovePlugin &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RemovePluginCopyWith<_$_RemovePlugin> get copyWith =>
      __$$_RemovePluginCopyWithImpl<_$_RemovePlugin>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() addPlugin,
    required TResult Function(String name) removePlugin,
    required TResult Function() load,
  }) {
    return removePlugin(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? addPlugin,
    TResult? Function(String name)? removePlugin,
    TResult? Function()? load,
  }) {
    return removePlugin?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? addPlugin,
    TResult Function(String name)? removePlugin,
    TResult Function()? load,
    required TResult orElse(),
  }) {
    if (removePlugin != null) {
      return removePlugin(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddPlugin value) addPlugin,
    required TResult Function(_RemovePlugin value) removePlugin,
    required TResult Function(_Load value) load,
  }) {
    return removePlugin(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddPlugin value)? addPlugin,
    TResult? Function(_RemovePlugin value)? removePlugin,
    TResult? Function(_Load value)? load,
  }) {
    return removePlugin?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddPlugin value)? addPlugin,
    TResult Function(_RemovePlugin value)? removePlugin,
    TResult Function(_Load value)? load,
    required TResult orElse(),
  }) {
    if (removePlugin != null) {
      return removePlugin(this);
    }
    return orElse();
  }
}

abstract class _RemovePlugin implements DynamicPluginEvent {
  factory _RemovePlugin({required final String name}) = _$_RemovePlugin;

  String get name;
  @JsonKey(ignore: true)
  _$$_RemovePluginCopyWith<_$_RemovePlugin> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_LoadCopyWith<$Res> {
  factory _$$_LoadCopyWith(_$_Load value, $Res Function(_$_Load) then) =
      __$$_LoadCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_LoadCopyWithImpl<$Res>
    extends _$DynamicPluginEventCopyWithImpl<$Res, _$_Load>
    implements _$$_LoadCopyWith<$Res> {
  __$$_LoadCopyWithImpl(_$_Load _value, $Res Function(_$_Load) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Load implements _Load {
  _$_Load();

  @override
  String toString() {
    return 'DynamicPluginEvent.load()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Load);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() addPlugin,
    required TResult Function(String name) removePlugin,
    required TResult Function() load,
  }) {
    return load();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? addPlugin,
    TResult? Function(String name)? removePlugin,
    TResult? Function()? load,
  }) {
    return load?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? addPlugin,
    TResult Function(String name)? removePlugin,
    TResult Function()? load,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddPlugin value) addPlugin,
    required TResult Function(_RemovePlugin value) removePlugin,
    required TResult Function(_Load value) load,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddPlugin value)? addPlugin,
    TResult? Function(_RemovePlugin value)? removePlugin,
    TResult? Function(_Load value)? load,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddPlugin value)? addPlugin,
    TResult Function(_RemovePlugin value)? removePlugin,
    TResult Function(_Load value)? load,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class _Load implements DynamicPluginEvent {
  factory _Load() = _$_Load;
}
