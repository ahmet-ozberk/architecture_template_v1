import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProvidersLogger extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderBase provider,
    Object? value,
    ProviderContainer container,
  ) {
    log(
      '''
      "✅ provider": "${provider.name ?? provider.runtimeType}",
      "✅ value": "${value.toString()}",
      "✅ container: "$container"
      ''',
      name: '✅ Provider Added',
    );
  }

  @override
  void providerDidFail(
    ProviderBase provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    log(
      '''
      "❌ provider": "${provider.name ?? provider.runtimeType}",
      "❌ error": "${error.toString()}",
      "❌ container: "$container"
      ''',
      name: '❌ Provider Failed',
    );
  }

  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    log(
      '''
      "🔆 provider": "${provider.name ?? provider.runtimeType}",
      "🔆 newValue": "${newValue.toString()}"
    ''',
      name: '🔆 Provider Updated',
    );
  }

  @override
  void didDisposeProvider(
    ProviderBase provider,
    ProviderContainer container,
  ) {
    log(
      '''
      "🚫 provider": "${provider.name ?? provider.runtimeType}",
      "🚫 containers": "$container"
    ''',
      name: '🚫 Provider Disposed',
    );
  }
}