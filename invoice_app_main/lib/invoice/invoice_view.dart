import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice/invoice/invoice_controller.dart';

class InvoiceView extends GetView<InvoiceController> {
  const InvoiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: controller.invoiceNumber,
                decoration: const InputDecoration(
                  hintText: 'Invoice Number',
                ),
              ),
              TextField(
                controller: controller.invoiceDate,
                decoration: const InputDecoration(
                  hintText: 'Invoice Date',
                ),
              ),
              TextField(
                controller: controller.timeStamp,
                decoration: const InputDecoration(
                  hintText: 'Time Stamp',
                ),
              ),
              TextField(
                controller: controller.totalAmount,
                decoration: const InputDecoration(
                  hintText: 'Total Amount',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Sign Contract'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
