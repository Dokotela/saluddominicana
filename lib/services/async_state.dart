import 'package:freezed_annotation/freezed_annotation.dart';

part 'async_state.freezed.dart';

@freezed
class AsyncState with _$AsyncState {
  AsyncState._();

  factory AsyncState.initial({String? type, String? display}) =
      AsyncStateInitial;
  factory AsyncState.loading({String? type, String? display}) =
      AsyncStateLoading;
  factory AsyncState.data({String? type, String? display, List? data}) =
      AsyncStateData;
  factory AsyncState.error(
      {String? type,
      String? display,
      required Object error,
      StackTrace? stackTrace}) = AsyncStateError;

  String stateDisplay() => map.call(
        initial: (s) => '${s.type ?? s.display ?? ''} has not started',
        loading: (s) => '${s.type ?? s.display ?? ''} loading',
        data: (s) => '${s.type ?? s.display ?? ''} completed',
        error: (s) => '${s.type ?? s.display ?? ''} had an error',
      );
}
