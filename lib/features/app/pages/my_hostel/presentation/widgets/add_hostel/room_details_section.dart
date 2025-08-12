import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:packinh/core/constants/colors.dart';
import 'package:packinh/core/constants/const.dart';
import 'package:packinh/core/widgets/custom_green_button_widget.dart';
import 'package:packinh/core/widgets/custom_text_field_widget.dart';

class RoomDetailsSection extends StatefulWidget {
  final List<Map<String, dynamic>> rooms;
  final String? roomsError;
  final Function(String, int, double) onAddRoom;
  final Function(Map<String, dynamic>) onRemoveRoom;
  final VoidCallback onErrorChanged;

  const RoomDetailsSection({
    super.key,
    required this.rooms,
    this.roomsError,
    required this.onAddRoom,
    required this.onRemoveRoom,
    required this.onErrorChanged,
  });

  @override
  State<RoomDetailsSection> createState() => _RoomDetailsSectionState();
}

class _RoomDetailsSectionState extends State<RoomDetailsSection> {
  final TextEditingController _countController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  String? _selectedType;
  String? _typeError;
  String? _countError;
  String? _rateError;

  final List<String> _roomTypes = ['Single', '2 Share', '3 Share', 'Shared', 'Dormitory'];

  void _showAddRoomDialog() {
    _selectedType = null;
    _countController.clear();
    _rateController.clear();
    _typeError = null;
    _countError = null;
    _rateError = null;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: secondaryColor,
        title: const Text('Add Room'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Room Type',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: mainColor,
                  borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<String>(
                dropdownColor: Colors.white,
                value: _selectedType,
                hint: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text('Select room type',style: TextStyle(color: Colors.white),),
                ),
                isExpanded: true,
                items: _roomTypes.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedType = newValue;
                    _typeError = null;
                  });
                },
              ),
            ),
            if (_typeError != null)
              Text(
                _typeError!,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            height10,
            CustomTextFieldWidget(
              hintText: '000',
              fieldName: 'Room Count',
              controller: _countController,
              errorText: _countError,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Room count is required';
                }
                if (int.tryParse(value) == null) {
                  return 'Enter a valid number';
                }
                return null;
              },
              onChanged: (_) => setState(() => _countError = null),
            ),
            height10,
            CustomTextFieldWidget(
              hintText: '₹₹₹₹',
              fieldName: 'Room Rate',
              controller: _rateController,
              errorText: _rateError,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Room rate is required';
                }
                if (double.tryParse(value) == null) {
                  return 'Enter a valid number';
                }
                return null;
              },
              onChanged: (_) => setState(() => _rateError = null),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          CustomGreenButtonWidget(
            name: 'Add',
            onPressed: () {
              setState(() {
                _typeError = _selectedType == null ? 'Room type is required' : null;
                _countError = _countController.text.isEmpty
                    ? 'Room count is required'
                    : int.tryParse(_countController.text) == null
                    ? 'Enter a valid number'
                    : null;
                _rateError = _rateController.text.isEmpty
                    ? 'Room rate is required'
                    : double.tryParse(_rateController.text) == null
                    ? 'Enter a valid number'
                    : null;

                if (_typeError == null && _countError == null && _rateError == null) {
                  widget.onAddRoom(
                    _selectedType!,
                    int.parse(_countController.text),
                    double.parse(_rateController.text),
                  );
                  widget.onErrorChanged();
                  Navigator.pop(context);
                }
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        height10,
        Center(
          child: SizedBox(
            width: width * 0.65,
            child: CustomGreenButtonWidget(
              name: 'Add Room Details',
              color: secondaryMain,
              onPressed: _showAddRoomDialog,
            ),
          ),
        ),
        height10,
        if (widget.roomsError != null)
          Text(
            widget.roomsError!,
            style: const TextStyle(color: Colors.red, fontSize: 12),
          ),
        ...widget.rooms.map((room) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${room['type']} (${room['count']})',
                style: const TextStyle(fontSize: 17),
              ),
              Text(
                '₹${room['rate']}',
                style: const TextStyle(fontSize: 17),
              ),
              IconButton(
                icon: const Icon(FontAwesomeIcons.trash, size: 16, color: Colors.red),
                onPressed: () {
                  widget.onRemoveRoom(room);
                  widget.onErrorChanged();
                },
              ),
            ],
          ),
        )),
      ],
    );
  }

  @override
  void dispose() {
    _countController.dispose();
    _rateController.dispose();
    super.dispose();
  }
}