# Scrollable Text Indicator

[![pub package](https://img.shields.io/pub/v/scrollable_text_indicator.svg)](https://pub.dartlang.org/packages/scrollable_text_indicator)
A Flutter package that provides a scrollable text with vertical scroll indicator - just like web browsers do.
 
## Features

Here you can find example video and see the package in the action.

## Getting started

Please refer to the installation guide at [pub.dev](https://pub.dev/packages/chopper/scrollable_text_indicator). 
You can use this short description as well:
In your project's `pubspec.yaml` file add *scrollable_text_indicator*'s latest version to your *dependencies*.
```yaml
# pubspec.yaml

dependencies:
  scrollable_text_indicator: ^<latest version>
```

## Usage

Please check the simple example below
```dart
ScrollableTextIndicator(
    text: Text(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam pulvinar risus sit amet augue viverra ultrices. Aliquam erat volutpat. Proin sagittis ultricies blandit. Donec diam velit, vestibulum commodo leo eu, suscipit condimentum ante. Aenean laoreet sapien mauris. Praesent maximus sagittis felis auctor facilisis. In ullamcorper velit id leo semper, pellentesque luctus risus efficitur. Aenean et tristique diam, vitae volutpat mi. Morbi bibendum ut nibh a ornare. Nulla nec dolor pellentesque, gravida neque ut, condimentum augue. Phasellus mollis metus ac tincidunt venenatis. Aenean at ullamcorper massa. Vestibulum volutpat nunc ut ultrices facilisis. Cras dui lorem, vehicula eu hendrerit non, sollicitudin quis libero. Morbi dapibus libero tincidunt lobortis efficitur.',
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
    ),
);
```

