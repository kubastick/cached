import 'package:analyzer/dart/element/element.dart';
import 'package:cached/src/config.dart';
import 'package:cached/src/models/cached_function.dart';
import 'package:cached/src/models/cached_function_local_config.dart';

const _defaultSyncWriteValue = false;

class CachedGetter extends CachedFunction {
  CachedGetter._({
    required super.name,
    required super.syncWrite,
    required super.returnType,
    required super.isGenerator,
    required super.isAsync,
    required super.limit,
    required super.ttl,
    required super.checkIfShouldCacheMethod,
  });

  factory CachedGetter.fromElement(
    PropertyAccessorElement element,
    Config config,
  ) {
    CachedFunction.assertIsValid(element);

    final annotation = CachedFunction.getAnnotation(element);
    final localConfig = CachedFunctionLocalConfig.fromAnnotation(annotation);

    final method = CachedGetter._(
      name: element.name,
      syncWrite:
          localConfig.syncWrite ?? config.syncWrite ?? _defaultSyncWriteValue,
      limit: localConfig.limit ?? config.limit,
      ttl: localConfig.ttl ?? config.ttl,
      checkIfShouldCacheMethod: localConfig.checkIfShouldCacheMethod,
      returnType: element.returnType.getDisplayString(withNullability: true),
      isAsync: element.isAsynchronous,
      isGenerator: element.isGenerator,
    );

    return method;
  }
}
