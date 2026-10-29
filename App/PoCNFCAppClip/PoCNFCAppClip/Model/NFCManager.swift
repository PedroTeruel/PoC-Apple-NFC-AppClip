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

    var session: NFCNDEFReaderSession?

    func startReading() {
        guard NFCNDEFReaderSession.readingAvailable else {
            contentRead = "NFC indisponível neste dispositivo"
            return
        }

        session = NFCNDEFReaderSession(
            delegate: self,
            queue: nil,
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
        let valores = messages
            .flatMap(\.records)
            .compactMap { registro -> String? in
                if let url = registro.wellKnownTypeURIPayload() {
                    return url.absoluteString
                }

                let (texto, _) = registro.wellKnownTypeTextPayload()
                return texto
            }

        let result = valores.joined(separator: "\n")

        DispatchQueue.main.async {
            self.contentRead = result.isEmpty
                ? "Nenhum texto ou URL encontrado"
                : result
        }
    }

    func readerSession(
        _ session: NFCNDEFReaderSession,
        didInvalidateWithError error: Error
    ) {
        DispatchQueue.main.async {
            self.session = nil

            if let nfcError = error as? NFCReaderError,
               nfcError.code == .readerSessionInvalidationErrorUserCanceled
                || nfcError.code == .readerSessionInvalidationErrorFirstNDEFTagRead {
                return
            }

            self.contentRead = "Erro: \(error.localizedDescription)"
        }
    }
}
