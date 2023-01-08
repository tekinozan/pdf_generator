import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf_generator/api/pdf_table_api.dart';
import 'package:pdf_generator/widget/button_widget.dart';
import 'package:pdf_generator/widget/container_widget.dart';
import 'package:pdf_generator/widget/edit_page_textfield_widget.dart';

import '../api/pdf_api.dart';
import '../api/pdf_invoice_api.dart';
import '../model/customer.dart';
import '../model/invoice.dart';
import '../model/supplier.dart';
import '../utils/colors.dart';
import '../utils/formats.dart';

class EditInvoicePage extends StatefulWidget {
  const EditInvoicePage({Key? key}) : super(key: key);

  @override
  State<EditInvoicePage> createState() => _EditInvoicePageState();
}

String _startValue = 'Invoice';
final types = ['Invoice', 'Proform'];

List<InvoiceItem> items = [];
int countItems = items.length;


TextEditingController supplierName = TextEditingController();
TextEditingController customerName = TextEditingController();
TextEditingController supplierAdress = TextEditingController();
TextEditingController customerAdress = TextEditingController();
TextEditingController dateController = TextEditingController();
TextEditingController invoiceNumber = TextEditingController();
TextEditingController dueDateController = TextEditingController();
TextEditingController description = TextEditingController();
TextEditingController quantity = TextEditingController();
TextEditingController unitPrice = TextEditingController();
TextEditingController vat = TextEditingController();
TextEditingController bankName = TextEditingController();
TextEditingController accNo = TextEditingController();


class _EditInvoicePageState extends State<EditInvoicePage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar( //appbar widget on Scaffold
        title:Text("Edit PDF - Invoice",style: TextStyle(fontSize: 16,color: Colors.black),), //title aof appbar
        backgroundColor: Colors.white, //background color of appbar
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              DropdownButton(
                icon: const Icon(Icons.keyboard_arrow_down),
                items: types
                    .map((String value) => DropdownMenuItem<String>(
                  child: Text(value),
                  value: value,
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _startValue = value!;
                  });
                },
                value: _startValue,
              ),
              ContainerWidget(
                  height: 300,
                  header: 'Header',
                  widget: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            EditPageTextField(controller: supplierName, width: 125, labelText: "Supplier Name",),
                            EditPageTextField(controller: customerName, width: 125, labelText: "Customer Name",),
                          ],
                        ),
                        EditPageTextField(controller: supplierAdress, width: 300, labelText: "Supplier Adress",),
                        EditPageTextField(controller: customerAdress, width: 300, labelText: "Customer Adress",),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            EditPageTextField(controller: dateController,width: 125, labelText: "Date",icon: Icon(Icons.calendar_month,size: 18,),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(), //get today's date
                                  firstDate:DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2101)
                              );
                              if(pickedDate != null ){
                                String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                setState(() {
                                  dateController.text = formattedDate;
                                });
                              }else{
                                print("Date is not selected");
                              }
                            },),
                            EditPageTextField(controller: dueDateController,width: 100, labelText: "Due Days", keyboardType: TextInputType.number),
                            EditPageTextField(controller: invoiceNumber,width: 100, labelText: "Invoice No", keyboardType: TextInputType.number),
                          ],
                        ),
                      ],
                    ),
                  )),
              SizedBox(height: screenHeight / 15),
              ContainerWidget(
                  height: 350,
                  header: 'Body',
                  widget: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        EditPageTextField(controller: description,labelText: "Description"),
                        EditPageTextField(controller: quantity, labelText: "Quantity", keyboardType: TextInputType.number),
                        EditPageTextField(controller: unitPrice, labelText: "Unit Price", keyboardType: TextInputType.number),
                        EditPageTextField(controller: vat, labelText: "VAT", keyboardType: TextInputType.number),
                        SizedBox(height: screenHeight / 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ButtonWidget(text: "+Add items",color: Colors.amberAccent, width: 200,  height: 30, onClicked: () async {
                              items.add(InvoiceItem(
                                description: description.text,
                                quantity: int.parse(quantity.text),
                                vat: double.parse(vat.text), // value added text
                                unitPrice: double.parse(unitPrice.text),
                              ));
                              setState(() {
                                countItems = items.length;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("You have added an item",textAlign: TextAlign.center,))
                              );
                              description.clear();
                              quantity.clear();
                              unitPrice.clear();
                              vat.clear();
                            }),
                            ButtonWidget(text: "Remove", onClicked: (){
                              items.removeLast();
                              setState(() {
                              countItems = items.length;
                            });
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Last item removed",textAlign: TextAlign.center,),backgroundColor: Colors.redAccent,)
                              );
                              },
                              color: Colors.redAccent,width: 55,height: 30,)
                          ],
                        ),
                        SizedBox(height: screenHeight / 100),
                        Text("Added item numbers: ${countItems}",style: TextStyle(fontWeight: FontWeight.bold),)
                      ],
                    ),
                  )),
              SizedBox(height: screenHeight / 15),
              ContainerWidget(
                  height: 150,
                  header: 'Footer',
                  widget: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        EditPageTextField(controller: bankName,labelText: "Name of Bank"),
                        EditPageTextField(controller: accNo, labelText: "Account No"),
                      ],
                    ),
                  )),
              SizedBox(height: screenHeight / 15),
              ButtonWidget(text: "CREATE ${_startValue.toUpperCase()}", onClicked: () async {
                final date = DateTime.parse(dateController.text);
                final dueDate = date.add(Duration(days: int.parse(dueDateController.text)));

                final invoice = Invoice(
                  supplier: Supplier(
                    name: supplierName.text,
                    address: supplierAdress.text,
                    paymentInfo: bankName.text,
                    accountNo: accNo.text,
                  ),
                  customer: Customer(
                    name: customerName.text,
                    address: customerAdress.text,
                  ),
                  info: InvoiceInfo(
                    date: date,
                    dueDate: dueDate,
                    description: '',
                    number: invoiceNumber.text,
                  ),
                  items: items,
                );

                if(items.isEmpty){
                  print("item list is empty");
                }

                await PdfInvoiceApi.invoiceType(_startValue);

                final pdfFile = await PdfInvoiceApi.generate(invoice);

                items.clear();
                supplierName.clear();
                customerName.clear();
                supplierAdress.clear();
                customerAdress.clear();
                invoiceNumber.clear();
                dateController.clear();
                dueDateController.clear();
                bankName.clear();
                accNo.clear();


                setState(() {
                  countItems = items.length;
                });

                PdfApi.openFile(pdfFile);
              })

            ],
          ),
        ),
      ),

    );
  }
}
