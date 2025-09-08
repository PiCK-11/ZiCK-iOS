import AVFoundation
import UIKit

struct QrReceiveResult {
    
    let success: Bool
    
}

protocol CafeteriaScanViewControllerDelegate {
    
    func qrReceived(viewController: CafeteriaScanViewController, message: String) async -> QrReceiveResult
    
}

class CafeteriaScanViewController: UIViewController {
    
    var delegate: CafeteriaScanViewControllerDelegate?
    
    struct ScanEntry: Hashable {
        let message: String
        let ttl: Date
    }
    
    var scanEntries = Set<ScanEntry>()
    
    init(delegate: CafeteriaScanViewControllerDelegate? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeCaptureSession()
        configureCaptureUI()
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let captureSession, !captureSession.isRunning {
            DispatchQueue.global().async {
                captureSession.startRunning()
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if let captureSession, captureSession.isRunning {
            captureSession.stopRunning()
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
    
    // MARK: - scan
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    func initializeCaptureSession() {
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            print("no capture device")
            return
        }
        
        let videoInput: AVCaptureDeviceInput
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            print("no device input")
            return
        }
        
        guard captureSession.canAddInput(videoInput) else {
            failed()
            return
        }
        captureSession.addInput(videoInput)

        let metadataOutput = AVCaptureMetadataOutput()
        
        guard captureSession.canAddOutput(metadataOutput) else {
            failed()
            return
        }
        
        captureSession.addOutput(metadataOutput)
        
        metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        metadataOutput.metadataObjectTypes = [.qr]
    }
    
    func configureCaptureUI() {
        view.backgroundColor = .systemBackground
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
    }
    
    func failed() {
        let ac = UIAlertController(title: "QR 스캔 실패", message: "현재 기기가 QR 스캔을 지원하지 않습니다.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "확인", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    // MARK: - UI
    
    private lazy var toaster = ToastView()
    
    func configureUI() {
        view.addSubview(toaster)
        toaster.topToSuperview(offset: 32, usingSafeArea: true)
        toaster.centerXToSuperview()
        toaster.widthToSuperview(multiplier: 0.6)
    }

}

extension CafeteriaScanViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        for metadataObject in metadataObjects {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else {
                return
            }
            guard let stringValue = readableObject.stringValue else {
                return
            }
            
            if let existingEntry = scanEntries.filter({ $0.message == stringValue }).first {
                if Date() >= existingEntry.ttl {
                    scanEntries.remove(existingEntry)
                } else {
                    return
                }
            }
            
            let scanEntry = ScanEntry(message: stringValue, ttl: Date() + 10)
            scanEntries.insert(scanEntry)
            print(scanEntry)
            
            Task {
                guard let result = await delegate?.qrReceived(viewController: self, message: stringValue) else {
                    return
                }
                toaster.text = result.success ? "인식 성공" : "인식 실패"
                toaster.accent = result.success ? .systemGreen : .systemRed
            }
        }
    }
}
