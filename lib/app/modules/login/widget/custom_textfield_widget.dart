import 'package:flutter/material.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/12/25.

///代码清单
///自定义文本输入框
class TextFieldWidget extends StatelessWidget {
  final double fontSize;

  final double iconSize;

  //文本外扩高度（用于修改文本框高度）
  final double contentPadding;

  //占位提示文本
  final String? hintText;

  //输入框前置图标
  final IconData? prefixIconData;

  //输入框后置图标
  final IconData? suffixIconData;

  //是否隐藏文本
  final bool? obscureText;

  //输入实时回调
  final Function(String value)? onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function(String value)? submit;
  final Function()? onTap;

  TextFieldWidget(
      {Key? key,
      this.contentPadding = 20,
      this.hintText,
      this.submit,
      this.focusNode,
      this.prefixIconData,
      this.suffixIconData,
      this.obscureText,
      this.onChanged,
      this.controller,
      this.onTap,
      this.fontSize = 14,
      this.iconSize = 18})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //构建输入框
    return TextField(
      focusNode: focusNode,
      controller: controller,
      //实时输入回调
      onChanged: onChanged,
      onSubmitted: submit,
      //是否隐藏文本
      obscureText: obscureText ?? false,
      //隐藏文本小圆点的颜色
      cursorColor: Theme.of(context).colorScheme.secondary,
      //文本样式
      style: TextStyle(
        color: Theme.of(context).colorScheme.secondary,
        fontSize: fontSize,
      ),
      //输入框的边框
      decoration: InputDecoration(
        isDense: true,
        isCollapsed: true,
        contentPadding: EdgeInsets.all(contentPadding),

        //提示文本
        labelText: hintText,
        //提示文本的样式
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        //可编辑时的提示文本的颜色
        focusColor: Theme.of(context).colorScheme.secondary,
        //填充
        filled: true,
        //可编辑时 无边框样式
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
        //获取输入焦点时的边框样式
        focusedBorder: OutlineInputBorder(
          gapPadding: 0,
          borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(color: Theme.of(context).colorScheme.secondary),
        ),
        //文本前置的图标
        prefixIcon: Icon(
          prefixIconData,
          size: iconSize,
          color: Theme.of(context).colorScheme.secondary,
        ),
        //文本后置的图标
        suffixIcon: GestureDetector(
          onTap: onTap,
          child: Icon(
            suffixIconData,
            size: iconSize,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
