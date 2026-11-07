//
//  NFCManager.swift
//  PoCNFCAppClip
//
//  Created by Pedro Henrique Hossaka Teruel on 29/10/26.
//

import SwiftUI
import CoreNFC
import Combine

// A Classe NFCManager herda a Classe NSObject e adota dois protocolos: ObservableObject e NFCNDEFReaderSessionDelegate.
// ObservableObject: permite que a Classe NFCManager seja observada.
// NFCNDEFReaderSessionDelegate: permite o uso de métodos associados a leitura de um sinal NFC.
class NFCManager: NSObject, ObservableObject, NFCNDEFReaderSessionDelegate {

    // Published é uma propriedade que anuncia as mudanças nas variáveis, para que a View que esta observando a instancia altere.
    @Published var contentRead = "Nenhum livro identificado"
    @Published var scannedCode: String?

    //a variavel "session" guarda a sessão de leitura NFC (o objeto que conduz uma tentativa de leitura).
    // "?" indica que a sessão pode ser nil (não haver sessão)
    var session: NFCNDEFReaderSession?
    var pendingCode: String?

    func startReading() {
        // Verifica se o dispositivo permite leitura NFC antes de criar uma sessão
        guard NFCNDEFReaderSession.readingAvailable else {
            contentRead = "NFC indisponível neste dispositivo"
            return
        }
        // Limpeza dos resultados anteriores
        scannedCode = nil
        pendingCode = nil
        // Criação de uma sessão
        session = NFCNDEFReaderSession(
            delegate: self,
            queue: .main,
            invalidateAfterFirstRead: true
        )
        //delegate é o objeto que a sessão NFC chama para entregar o resultado da leitura
        //.main eh utilizado pois esses métodos alteram dados exibidos pela interface.
        //queue: .main escolhe onde os metodos do delegate são executados.

        // alertMessage define a mensagem que o sistema mostra ao usuário durante a leitura. begin() inicia a sessão NFC.
        session?.alertMessage =
            "Aproxime o iPhone da etiqueta NFC do livro."
        session?.begin()
        //se session contiver um objeto, chame begin(), e se for nil, não faça nada.
    }

    // Metodo que a sessão chama quando detecta mensagens na tag.
    func readerSession(
        _ session: NFCNDEFReaderSession,
        // quando uma sessão detectar mensagens NDEF, este método recebe a sessão e as mensagens detectadas
        didDetectNDEFs messages: [NFCNDEFMessage]
        //a sessão NFC passa os valor em messages quando chama o método.
        //[...] indica lista de mensagens
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
            contentRead = "Nenhuma Tag encontrada"
            return
        }

        pendingCode = code
        contentRead = "Tag encontrada: \(code)"

        print("Código NFC: \(code)")
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
