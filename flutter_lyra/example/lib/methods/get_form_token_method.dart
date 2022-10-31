import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../const.dart';
import '../widgets/snackbar.dart';

class GetFormTokenMethod extends StatefulWidget {
  const GetFormTokenMethod({
    required this.dataSet,
    required this.formTokenVersion,
    required this.formToken,
    required this.setFormToken,
    super.key,
  });

  final DataSet dataSet;
  final int formTokenVersion;
  final String? formToken;
  final void Function(String newFormToken) setFormToken;

  @override
  State<GetFormTokenMethod> createState() => _GetFormTokenMethodState();
}

class _GetFormTokenMethodState extends State<GetFormTokenMethod> {
  bool areInteractionsDisabled = false;

  Future<void> getFormToken() async {
    setState(() {
      areInteractionsDisabled = true;
    });

    try {
      final dio = Dio(BaseOptions());

      final basicAuthentication =
          '''Basic ${base64Encode(utf8.encode('${widget.dataSet.initialMerchantUsername}:${widget.dataSet.initialMerchantPassword}'))}''';

      final result = await dio.fetch<Map<Object?, Object?>>(
        RequestOptions(
          path: widget.dataSet.initialMerchantUrl +
              widget.dataSet.initialCreatePaymentRoutePath,
          method: 'POST',
          headers: <String, dynamic>{
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: basicAuthentication
          },
          data: widget.dataSet
              .initialCreatePaymentPayload(widget.formTokenVersion),
        ),
      );

      final data = result.data;
      final answer = data?['answer'] as Map<Object?, Object?>?;

      final formToken = answer?['formToken'] as String?;

      if (formToken == null) {
        throw Exception('Form Token is null');
      }

      widget.setFormToken(formToken);

      if (mounted) {
        showExampleSnackBar(
          context,
          message: 'Success - getFormToken - ${widget.dataSet.name}',
          type: SnackbarType.success,
        );
      }
    } catch (error) {
      if (mounted) {
        showExampleSnackBar(
          context,
          message: error.toString(),
          type: SnackbarType.error,
        );
      }
    } finally {
      setState(() {
        areInteractionsDisabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final formToken = widget.formToken;

    return ListView(
      children: [
        if (formToken == null) ...[
          Text(
            '''payment request :${widget.dataSet.initialCreatePaymentPayload(widget.formTokenVersion)}''',
          ),
          const SizedBox(height: 32),
        ],
        ElevatedButton(
          onPressed: !areInteractionsDisabled ? getFormToken : null,
          child: Text(
            formToken == null
                ? 'Get Form Token'
                : "You've already got your form token",
          ),
        ),
        if (formToken != null) ...[
          const SizedBox(height: 32),
          Text('formToken :$formToken'),
        ]
      ],
    );
  }
}
