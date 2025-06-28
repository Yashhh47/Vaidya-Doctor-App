import 'package:flutter/material.dart';

class PatientDetailsScreen extends StatelessWidget {
  const PatientDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy patient data
    final patientInfo = {
      'name': 'Rahul Mehra',
      'age': 34,
      'bloodGroup': 'B+',
      'gender': 'Male',
      'dob': '15 Aug 1990',
    };

    // Dummy disease and medicine data (structure as from Firebase)
    final Map<String, List<Map<String, String>>> diseaseMedicineMap = {
      'Diabetes': [
        {'name': 'Metformin', 'timing': 'Before Meal'},
        {'name': 'Insulin', 'timing': 'After Meal'},
      ],
      'Hypertension': [
        {'name': 'Amlodipine', 'timing': 'After Meal'},
        {'name': 'Losartan', 'timing': 'Before Meal'},
      ],
    };

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffA1D8FF),
        title: Center(
          child: Text(
            "Medical Details",
            style: TextStyle(
                color: Color(0xff005AC4), fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xffA1D8FF), Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.center)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Patient Info Display
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xffEAF6FF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name: ${patientInfo['name']}", style: infoStyle()),
                    Text("Age: ${patientInfo['age']}", style: infoStyle()),
                    Text("Blood Group: ${patientInfo['bloodGroup']}",
                        style: infoStyle()),
                    Text("Gender: ${patientInfo['gender']}",
                        style: infoStyle()),
                    Text("Date of Birth: ${patientInfo['dob']}",
                        style: infoStyle()),
                  ],
                ),
              ),
              SizedBox(height: 20),

              Text(
                "Medicines Prescribed",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10),

              // List of medicines using ListView.builder
              Expanded(
                child: ListView.builder(
                  itemCount: diseaseMedicineMap.keys.length,
                  itemBuilder: (context, index) {
                    String disease = diseaseMedicineMap.keys.elementAt(index);
                    List<Map<String, String>> meds =
                        diseaseMedicineMap[disease]!;

                    return Card(
                      elevation: 3,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Disease: $disease",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff005AC4),
                              ),
                            ),
                            SizedBox(height: 8),
                            ...meds.map((med) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Medicine: ${med['name']}"),
                                      Text("Timing: ${med['timing']}"),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle infoStyle() => TextStyle(fontSize: 16, color: Colors.black87);
}
