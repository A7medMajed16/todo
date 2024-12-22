import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerBottomSheet extends StatefulWidget {
  final Function(String) onQRCodeScanned;

  const QRScannerBottomSheet({
    super.key,
    required this.onQRCodeScanned,
  });

  static Future<void> show(
      BuildContext context, Function(String) onQRCodeScanned) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          QRScannerBottomSheet(onQRCodeScanned: onQRCodeScanned),
    );
  }

  @override
  State<QRScannerBottomSheet> createState() => _QRScannerBottomSheetState();
}

class _QRScannerBottomSheetState extends State<QRScannerBottomSheet> {
  late MobileScannerController controller;
  bool isScanning = true;
  bool isFlashOn = false;
  bool isFrontCamera = false;
  @override
  void initState() {
    controller = MobileScannerController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Bottom sheet handle
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          // Title
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Scan QR Code',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Scanner
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: MobileScanner(
                  controller: controller,
                  onDetect: (capture) {
                    final List<Barcode> barcodes = capture.barcodes;
                    if (barcodes.isNotEmpty && isScanning) {
                      isScanning = false;
                      final String code = barcodes.first.rawValue ?? '';
                      widget.onQRCodeScanned(code);
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ),
          ),
          // Controls
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    isFlashOn ? Icons.flash_on : Icons.flash_off,
                  ),
                  onPressed: () async {
                    await controller.toggleTorch();
                    setState(() {
                      isFlashOn = !isFlashOn;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(
                    isFrontCamera ? Icons.camera_front : Icons.camera_rear,
                  ),
                  onPressed: () async {
                    await controller.switchCamera();
                    setState(() {
                      isFrontCamera = !isFrontCamera;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
