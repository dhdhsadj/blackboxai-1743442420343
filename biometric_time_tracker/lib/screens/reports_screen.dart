import 'package:flutter/material.dart';
import 'package:biometric_time_tracker/constants.dart';
import 'package:biometric_time_tracker/models/time_record.dart';
import 'package:biometric_time_tracker/services/api_service.dart';
import 'package:intl/intl.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  DateTimeRange? _dateRange;
  List<TimeRecord> _records = [];
  bool _isLoading = false;

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: _dateRange,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.textLight,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _dateRange = picked);
      _loadReports();
    }
  }

  Future<void> _loadReports() async {
    if (_dateRange == null) return;
    
    setState(() => _isLoading = true);
    try {
      // TODO: Implement actual report loading from API
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call
      setState(() {
        _records = [
          TimeRecord(
            id: '1',
            employeeId: 'emp1',
            timestamp: DateTime.now().subtract(const Duration(days: 1)),
            actionType: 'clock_in',
          ),
          TimeRecord(
            id: '2',
            employeeId: 'emp1',
            timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 4)),
            actionType: 'break_start',
          ),
        ];
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load reports: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => _selectDateRange(context),
          ),
        ],
      ),
      body: Column(
        children: [
          if (_dateRange != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Showing reports from ${DateFormat.yMd().format(_dateRange!.start)} '
                'to ${DateFormat.yMd().format(_dateRange!.end)}',
                style: AppTextStyles.bodyText,
              ),
            ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _records.isEmpty
                    ? Center(
                        child: Text(
                          _dateRange == null
                              ? 'Select a date range to view reports'
                              : 'No records found for selected period',
                          style: AppTextStyles.bodyText,
                        ),
                      )
                    : ListView.builder(
                        itemCount: _records.length,
                        itemBuilder: (context, index) {
                          final record = _records[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: ListTile(
                              leading: const Icon(
                                Icons.access_time,
                                color: AppColors.primary,
                              ),
                              title: Text(record.displayAction),
                              subtitle: Text(
                                DateFormat('MMM d, y - h:mm a')
                                    .format(record.timestamp),
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}