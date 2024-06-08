import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imagify/repos/prompt_repo.dart';

part 'image_prompt_event.dart';
part 'image_prompt_state.dart';

class ImagePromptBloc extends Bloc<ImagePromptEvent, ImagePromptState> {
  ImagePromptBloc() : super(ImagePromptInitial()) {
    on<ImagePromptEnteredEvent>(imagePromptEnteredEvent);
    on<ImagePromptInitialEvent>(imagePromptInitialEvent);
  }

  FutureOr<void> imagePromptEnteredEvent(
      ImagePromptEnteredEvent event, Emitter<ImagePromptState> emit) async {
    emit(PromptImageLoadState());
    Uint8List? bytes = await PromptRepo.generateImage(event.prompt);
    if (bytes != null) {
      emit(PromptImageSuccessState(bytes));
    } else {
      emit(PromptImageErrorState());
    }
  }

  FutureOr<void> imagePromptInitialEvent(
      ImagePromptInitialEvent event, Emitter<ImagePromptState> emit) async {
    final byteData = await rootBundle.load('assets/images/file.png');
    final buffer = byteData.buffer;
    // Uint8List bytes = await File('assets/images/file.png').readAsBytes();
    Uint8List bytes = buffer.asUint8List();
    emit(PromptImageSuccessState(bytes));
  }
}
