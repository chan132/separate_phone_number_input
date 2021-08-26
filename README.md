# dseparate_phone_number_input

This is an input box that automatically separates the phone number



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
  this.iconBtn,
  this.iconBtnSize = defaultIconBtnSize,
  this.iconBtnMaxSize = defaultIconBtnMaxSize,
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

|              error input (helper text not sync)              |                 helper text sync error state                 |
| :----------------------------------------------------------: | :----------------------------------------------------------: |
| ``` dart<br />PhoneNumInput(<br/>	helperText: "unregistered phone numbers automatically create accounts",<br/>  controller: _phoneController,<br/>  focusNode: _focusNode,<br/>  isShowHelperText: true,<br/>  isShowErrorState: true,<br/>  onNumInputComplete: (result) => print("the phone number is entered"),<br/>  onEditingComplete: () => print("complete editing"),<br/>)<br /> ``` | ```dart<br />PhoneNumInput(<br/>  helperText: "the phone number entered was incorrect",<br/>  controller: _phoneController,<br/>  focusNode: _focusNode,<br/>  isShowHelperText: true,<br/>	isShowErrorState: true,<br/>  helperTextSyncErrorState: true,<br/>  onNumInputComplete: (result) => print("the phone number is entered"),<br/>  onEditingComplete: () => print("complete editing"),<br/>)<br />``` |
| ![empty input](https://raw.githubusercontent.com/chan132/separate_phone_number_input/master/images/err_not_sync_input.png) | ![empty input](https://raw.githubusercontent.com/chan132/separate_phone_number_input/master/images/err_input.png) |



## Contributions

If you encounter any problem or the library is missing a feature feel free to open an issue. Feel free to fork, improve the package and make pull request.



## License

[MIT](https://choosealicense.com/licenses/mit/)

