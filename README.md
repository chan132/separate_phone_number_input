# dseparate_phone_number_input

This is an input box that automatically separates the phone number.



## UI display

|                         empty input                          |                         normal input                         |
| :----------------------------------------------------------: | :----------------------------------------------------------: |
| ![empty input](https://raw.githubusercontent.com/chan132/separate_phone_number_input/master/images/empty_input.png) | ![normal input](https://raw.githubusercontent.com/chan132/separate_phone_number_input/master/images/normal_input.png) |



## Usage

To use this plugin, add `dseparate_phone_number_input` as a dependency in your pubspec.yaml file.

#### available parameters

```dart
PhoneNumInput({
  Key? key,
  this.width,
  this.margin,
  this.hintText,
  this.hintStyle,
  this.helperText,
  this.helperStyle,
  this.style,
  this.clearBtn,
  this.clearBtnSize = defaultClearBtnSize,
  this.clearBtnMaxSize = defaultClearBtnMaxSize,
  this.inputBorderSideWidth = defaultInputBorderSideWidth,
  required this.controller,
  this.focusNode,
  this.onNumInputComplete,
  this.onChanged,
  this.textInputAction = TextInputAction.next,
  this.onEditingComplete,
  this.isShowErrorState = false,
  this.isShowHelperText = false,
  this.isShowInputBorder = true,
  this.helperTextSyncErrorState = false,
}) : super(key: key);
```

#### special field instructions

| property                 | description                                                  | default |
| ------------------------ | ------------------------------------------------------------ | ------- |
| isShowErrorState         | whether to show error state                                  | false   |
| isShowHelperText         | whether to show helper text                                  | false   |
| isShowInputBorder        | whether to show input box border                             | true    |
| helperTextSyncErrorState | whether the Helper text is synchronized with the error state | false   |

#### example

* error input (helper text not sync)

  ```dart
  PhoneNumInput(
    helperText: "unregistered phone numbers automatically create accounts",
    controller: _phoneController,
    focusNode: _focusNode,
    isShowHelperText: true,
    isShowErrorState: true,
    onNumInputComplete: (result) => print("the phone number is entered"),
    onEditingComplete: () => print("complete editing"),
  )
  ```

  ![err not sync input](https://raw.githubusercontent.com/chan132/separate_phone_number_input/master/images/err_not_sync_input.png)

* helper text sync error state

  ```dart
  PhoneNumInput(
    helperText: "the phone number entered was incorrect",
    controller: _phoneController,
    focusNode: _focusNode,
    isShowHelperText: true,
    isShowErrorState: true,
    helperTextSyncErrorState: true,
    onNumInputComplete: (result) => print("the phone number is entered"),
    onEditingComplete: () => print("complete editing"),
  )
  ```

  ![err input](https://raw.githubusercontent.com/chan132/separate_phone_number_input/master/images/err_input.png)



## Contributions

If you encounter any problem or the library is missing a feature feel free to open an issue. Feel free to fork, improve the package and make pull request.



## License

[MIT](https://choosealicense.com/licenses/mit/)

