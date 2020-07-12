import 'package:flutter/material.dart';

import '../../../models/Prescription.dart';
import '../../../models/MedicalReport.dart';
import '../local_widgets/CustomHeader.dart';
import '../local_widgets/DataInput.dart';
import '../../../services/AppointmentProvider.dart';
import '../../../services/UserDatabaseService.dart';
import '../../../widgets/CustomAppBar.dart';

class ReportScreen extends StatefulWidget {

  final String appointmentId;
  final bool isPrescription;

  ReportScreen(this.appointmentId, this.isPrescription);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {

  final UserDatabaseService userDatabaseService = UserDatabaseService();
  final _controller = TextEditingController();

  void getData() async {
    if (widget.isPrescription) {
      Prescription prescription = await userDatabaseService.getPrescription(widget.appointmentId);
      setState(() => _controller.text = prescription.data);
    } else {
      MedicalReport report = await userDatabaseService.getMedicalReport(widget.appointmentId);
      setState(() => _controller.text = report.data);
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        AppointmentProvider.updateMedicalReport(widget.appointmentId, _controller.text);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: customAppBar(
          context, 
          widget.isPrescription ? 'Prescription' : 'Medical Report', 
          popCall: () => AppointmentProvider.updateMedicalReport(widget.appointmentId, _controller.text)
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            customHeader(context),
            DataInput(
              _controller,
              disabled: widget.isPrescription ? true : false,
            ),
            customFooter(context),
          ],
        ),
      ),
    );
  }
}