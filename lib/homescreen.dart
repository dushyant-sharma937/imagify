import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Imagify/bloc/image_prompt_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController controller = TextEditingController();
  final ImagePromptBloc imagePromptBloc = ImagePromptBloc();

  @override
  void initState() {
    imagePromptBloc.add(ImagePromptInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Imagify',
          style: TextStyle(
            fontFamily: 'Tiny',
            fontSize: 32,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        backgroundColor:
            Theme.of(context).colorScheme.primary.withOpacity(0.05),
      ),
      body: BlocConsumer<ImagePromptBloc, ImagePromptState>(
        bloc: imagePromptBloc,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case PromptImageLoadState:
              return Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: LoadingIndicator(
                    indicatorType: Indicator.ballScaleMultiple,
                    colors: [Theme.of(context).colorScheme.secondary],
                  ),
                ),
              );
            case PromptImageErrorState:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Error loading image"),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    IconButton(
                      onPressed: () {
                        imagePromptBloc.add(
                          ImagePromptInitialEvent(),
                        );
                      },
                      icon: Icon(Icons.refresh),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ],
                ),
              );
            case PromptImageSuccessState:
              final successState = state as PromptImageSuccessState;
              return Column(
                children: [
                  Expanded(
                    child: Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: MemoryImage(successState.unit8List),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        TextFormField(
                          controller: controller,
                          decoration: const InputDecoration(
                            labelText: 'Enter your prompt',
                            labelStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(),
                          ),
                          style: const TextStyle(
                            fontFamily: 'Md',
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        MaterialButton(
                          onPressed: () {
                            if (controller.text.trim().isNotEmpty) {
                              imagePromptBloc.add(
                                ImagePromptEnteredEvent(
                                  controller.text.trim(),
                                ),
                              );
                            }
                          },
                          color: Theme.of(context).colorScheme.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.generating_tokens),
                              SizedBox(width: 10),
                              Text(
                                'Generate Image',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
