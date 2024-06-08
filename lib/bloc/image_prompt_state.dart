part of 'image_prompt_bloc.dart';

@immutable
sealed class ImagePromptState {}

final class ImagePromptInitial extends ImagePromptState {}

final class PromptImageLoadState extends ImagePromptState {}

final class PromptImageErrorState extends ImagePromptState {}

final class PromptImageSuccessState extends ImagePromptState {
  final Uint8List unit8List;
  PromptImageSuccessState(this.unit8List);
}
