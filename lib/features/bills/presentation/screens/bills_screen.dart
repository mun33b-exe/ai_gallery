import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_shadows.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../data/mock_bills_repository.dart';
import '../../domain/bill_receipt.dart';
import '../../domain/receipt_radar_summary.dart';

class BillsScreen extends StatefulWidget {
  const BillsScreen({super.key, this.repository = const MockBillsRepository()});

  final BillsRepository repository;

  // Preserved for backwards compatibility with any existing test suites
  static final List<Map<String, String>> mockBills = [
    {
      'title': 'Electricity Utility Bill',
      'date': 'Due in 3 days',
      'amount': 'PKR 8,450',
      'status': 'Pending Review',
    },
    {
      'title': 'High-Speed Fiber Internet',
      'date': 'Due Oct 15',
      'amount': 'PKR 3,200',
      'status': 'Scheduled',
    },
    {
      'title': 'Supermarket Grocery Invoice',
      'date': 'Oct 3, 2026',
      'amount': 'PKR 5,120',
      'status': 'Extracted',
    },
    {
      'title': 'Fuel Receipt #882',
      'date': 'Oct 1, 2026',
      'amount': 'PKR 4,000',
      'status': 'Extracted',
    },
  ];

  @override
  State<BillsScreen> createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
  ReceiptRadarSummary? _summary;
  List<BillReceipt> _allReceipts = [];
  bool _isLoading = true;
  int _selectedFilterIndex = 0; // 0: All, 1: 1BILL Invoices, 2: Raast Transfers

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final summary = await widget.repository.fetchReceiptRadarSummary();
    final receipts = await widget.repository.fetchBills();
    if (mounted) {
      setState(() {
        _summary = summary;
        _allReceipts = receipts;
        _isLoading = false;
      });
    }
  }

  List<BillReceipt> get _filteredReceipts {
    if (_selectedFilterIndex == 1) {
      return _allReceipts
          .where((r) => r.providerName.toLowerCase().contains('1bill'))
          .toList();
    }
    if (_selectedFilterIndex == 2) {
      return _allReceipts
          .where((r) => r.providerName.toLowerCase().contains('raast'))
          .toList();
    }
    return _allReceipts;
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = Responsive.horizontalPadding(context);
    final cardRadius = Responsive.spacing(context, 20, min: 16, max: 24);
    final sectionGap = Responsive.spacing(context, 12, min: 10, max: 16);

    return AppScaffold(
      showBlueprintBanner: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          Responsive.spacing(context, 58, min: 54, max: 64),
        ),
        child: _buildTopAppBar(context),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.primaryGreen,
                ),
              ),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.only(
                left: horizontalPadding,
                right: horizontalPadding,
                top: Responsive.spacing(context, 8, min: 6, max: 12),
                bottom: Responsive.spacing(context, 100, min: 90, max: 115),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 1. Monthly Outflow Header Card (Donut + Metrics + Splits)
                  if (_summary != null)
                    _buildSummaryCard(context, _summary!, cardRadius),
                  SizedBox(height: sectionGap),

                  // 2. Category Filter Tabs
                  _buildCategoryFilterTabs(context),
                  SizedBox(height: sectionGap),

                  // 4. Interactive Receipt Cards (Dark OCR Map Previews)
                  ..._filteredReceipts.map((receipt) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: sectionGap),
                      child: _buildReceiptCard(context, receipt, cardRadius),
                    );
                  }),

                  // 5. Footer Trust Badge
                  _buildFooterTrustBadge(context, cardRadius),
                ],
              ),
            ),
    );
  }

  // ---------------------------------------------------------------------------
  // 1. Top App Bar
  // ---------------------------------------------------------------------------
  Widget _buildTopAppBar(BuildContext context) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final titleSize = Responsive.fontSize(
      context,
      designSize: isIOS ? 17 : 18,
      min: 16,
      max: 20,
    );

    return SafeArea(
      bottom: false,
      child: Container(
        height: Responsive.spacing(context, 58, min: 54, max: 64),
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.horizontalPadding(context),
        ),
        decoration: BoxDecoration(
          color: AppColors.background,
          border: Border(
            bottom: BorderSide(
              color: AppColors.border.withValues(alpha: 0.6),
              width: 1,
            ),
          ),
        ),
        child: Align(
          alignment: isIOS ? Alignment.center : Alignment.centerLeft,
          child: Text(
            'Receipt Radar',
            textAlign: isIOS ? TextAlign.center : TextAlign.start,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: titleSize,
              fontWeight: isIOS ? FontWeight.w600 : FontWeight.w700,
              color: AppColors.textPrimary,
              letterSpacing: isIOS ? -0.4 : -0.3,
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 2. Summary & Monthly Outflow Header Card
  // ---------------------------------------------------------------------------
  Widget _buildSummaryCard(
    BuildContext context,
    ReceiptRadarSummary summary,
    double cardRadius,
  ) {
    final donutSize = Responsive.spacing(context, 96, min: 84, max: 110);
    final cardPadding = Responsive.spacing(context, 14, min: 12, max: 18);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(cardRadius),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: AppShadows.card,
      ),
      padding: EdgeInsets.all(cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: Month selector
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Month selector dropdown
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.spacing(context, 10, min: 8, max: 12),
                  vertical: Responsive.spacing(context, 4, min: 3, max: 6),
                ),
                decoration: BoxDecoration(
                  color: AppColors.surfaceSubtle,
                  borderRadius: BorderRadius.circular(
                    Responsive.spacing(context, 12),
                  ),
                  border: Border.all(color: AppColors.border, width: 0.8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      summary.monthLabel,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: Responsive.fontSize(
                          context,
                          designSize: 12,
                          min: 11,
                          max: 13,
                        ),
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(width: Responsive.spacing(context, 4)),
                    Icon(
                      Icons.expand_more_rounded,
                      size: Responsive.iconSize(
                        context,
                        designSize: 14,
                        min: 12,
                        max: 16,
                      ),
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Responsive.spacing(context, 14, min: 10, max: 18)),

          // Donut Chart + Outflow Metric Block
          Row(
            children: [
              // Circular Donut Progress
              SizedBox(
                width: donutSize,
                height: donutSize,
                child: CustomPaint(
                  painter: _DonutChartPainter(splits: summary.categorySplits),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.verified_rounded,
                          size: Responsive.iconSize(
                            context,
                            designSize: 18,
                            min: 16,
                            max: 20,
                          ),
                          color: AppColors.primaryGreen,
                        ),
                        SizedBox(height: Responsive.spacing(context, 2)),
                        Text(
                          '${summary.totalSlips}',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: Responsive.fontSize(
                              context,
                              designSize: 14,
                              min: 12,
                              max: 16,
                            ),
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                            height: 1.1,
                          ),
                        ),
                        Text(
                          'SLIPS',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: Responsive.fontSize(
                              context,
                              designSize: 9,
                              min: 8,
                              max: 10,
                            ),
                            fontWeight: FontWeight.w700,
                            color: AppColors.textSecondary,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: Responsive.spacing(context, 14, min: 10, max: 18),
              ),

              // Metric block: PAID OUTFLOW + Mini Bar Chart
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PAID OUTFLOW',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: Responsive.fontSize(
                          context,
                          designSize: 11,
                          min: 10,
                          max: 12,
                        ),
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: Responsive.spacing(context, 2)),
                    Text(
                      summary.formattedOutflow,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: Responsive.fontSize(
                          context,
                          designSize: 22,
                          min: 19,
                          max: 25,
                        ),
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.4,
                      ),
                    ),
                    SizedBox(
                      height: Responsive.spacing(context, 8, min: 6, max: 12),
                    ),

                    // Mini Bar Chart Visualization
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildBar(
                          context,
                          heightFraction: summary.miniBarChartValues.isNotEmpty
                              ? summary.miniBarChartValues[0]
                              : 0.25,
                          color: const Color(0xFFE5E7EB),
                        ),
                        SizedBox(width: Responsive.spacing(context, 5)),
                        _buildBar(
                          context,
                          heightFraction: summary.miniBarChartValues.length > 1
                              ? summary.miniBarChartValues[1]
                              : 0.40,
                          color: const Color(0xFFE5E7EB),
                        ),
                        SizedBox(width: Responsive.spacing(context, 5)),
                        _buildBar(
                          context,
                          heightFraction: summary.miniBarChartValues.length > 2
                              ? summary.miniBarChartValues[2]
                              : 0.95,
                          color: AppColors.primaryGreen,
                        ),
                        SizedBox(width: Responsive.spacing(context, 5)),
                        _buildBar(
                          context,
                          heightFraction: summary.miniBarChartValues.length > 3
                              ? summary.miniBarChartValues[3]
                              : 0.95,
                          color: const Color(0xFF7DC5FF),
                        ),
                        SizedBox(width: Responsive.spacing(context, 6)),
                        Text(
                          "Jun '26",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: Responsive.fontSize(
                              context,
                              designSize: 10,
                              min: 9,
                              max: 11,
                            ),
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Responsive.spacing(context, 12, min: 10, max: 16)),

          // Category Split Breakdown Row
          Container(
            padding: EdgeInsets.only(
              top: Responsive.spacing(context, 10, min: 8, max: 12),
            ),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppColors.border.withValues(alpha: 0.7),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: summary.categorySplits.map((split) {
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      right: split == summary.categorySplits.last
                          ? 0
                          : Responsive.spacing(context, 8, min: 6, max: 10),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.spacing(
                        context,
                        8,
                        min: 6,
                        max: 10,
                      ),
                      vertical: Responsive.spacing(context, 6, min: 5, max: 8),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceSubtle,
                      borderRadius: BorderRadius.circular(
                        Responsive.spacing(context, 12, min: 10, max: 14),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: Responsive.spacing(
                            context,
                            8,
                            min: 7,
                            max: 10,
                          ),
                          height: Responsive.spacing(
                            context,
                            8,
                            min: 7,
                            max: 10,
                          ),
                          decoration: BoxDecoration(
                            color: split.color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(
                          width: Responsive.spacing(context, 6, min: 5, max: 8),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                split.name,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: Responsive.fontSize(
                                    context,
                                    designSize: 10,
                                    min: 9,
                                    max: 11,
                                  ),
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textSecondary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: Responsive.spacing(context, 2)),
                              Text(
                                'PKR ${split.amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: Responsive.fontSize(
                                    context,
                                    designSize: 12,
                                    min: 11,
                                    max: 13,
                                  ),
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar(
    BuildContext context, {
    required double heightFraction,
    required Color color,
  }) {
    final barMaxHeight = Responsive.spacing(context, 24, min: 20, max: 28);
    final barWidth = Responsive.spacing(context, 14, min: 12, max: 18);

    return Container(
      width: barWidth,
      height: barMaxHeight * heightFraction.clamp(0.2, 1.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Responsive.spacing(context, 4)),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 4. Category Filter Tabs
  // ---------------------------------------------------------------------------
  Widget _buildCategoryFilterTabs(BuildContext context) {
    final oneBillCount = _allReceipts
        .where((r) => r.providerName.toLowerCase().contains('1bill'))
        .length;
    final raastCount = _allReceipts
        .where((r) => r.providerName.toLowerCase().contains('raast'))
        .length;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          // Filter 0: All
          _buildFilterChip(
            context,
            index: 0,
            label: 'All',
            count: _allReceipts.length,
            icon: null,
          ),
          SizedBox(width: Responsive.spacing(context, 8)),

          // Filter 1: 1BILL Invoices
          _buildFilterChip(
            context,
            index: 1,
            label: '1BILL Invoices',
            count: oneBillCount,
            icon: Icons.receipt_long_rounded,
            iconColor: AppColors.primaryGreen,
          ),
          SizedBox(width: Responsive.spacing(context, 8)),

          // Filter 2: Raast Transfers
          _buildFilterChip(
            context,
            index: 2,
            label: 'Raast Transfers',
            count: raastCount,
            icon: Icons.swap_horiz_rounded,
            iconColor: const Color(0xFF006496),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context, {
    required int index,
    required String label,
    required int count,
    IconData? icon,
    Color? iconColor,
  }) {
    final isSelected = _selectedFilterIndex == index;
    final chipHeight = Responsive.spacing(context, 34, min: 30, max: 38);
    final fontSize = Responsive.fontSize(
      context,
      designSize: 12,
      min: 11,
      max: 13,
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedFilterIndex = index;
          });
        },
        borderRadius: BorderRadius.circular(Responsive.spacing(context, 20)),
        child: Container(
          height: chipHeight,
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.spacing(context, 10, min: 8, max: 14),
          ),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.textPrimary : AppColors.surface,
            borderRadius: BorderRadius.circular(
              Responsive.spacing(context, 20),
            ),
            border: Border.all(
              color: isSelected ? AppColors.textPrimary : AppColors.border,
              width: 1,
            ),
            boxShadow: isSelected ? AppShadows.subtle : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: Responsive.iconSize(
                    context,
                    designSize: 14,
                    min: 12,
                    max: 16,
                  ),
                  color: isSelected
                      ? Colors.white
                      : (iconColor ?? AppColors.textSecondary),
                ),
                SizedBox(width: Responsive.spacing(context, 5)),
              ],
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: fontSize,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                ),
              ),
              SizedBox(width: Responsive.spacing(context, 6)),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.spacing(context, 6, min: 5, max: 8),
                  vertical: Responsive.spacing(context, 1),
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withValues(alpha: 0.2)
                      : AppColors.surfaceSubtle,
                  borderRadius: BorderRadius.circular(
                    Responsive.spacing(context, 10),
                  ),
                ),
                child: Text(
                  '$count',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: Responsive.fontSize(
                      context,
                      designSize: 10,
                      min: 9,
                      max: 11,
                    ),
                    fontWeight: FontWeight.w700,
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 5. Interactive Receipt Cards (Dark OCR Map Previews)
  // ---------------------------------------------------------------------------
  Widget _buildReceiptCard(
    BuildContext context,
    BillReceipt receipt,
    double cardRadius,
  ) {
    final isOneBill = receipt.providerName.toLowerCase().contains('1bill');
    final typeIcon = isOneBill
        ? Icons.electric_bolt_rounded
        : Icons.swap_horiz_rounded;
    final typeIconBg = isOneBill
        ? AppColors.primaryGreenLight
        : const Color(0xFFCCE5FF);
    final typeIconColor = isOneBill
        ? AppColors.primaryGreenDark
        : const Color(0xFF006496);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(cardRadius),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: AppShadows.card,
      ),
      padding: EdgeInsets.all(
        Responsive.spacing(context, 12, min: 10, max: 16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Card Header: Type icon, Provider, Date, Method, Amount, Status
          Row(
            children: [
              // Icon Tile
              Container(
                width: Responsive.spacing(context, 38, min: 34, max: 42),
                height: Responsive.spacing(context, 38, min: 34, max: 42),
                decoration: BoxDecoration(
                  color: typeIconBg,
                  borderRadius: BorderRadius.circular(
                    Responsive.spacing(context, 12, min: 10, max: 14),
                  ),
                ),
                child: Icon(
                  typeIcon,
                  color: typeIconColor,
                  size: Responsive.iconSize(
                    context,
                    designSize: 20,
                    min: 18,
                    max: 22,
                  ),
                ),
              ),
              SizedBox(width: Responsive.spacing(context, 10, min: 8, max: 14)),

              // Title and Date/Method
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      receipt.providerName,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: Responsive.fontSize(
                          context,
                          designSize: 13,
                          min: 12,
                          max: 15,
                        ),
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: Responsive.spacing(context, 2)),
                    Row(
                      children: [
                        Text(
                          receipt.formattedDate,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: Responsive.fontSize(
                              context,
                              designSize: 11,
                              min: 10,
                              max: 12,
                            ),
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          ' • ',
                          style: TextStyle(
                            fontSize: Responsive.fontSize(
                              context,
                              designSize: 11,
                              min: 10,
                              max: 12,
                            ),
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            receipt.paymentMethod,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: Responsive.fontSize(
                                context,
                                designSize: 11,
                                min: 10,
                                max: 12,
                              ),
                              fontWeight: FontWeight.w600,
                              color: isOneBill
                                  ? AppColors.primaryGreenDark
                                  : const Color(0xFF006496),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Right Amount and Status Badge
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    receipt.formattedAmount,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: Responsive.fontSize(
                        context,
                        designSize: 14,
                        min: 13,
                        max: 16,
                      ),
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: Responsive.spacing(context, 3)),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.spacing(
                        context,
                        7,
                        min: 6,
                        max: 9,
                      ),
                      vertical: Responsive.spacing(context, 2),
                    ),
                    decoration: BoxDecoration(
                      color: isOneBill
                          ? AppColors.primaryGreenLight
                          : const Color(0xFFCCE5FF),
                      borderRadius: BorderRadius.circular(
                        Responsive.spacing(context, 12),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isOneBill
                              ? Icons.verified_rounded
                              : Icons.send_to_mobile_rounded,
                          size: Responsive.iconSize(
                            context,
                            designSize: 10,
                            min: 9,
                            max: 12,
                          ),
                          color: isOneBill
                              ? AppColors.primaryGreenDark
                              : const Color(0xFF004B72),
                        ),
                        SizedBox(width: Responsive.spacing(context, 3)),
                        Text(
                          receipt.status,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: Responsive.fontSize(
                              context,
                              designSize: 10,
                              min: 9,
                              max: 11,
                            ),
                            fontWeight: FontWeight.w700,
                            color: isOneBill
                                ? const Color(0xFF004D29)
                                : const Color(0xFF004B72),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: Responsive.spacing(context, 10, min: 8, max: 12)),

          // Visual Receipt Preview Box (High-contrast dark OCR map preview)
          _buildDarkReceiptPreview(context, receipt),
        ],
      ),
    );
  }

  Widget _buildDarkReceiptPreview(BuildContext context, BillReceipt receipt) {
    final previewHeight = Responsive.spacing(context, 116, min: 104, max: 128);
    final isOneBill = receipt.providerName.toLowerCase().contains('1bill');

    return Container(
      height: previewHeight,
      decoration: BoxDecoration(
        color: const Color(0xFF14191F), // High-contrast dark container
        borderRadius: BorderRadius.circular(
          Responsive.spacing(context, 12, min: 10, max: 14),
        ),
        border: Border.all(color: const Color(0xFF2E353D), width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Background subtle OCR visual simulation
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.spacing(context, 12),
                vertical: Responsive.spacing(context, 26),
              ),
              child: Opacity(
                opacity: 0.18,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'TRANSACTION AMOUNT: PKR ${receipt.amount.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        color: Colors.white,
                        fontSize: 9,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'ORIGIN ACCOUNT: *6703  •  SETTLEMENT: INSTANT',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        color: Colors.white,
                        fontSize: 9,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      receipt.accountTitle,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        color: Colors.white,
                        fontSize: 9,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Glowing scanline aesthetic
          Positioned(
            left: 0,
            right: 0,
            top: previewHeight * 0.45,
            child: Container(
              height: 1.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    isOneBill
                        ? AppColors.primaryGreen.withValues(alpha: 0.8)
                        : const Color(0xFF7DC5FF).withValues(alpha: 0.8),
                    Colors.transparent,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: isOneBill
                        ? AppColors.primaryGreen.withValues(alpha: 0.4)
                        : const Color(0xFF7DC5FF).withValues(alpha: 0.4),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
          ),

          // Top Row: Extracted OCR Snippet Pill & Stamp Indicator
          Positioned(
            top: Responsive.spacing(context, 8),
            left: Responsive.spacing(context, 8),
            right: Responsive.spacing(context, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // OCR Snippet Pill
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.spacing(context, 7, min: 6, max: 9),
                    vertical: Responsive.spacing(context, 3),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.65),
                    borderRadius: BorderRadius.circular(
                      Responsive.spacing(context, 6),
                    ),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.15),
                      width: 0.8,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.tag_rounded,
                        size: Responsive.iconSize(
                          context,
                          designSize: 11,
                          min: 10,
                          max: 13,
                        ),
                        color: isOneBill
                            ? AppColors.primaryGreen
                            : const Color(0xFF7DC5FF),
                      ),
                      SizedBox(width: Responsive.spacing(context, 3)),
                      Text(
                        receipt.ocrSnippet,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: Responsive.fontSize(
                            context,
                            designSize: 10,
                            min: 9,
                            max: 11,
                          ),
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                // Stamp Detector / Matched Badge
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.spacing(context, 8, min: 6, max: 10),
                    vertical: Responsive.spacing(context, 3),
                  ),
                  decoration: BoxDecoration(
                    color: isOneBill
                        ? const Color(0xFF10B981) // emerald stamp
                        : const Color(0xFF006496), // raast matched blue
                    borderRadius: BorderRadius.circular(
                      Responsive.spacing(context, 6),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isOneBill
                            ? Icons.verified_outlined
                            : Icons.check_circle_rounded,
                        size: Responsive.iconSize(
                          context,
                          designSize: 11,
                          min: 10,
                          max: 13,
                        ),
                        color: Colors.white,
                      ),
                      SizedBox(width: Responsive.spacing(context, 3)),
                      Text(
                        receipt.statusBadge,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: Responsive.fontSize(
                            context,
                            designSize: 9,
                            min: 8,
                            max: 10,
                          ),
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom Row: Account Title/ID & View Action Pill
          Positioned(
            bottom: Responsive.spacing(context, 8),
            left: Responsive.spacing(context, 8),
            right: Responsive.spacing(context, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Account Title / ID
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isOneBill
                          ? Icons.receipt_rounded
                          : Icons.account_circle_rounded,
                      size: Responsive.iconSize(
                        context,
                        designSize: 12,
                        min: 11,
                        max: 14,
                      ),
                      color: isOneBill
                          ? AppColors.primaryGreen
                          : const Color(0xFF7DC5FF),
                    ),
                    SizedBox(width: Responsive.spacing(context, 4)),
                    Text(
                      receipt.accountTitle,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: Responsive.fontSize(
                          context,
                          designSize: 10,
                          min: 9,
                          max: 11,
                        ),
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),

                // View Action Pill Button
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      final targetId =
                          receipt.associatedTransactionId ?? receipt.id;
                      context.go('${RouteNames.transactions}/$targetId');
                    },
                    borderRadius: BorderRadius.circular(
                      Responsive.spacing(context, 12),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Responsive.spacing(
                          context,
                          8,
                          min: 6,
                          max: 10,
                        ),
                        vertical: Responsive.spacing(context, 3),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(
                          Responsive.spacing(context, 12),
                        ),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.25),
                          width: 0.8,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.visibility_rounded,
                            size: Responsive.iconSize(
                              context,
                              designSize: 11,
                              min: 10,
                              max: 13,
                            ),
                            color: Colors.white,
                          ),
                          SizedBox(width: Responsive.spacing(context, 3)),
                          Text(
                            'View',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: Responsive.fontSize(
                                context,
                                designSize: 10,
                                min: 9,
                                max: 11,
                              ),
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 6. Footer Trust Badge
  // ---------------------------------------------------------------------------
  Widget _buildFooterTrustBadge(BuildContext context, double cardRadius) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.spacing(context, 12, min: 10, max: 14),
        vertical: Responsive.spacing(context, 10, min: 8, max: 12),
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceSubtle,
        borderRadius: BorderRadius.circular(cardRadius),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Row(
        children: [
          // Circular shield/lock container
          Container(
            width: Responsive.spacing(context, 32, min: 28, max: 36),
            height: Responsive.spacing(context, 32, min: 28, max: 36),
            decoration: BoxDecoration(
              color: AppColors.primaryGreen.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.lock_rounded,
              size: Responsive.iconSize(
                context,
                designSize: 17,
                min: 15,
                max: 19,
              ),
              color: AppColors.primaryGreenDark,
            ),
          ),
          SizedBox(width: Responsive.spacing(context, 10, min: 8, max: 12)),

          // Trust text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'On-Device Neural Processing',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: Responsive.fontSize(
                      context,
                      designSize: 12,
                      min: 11,
                      max: 13,
                    ),
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: Responsive.spacing(context, 1)),
                Text(
                  'Zero cloud uploads • Stored locally',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: Responsive.fontSize(
                      context,
                      designSize: 10,
                      min: 9,
                      max: 11,
                    ),
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Verified Icon
          Icon(
            Icons.verified_user_rounded,
            size: Responsive.iconSize(
              context,
              designSize: 20,
              min: 18,
              max: 22,
            ),
            color: AppColors.primaryGreen,
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Donut Chart CustomPainter
// -----------------------------------------------------------------------------
class _DonutChartPainter extends CustomPainter {
  const _DonutChartPainter({required this.splits});

  final List<CategorySplit> splits;

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = size.width * 0.12;
    final radius = (size.width - strokeWidth) / 2;
    final center = Offset(size.width / 2, size.height / 2);

    // Track circle (background)
    final bgPaint = Paint()
      ..color = const Color(0xFFECEEF0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, bgPaint);

    if (splits.isEmpty) return;

    var startAngle = -math.pi / 2; // Start from top

    for (final split in splits) {
      final sweepAngle = (split.percentage / 100.0) * 2 * math.pi;
      final splitPaint = Paint()
        ..color = split.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      // Draw arc slightly indented to prevent overlapping rounded caps
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle + 0.04,
        sweepAngle - 0.08,
        false,
        splitPaint,
      );

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant _DonutChartPainter oldDelegate) {
    return oldDelegate.splits != splits;
  }
}
