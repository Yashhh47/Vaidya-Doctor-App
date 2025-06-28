import 'package:flutter/material.dart';
import "fetch_data.dart";

class PatientDetailsScreen extends StatelessWidget {

  // Sample patient data based on your provided structure

  // final Map<String, dynamic> patientData = p1234.getPatientProfile("SJVK0399F3");
  final Map<String, dynamic> patientData = {
    'personalInfo': {
      'bloodGroup': 'A-',
      'phone': '',
      'name': 'Tanishq',
      'profileImagePath': 'profile_image.png',
      'dateOfBirth': '19/6/2025'
    },
    'diseases': [
      {
        'medicines': [
          {
            'quantity': 100,
            'timing': {
              'afternoon': false,
              'afterMeal': false,
              'beforeMeal': true,
              'evening': true,
              'morning': false
            },
            'name': 'kaju'
          },
          {
            'quantity': '',
            'timing': {
              'afternoon': false,
              'afterMeal': false,
              'beforeMeal': false,
              'evening': false,
              'morning': false
            },
            'name': ''
          }
        ],
        'name': 'juju'
      }
    ],
    'savedAt': 1751138462,
    'emergencyContacts': [
      {'phone': '64648', 'name': 'kishu'}
    ],
    'lastModified': '2025-06-29T00:51:00.556423'
  };

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('Patient Details'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isTablet ? 24.0 : 16.0),
          child: Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: isTablet ? 800 : double.infinity),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _getItemCount(),
                itemBuilder: (context, index) {
                  return _buildListItem(context, index, isTablet);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  int _getItemCount() {
    // Personal Info + Diseases + Emergency Contacts + Metadata
    if (patientData == null || patientData!['diseases'] == null) return 1;
    return 1 + (patientData!['diseases'] as List).length;

  }

  Widget _buildListItem(BuildContext context, int index, bool isTablet) {
    if (index == 0) {
      return _buildPersonalInfoCard(isTablet);
    } else {
      return _buildDiseaseCard(index - 1, isTablet);
    }
  }

  Widget _buildPersonalInfoCard(bool isTablet) {
    final personalInfo = patientData?['personalInfo'] ?? {};


    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(isTablet ? 24.0 : 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: isTablet ? 40 : 30,
                  backgroundColor: Colors.blue[100],
                  child: Icon(
                    Icons.person,
                    size: isTablet ? 40 : 30,
                    color: Colors.blue[600],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Personal Information',
                        style: TextStyle(
                          fontSize: isTablet ? 22 : 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        personalInfo['name'] ?? 'N/A',
                        style: TextStyle(
                          fontSize: isTablet ? 20 : 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            _buildResponsiveInfoGrid([
              _buildInfoItem('Blood Group', personalInfo['bloodGroup'] ?? 'N/A', Icons.water_drop),
              _buildInfoItem('Phone', personalInfo['phone']?.isNotEmpty == true ? personalInfo['phone'] : 'Not provided', Icons.phone),
              _buildInfoItem('Date of Birth', personalInfo['dateOfBirth'] ?? 'N/A', Icons.cake),
            ], isTablet),
          ],
        ),
      ),
    );
  }

  Widget _buildDiseaseCard(int diseaseIndex, bool isTablet) {
    final disease = (patientData?['diseases'] as List)[diseaseIndex];

    final medicines = disease['medicines'] as List;

    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(isTablet ? 24.0 : 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.medical_services, color: Colors.red[600], size: isTablet ? 28 : 24),
                SizedBox(width: 12),
                Text(
                  'Disease: ${disease['name'] ?? 'Unnamed'}',
                  style: TextStyle(
                    fontSize: isTablet ? 20 : 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Medicines:',
              style: TextStyle(
                fontSize: isTablet ? 18 : 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 12),
            ...medicines.map((medicine) => _buildMedicineItem(medicine, isTablet)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicineItem(Map<String, dynamic> medicine, bool isTablet) {
    final timing = medicine['timing'] as Map<String, dynamic>;
    final activeTimings = timing.entries
        .where((entry) => entry.value == true)
        .map((entry) => entry.key)
        .toList();

    if (medicine['name']?.isEmpty != false) {
      return SizedBox.shrink();
    }

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(isTablet ? 16 : 12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.medication, color: Colors.green[600], size: isTablet ? 20 : 16),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  medicine['name'] ?? 'Unnamed Medicine',
                  style: TextStyle(
                    fontSize: isTablet ? 16 : 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (medicine['quantity'] != null && medicine['quantity'].toString().isNotEmpty)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Qty: ${medicine['quantity']}',
                    style: TextStyle(
                      fontSize: isTablet ? 12 : 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue[800],
                    ),
                  ),
                ),
            ],
          ),
          if (activeTimings.isNotEmpty) ...[
            SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: activeTimings.map((timing) => Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  timing,
                  style: TextStyle(
                    fontSize: isTablet ? 11 : 9,
                    color: Colors.green[800],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )).toList(),
            ),
          ],
        ],
      ),
    );
  }



  Widget _buildMetadataCard(bool isTablet) {
    final savedTimestamp = patientData['savedAt'];
    final lastModified = patientData['lastModified'];

    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(isTablet ? 24.0 : 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline, color: Colors.grey[600], size: isTablet ? 28 : 24),
                SizedBox(width: 12),
                Text(
                  'Record Information',
                  style: TextStyle(
                    fontSize: isTablet ? 20 : 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildResponsiveInfoGrid([
              _buildInfoItem('Saved At', _formatTimestamp(savedTimestamp), Icons.save),
              _buildInfoItem('Last Modified', _formatDateTime(lastModified), Icons.edit),
            ], isTablet),
          ],
        ),
      ),
    );
  }

  Widget _buildResponsiveInfoGrid(List<Widget> items, bool isTablet) {
    if (isTablet) {
      return GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 12,
        children: items,
      );
    } else {
      return Column(
        children: items.map((item) => Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: item,
        )).toList(),
      );
    }
  }

  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue[600], size: 18),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(int? timestamp) {
    if (timestamp == null) return 'N/A';
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  String _formatDateTime(String? dateTimeStr) {
    if (dateTimeStr == null) return 'N/A';
    try {
      final date = DateTime.parse(dateTimeStr);
      return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateTimeStr;
    }
  }
}