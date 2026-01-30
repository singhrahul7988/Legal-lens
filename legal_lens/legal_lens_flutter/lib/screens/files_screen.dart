import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../core/theme/app_theme.dart';
import '../core/models/document_model.dart';
import '../core/services/document_repository.dart';
import 'analysis_screen.dart';

enum SortOption { newest, oldest, nameAsc, nameDesc }

class FilesScreen extends StatefulWidget {
  const FilesScreen({super.key});

  @override
  State<FilesScreen> createState() => _FilesScreenState();
}

class _FilesScreenState extends State<FilesScreen> {
  String _searchQuery = '';
  String _selectedFilter = 'All'; // All, Analyzed, Pending
  SortOption _sortOption = SortOption.newest;
  
  @override
  void initState() {
    super.initState();
    DocumentRepository().addListener(_onRepositoryUpdate);
  }

  @override
  void dispose() {
    DocumentRepository().removeListener(_onRepositoryUpdate);
    super.dispose();
  }

  void _onRepositoryUpdate() {
    if (mounted) setState(() {});
  }

  List<DocumentModel> get _filteredDocuments {
    final docs = DocumentRepository().documents;
    final filtered = docs.where((doc) {
      final matchesSearch = doc.name.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesFilter = _selectedFilter == 'All' ||
          (_selectedFilter == 'Analyzed' && doc.status == DocumentStatus.analyzed) ||
          (_selectedFilter == 'Pending' && doc.status != DocumentStatus.analyzed);
      return matchesSearch && matchesFilter;
    }).toList();

    filtered.sort((a, b) {
      switch (_sortOption) {
        case SortOption.newest:
          return b.uploadDate.compareTo(a.uploadDate);
        case SortOption.oldest:
          return a.uploadDate.compareTo(b.uploadDate);
        case SortOption.nameAsc:
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        case SortOption.nameDesc:
          return b.name.toLowerCase().compareTo(a.name.toLowerCase());
      }
    });

    return filtered;
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Sort By',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.access_time),
            title: const Text('Newest First'),
            trailing: _sortOption == SortOption.newest ? const Icon(Icons.check, color: AppColors.primaryBlue) : null,
            onTap: () {
              setState(() => _sortOption = SortOption.newest);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Oldest First'),
            trailing: _sortOption == SortOption.oldest ? const Icon(Icons.check, color: AppColors.primaryBlue) : null,
            onTap: () {
              setState(() => _sortOption = SortOption.oldest);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.sort_by_alpha),
            title: const Text('Name (A-Z)'),
            trailing: _sortOption == SortOption.nameAsc ? const Icon(Icons.check, color: AppColors.primaryBlue) : null,
            onTap: () {
              setState(() => _sortOption = SortOption.nameAsc);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.sort_by_alpha),
            title: const Text('Name (Z-A)'),
            trailing: _sortOption == SortOption.nameDesc ? const Icon(Icons.check, color: AppColors.primaryBlue) : null,
            onTap: () {
              setState(() => _sortOption = SortOption.nameDesc);
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _deleteDocument(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Document?'),
        content: const Text('This action cannot be undone. All analysis and chat history will be lost.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              DocumentRepository().deleteDocument(id);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Document deleted')),
              );
            },
            child: const Text('Delete', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }

  void _openDocument(DocumentModel doc) {
    // Navigate to AnalysisScreen which handles both Analyzed (view results) and Uploaded (perform analysis) states
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AnalysisScreen(existingDocId: doc.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final docs = _filteredDocuments;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'My Files',
          style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textDark),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: _showSortOptions,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildFilterChips(),
          Expanded(
            child: docs.isEmpty
                ? _buildEmptyState()
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: docs.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return _buildFileCard(docs[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: TextField(
        onChanged: (value) => setState(() => _searchQuery = value),
        decoration: InputDecoration(
          hintText: 'Search documents...',
          prefixIcon: const Icon(Icons.search, color: AppColors.textGrey),
          filled: true,
          fillColor: AppColors.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      height: 50,
      color: Colors.white,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildFilterChip('All'),
          const SizedBox(width: 8),
          _buildFilterChip('Analyzed'),
          const SizedBox(width: 8),
          _buildFilterChip('Pending'),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) setState(() => _selectedFilter = label);
      },
      selectedColor: AppColors.primaryBlue.withValues(alpha: 0.1),
      labelStyle: TextStyle(
        color: isSelected ? AppColors.primaryBlue : AppColors.textGrey,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      backgroundColor: AppColors.surface,
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.folder_open, size: 64, color: AppColors.textGrey.withValues(alpha: 0.5)),
          const SizedBox(height: 16),
          Text(
            _searchQuery.isEmpty ? 'No documents yet' : 'No matching documents',
            style: const TextStyle(fontSize: 18, color: AppColors.textGrey, fontWeight: FontWeight.w500),
          ),
          if (_searchQuery.isEmpty) ...[
            const SizedBox(height: 8),
            const Text(
              'Upload a document to get started',
              style: TextStyle(color: AppColors.textGrey),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFileCard(DocumentModel doc) {
    return Dismissible(
      key: Key(doc.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
         _deleteDocument(doc.id);
         return false; // Let the dialog handle deletion
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: AppColors.error,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: InkWell(
        onTap: () => _openDocument(doc),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              _buildFileIcon(doc),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doc.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.textDark,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${DateFormat('MMM d, yyyy').format(doc.uploadDate)} • ${_formatSize(doc.size)}',
                      style: const TextStyle(fontSize: 12, color: AppColors.textGrey),
                    ),
                    const SizedBox(height: 8),
                    _buildStatusBadge(doc.status),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.textGrey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFileIcon(DocumentModel doc) {
    IconData icon;
    Color color;
    
    if (doc.type == DocumentType.rentalAgreement) {
      icon = Icons.home_work;
      color = AppColors.primaryBlue;
    } else if (doc.type == DocumentType.hospitalBill) {
      icon = Icons.local_hospital;
      color = AppColors.error;
    } else {
      icon = Icons.description;
      color = AppColors.secondaryGold;
    }

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: color),
    );
  }

  Widget _buildStatusBadge(DocumentStatus status) {
    Color color;
    String text;
    
    switch (status) {
      case DocumentStatus.analyzed:
        color = AppColors.success;
        text = 'Analyzed';
        break;
      case DocumentStatus.analyzing:
        color = AppColors.primaryBlue;
        text = 'Analyzing...';
        break;
      case DocumentStatus.error:
        color = AppColors.error;
        text = 'Error';
        break;
      default:
        color = AppColors.textGrey;
        text = 'Uploaded';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _formatSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}
