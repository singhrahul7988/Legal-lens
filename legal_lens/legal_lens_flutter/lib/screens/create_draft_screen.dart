import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../core/enums/draft_type.dart';
import 'draft_editor_screen.dart';
import 'package:legal_lens_client/legal_lens_client.dart' as api;
import '../../main.dart' as main_app; // Access global 'client' variable

class CreateDraftScreen extends StatefulWidget {
  final DraftType draftType;

  const CreateDraftScreen({
    super.key,
    this.draftType = DraftType.rentalAgreement,
  });

  @override
  State<CreateDraftScreen> createState() => _CreateDraftScreenState();
}

class _CreateDraftScreenState extends State<CreateDraftScreen> {
  final TextEditingController _extraInfoController = TextEditingController();
  
  // Rental specific controllers
  final TextEditingController _landlordController = TextEditingController();
  final TextEditingController _tenantController = TextEditingController();
  final TextEditingController _rentController = TextEditingController();
  
  // Generic controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _recipientController = TextEditingController();

  // Duration State
  int _durationValue = 11;
  String _durationUnit = 'Months';
  final List<int> _durationValues = List.generate(99, (index) => index + 1);
  final List<String> _durationUnits = ['Months', 'Years'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          _getTitle(),
          style: const TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textDark),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Help',
              style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.draftType == DraftType.rentalAgreement) ...[
                _buildStepIndicator(),
                const SizedBox(height: 24),
              ],
              _buildButlerMessage(),
              const SizedBox(height: 24),
              _buildFormFields(),
              const SizedBox(height: 24),
              _buildExtraInfoField(),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomAction(context),
    );
  }

  String _getTitle() {
    switch (widget.draftType) {
      case DraftType.rentalAgreement: return 'New Rental Draft';
      case DraftType.noticeToVacate: return 'Notice to Vacate';
      case DraftType.rentIncreaseNotice: return 'Rent Increase Notice';
      case DraftType.medicalBillComplaint: return 'Medical Complaint';
      case DraftType.consumerComplaint: return 'Consumer Complaint';
      case DraftType.resignationLetter: return 'Resignation Letter';
      case DraftType.custom: return 'Custom Document';
    }
  }

  Widget _buildStepIndicator() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Step 2 of 4',
              style: TextStyle(
                color: AppColors.primaryBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Agreement Details',
              style: TextStyle(color: AppColors.textGrey),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: 0.5,
          backgroundColor: Colors.grey.shade200,
          color: AppColors.primaryBlue,
          minHeight: 4,
          borderRadius: BorderRadius.circular(2),
        ),
      ],
    );
  }

  Widget _buildButlerMessage() {
    String message = "I've set the defaults based on standard norms. Want to change anything?";
    if (widget.draftType == DraftType.rentalAgreement) {
      message = "I've set the security deposit to 2 months as per the Model Tenancy Act. Want to change it?";
    } else if (widget.draftType == DraftType.custom) {
      message = "Describe what you need, and I'll draft it for you.";
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: AppColors.subtleBlue,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.border),
          ),
          child: const Icon(Icons.person, color: AppColors.primaryBlue, size: 24),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F2F9),
              borderRadius: BorderRadius.circular(16).copyWith(topLeft: Radius.zero),
              border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
            ),
            child: Text(
              message,
              style: const TextStyle(
                color: AppColors.textDark,
                height: 1.4,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFormFields() {
    if (widget.draftType == DraftType.rentalAgreement) {
      return _buildRentalFields();
    } else if (widget.draftType == DraftType.custom) {
      return const SizedBox.shrink();
    } else {
      return _buildGenericFields();
    }
  }

  Widget _buildRentalFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel('LANDLORD DETAILS'),
        _buildTextField(
          controller: _landlordController,
          hint: 'e.g. Rahul Sharma',
          label: 'Full Name',
        ),
        const SizedBox(height: 16),
        _buildTextField(
          hint: 'Complete address as per Aadhaar',
          label: 'Permanent Address',
          maxLines: 2,
        ),
        const SizedBox(height: 24),
        _buildSectionLabel('TENANT DETAILS'),
        _buildTextField(
          controller: _tenantController,
          hint: "Enter tenant's legal name",
          label: 'Full Name',
        ),
        const SizedBox(height: 17),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: _buildTextField(
                controller: _rentController,
                hint: '0.00',
                label: 'Monthly Rent',
                icon: Icons.currency_rupee,
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Lease Duration',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textGrey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          height: 56,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<int>(
                              value: _durationValue,
                              isExpanded: true,
                              icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textGrey),
                              items: _durationValues.map((int value) {
                                return DropdownMenuItem<int>(
                                  value: value,
                                  child: Center(
                                    child: Text(
                                      value.toString(),
                                      style: const TextStyle(fontSize: 16, color: Colors.black),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (int? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    _durationValue = newValue;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 6,
                        child: Container(
                          height: 56,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _durationUnit,
                              isExpanded: true,
                              icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textGrey),
                              items: _durationUnits.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(fontSize: 16, color: Colors.black),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    _durationUnit = newValue;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildStandardTermsToggle(),
      ],
    );
  }

  Widget _buildGenericFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel('PARTICIPANTS'),
        _buildTextField(
          controller: _nameController,
          hint: 'Your Full Name',
          label: 'From',
          icon: Icons.person_outline,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _recipientController,
          hint: 'Recipient Full Name / Organization',
          label: 'To',
          icon: Icons.business,
        ),
      ],
    );
  }

  Widget _buildStandardTermsToggle() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: AppColors.primaryBlue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 12),
              ),
              const SizedBox(width: 12),
              const Text(
                'Standard Terms',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.textDark,
                ),
              ),
              const Spacer(),
              Switch(
                value: true,
                onChanged: (v) {},
                activeTrackColor: AppColors.primaryBlue,
                activeThumbColor: Colors.white,
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Includes 2 months security deposit, 5% annual increment, and standard maintenance clauses.',
            style: TextStyle(
              color: AppColors.textGrey,
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExtraInfoField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel(widget.draftType == DraftType.custom ? 'YOUR REQUIREMENTS' : 'EXTRA INFORMATION'),
        TextField(
          controller: _extraInfoController,
          maxLines: 5,
          decoration: InputDecoration(
            hintText: widget.draftType == DraftType.custom
                ? "Describe exactly what you need this document to say..."
                : "Any specific details you want to include? e.g. 'Parking spot included' or 'Strict no-pets policy'.",
            hintStyle: const TextStyle(color: AppColors.textGrey),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.primaryBlue),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppColors.textGrey,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildTextField({
    TextEditingController? controller,
    required String hint,
    String? label,
    IconData? icon,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textGrey,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
        ],
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey),
            prefixIcon: icon != null ? Icon(icon, color: Colors.grey) : null,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.primaryBlue),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: SizedBox(
        height: 56,
        child: ElevatedButton(
          onPressed: () async {
            // Show loading
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (ctx) => const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(color: Colors.white),
                    SizedBox(height: 16),
                    Text("Drafting your document...", style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: 16)),
                  ],
                ),
              ),
            );

            try {
              String parties;
              String terms;
              
              if (widget.draftType == DraftType.rentalAgreement) {
                parties = "Landlord: ${_landlordController.text}, Tenant: ${_tenantController.text}";
                terms = "Rent: ${_rentController.text}, Duration: $_durationValue $_durationUnit. Address: ${_landlordController.text}'s property.";
              } else {
                parties = "From: ${_nameController.text}, To: ${_recipientController.text}";
                terms = "Standard terms.";
              }

              final request = api.DraftGenerationRequest(
                draftType: _getTitle(),
                jurisdiction: 'India',
                keyParties: parties,
                keyTerms: terms,
                additionalInstructions: _extraInfoController.text,
              );

              final response = await main_app.client.ai.generateDraft(request);

              if (!context.mounted) return;
              Navigator.pop(context); // Hide loading

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => DraftEditorScreen(
                    title: response.title,
                    initialContent: response.content,
                  ),
                ),
              );
            } catch (e) {
              if (!context.mounted) return;
              Navigator.pop(context); // Hide loading
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to generate draft: $e')),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1A237E), // Dark blue from mockup
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Generate Draft',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.auto_awesome, color: Colors.white, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
