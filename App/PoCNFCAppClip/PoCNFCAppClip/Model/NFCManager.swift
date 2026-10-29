//
//  NFCManager.swift
//  PoCNFCAppClip
//
//  Created by Pedro Henrique Hossaka Teruel on 29/10/26.
//

import SwiftUI
import CoreNFC
import Combine

class NFCManager: NSObject, ObservableObject, NFCNDEFReaderSessionDelegate {

    @Published var contentRead = "Nenhum livro identificado"
    @Published var scannedCode: String?

    var session: NFCNDEFReaderSession?
    var pendingCode: String?

    func startReading() {
        guard NFCNDEFReaderSession.readingAvailable else {
            contentRead = "NFC indisponível neste dispositivo"
            return
        }
        
        scannedCode = nil
        pendingCode = nil

        session = NFCNDEFReaderSession(
            delegate: self,
            queue: .main,
            invalidateAfterFirstRead: true
        )

        session?.alertMessage =
            "Aproxime o iPhone da etiqueta NFC do livro."

        session?.begin()
    }

    func readerSession(
        _ session: NFCNDEFReaderSession,
        didDetectNDEFs messages: [NFCNDEFMessage]
    ) {
        let code = messages
            .flatMap(\.records)
            .compactMap { registro -> String? in
                let (texto, _) = registro.wellKnownTypeTextPayload()

                if let texto {
                    return texto
                }

                return registro.wellKnownTypeURIPayload()?.absoluteString
            }
            .first?
            .trimmingCharacters(in: .whitespacesAndNewlines)

        guard let code, !code.isEmpty else {
            contentRead = "Nenhum texto ou URL encontrado"
            return
        }

        pendingCode = code
        contentRead = "Etiqueta encontrada: \(code)"

        print("Código NFC recebido: \(code)")
    }

    func readerSession(
        _ session: NFCNDEFReaderSession,
        didInvalidateWithError error: Error
    ) {
        self.session = nil
        defer { pendingCode = nil }

        if let nfcError = error as? NFCReaderError {
            switch nfcError.code {

            case .readerSessionInvalidationErrorFirstNDEFTagRead:
                guard let code = pendingCode else {
                    contentRead = "Etiqueta sem identificador válido"
                    return
                }

                contentRead = code
                scannedCode = code
                return

            case .readerSessionInvalidationErrorUserCanceled:
                contentRead = "Leitura cancelada"
                return

            default:
                break
            }
        }

        contentRead = "Erro: \(error.localizedDescription)"
    }
}
