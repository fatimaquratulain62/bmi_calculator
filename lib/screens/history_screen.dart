import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../core/utils/bmi_utils.dart';
import '../models/bmi_record.dart';
import '../providers/bmi_provider.dart';
import '../widgets/category_badge.dart';
import '../widgets/empty_state.dart';

/// Displays all saved BMI records with delete options.
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  Future<void> _confirmClearAll(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Clear All History',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
        ),
        content: Text(
          'This will permanently delete all your BMI records. Are you sure?',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      await context.read<BmiProvider>().clearHistory();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('History cleared')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final history = context.watch<BmiProvider>().history;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'History',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
        ),
        actions: [
          if (history.isNotEmpty)
            IconButton(
              tooltip: 'Clear all',
              icon: const Icon(Icons.delete_sweep_rounded),
              onPressed: () => _confirmClearAll(context),
            ),
        ],
      ),
      body: history.isEmpty
          ? const EmptyState(
              icon: Icons.history_rounded,
              title: 'No calculations yet',
              subtitle:
                  'Your BMI history will appear here after your first calculation.',
            )
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
              itemCount: history.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final record = history[index];
                return _HistoryCard(record: record);
              },
            ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final BmiRecord record;

  const _HistoryCard({required this.record});

  Future<void> _confirmDelete(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Delete Record',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
        content: Text('Remove this BMI record?', style: GoogleFonts.poppins()),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel')),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      await context.read<BmiProvider>().deleteRecord(record.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final color = BmiUtils.categoryColor(record.category);
    final dateStr = DateFormat('dd MMM yyyy, HH:mm').format(record.date);

    return Dismissible(
      key: Key(record.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(Icons.delete_rounded, color: Colors.white, size: 28),
      ),
      confirmDismiss: (_) async {
        return await showDialog<bool>(
              context: context,
              builder: (_) => AlertDialog(
                title: Text('Delete Record',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
                content: Text('Remove this BMI record?',
                    style: GoogleFonts.poppins()),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel')),
                  FilledButton(
                    onPressed: () => Navigator.pop(context, true),
                    style:
                        FilledButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text('Delete'),
                  ),
                ],
              ),
            ) ??
            false;
      },
      onDismissed: (_) =>
          context.read<BmiProvider>().deleteRecord(record.id),
      child: Card(
        color: cs.surfaceContainerHighest,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      dateStr,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline_rounded),
                    color: Colors.red.shade400,
                    iconSize: 20,
                    visualDensity: VisualDensity.compact,
                    onPressed: () => _confirmDelete(context),
                    tooltip: 'Delete',
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    record.bmi.toStringAsFixed(1),
                    style: GoogleFonts.poppins(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: color,
                      height: 1,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CategoryBadge(category: record.category),
                      const SizedBox(height: 4),
                      Text(
                        '${record.heightCm.toStringAsFixed(1)} cm · ${record.weightKg.toStringAsFixed(1)} kg',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
