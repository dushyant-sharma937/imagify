part of 'image_prompt_bloc.dart';

@immutable
sealed class ImagePromptEvent {}

class ImagePromptInitialEvent extends ImagePromptEvent {}

class ImagePromptEnteredEvent extends ImagePromptEvent {
  final String prompt;
  ImagePromptEnteredEvent(this.prompt);
}
