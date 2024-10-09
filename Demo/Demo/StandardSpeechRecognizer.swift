//
//  StandardSpeechRecognizer.swift
//  Demo
//
//  Created by Daniel Saidi on 2023-12-12.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import Speech
import KeyboardKitPro

/// This class is copied from the documentation, and used to
/// perform dictation.
public class StandardSpeechRecognizer: DictationSpeechRecognizer {

    public init() {}

    public var supportedLocales: [Locale] {
        [
            .english, .arabic, .catalan, .croatian, .czech,
            .danish, .dutch, .dutch_belgium, .english_gb,
            .english_us, .finnish, .french, .french_belgium,
            .french_switzerland, .german, .german_austria,
            .german_switzerland, .greek, .hebrew, .hungarian,
            .indonesian, .italian, .malay, .norwegian, .polish,
            .portuguese, .portuguese_brazil, .romanian, .russian,
            .slovak, .spanish, .swedish, .turkish, .ukrainian
        ]
    }

    private var resultHandler: ResultHandler?
    private var speechRecognizer: SFSpeechRecognizer?
    private var speechRecognizerRequest: SFSpeechAudioBufferRecognitionRequest?
    private var speechRecognizerTask: SFSpeechRecognitionTask?
}

public extension StandardSpeechRecognizer {

    var authorizationStatus: Dictation.AuthorizationStatus {
        SFSpeechRecognizer.authorizationStatus().keyboardDictationStatus
    }

    func requestDictationAuthorization() async throws -> Dictation.AuthorizationStatus {
        await withCheckedContinuation { continuation in
            SFSpeechRecognizer.requestAuthorization { status in
                continuation.resume(returning: status.keyboardDictationStatus)
            }
        }
    }

    func resetDictationResult() async throws {}

    func startDictation(
        with config: Dictation.Configuration
    ) async throws {
        try await startDictation(with: config, resultHandler: nil)
    }

    func startDictation(
        with config: Dictation.Configuration,
        resultHandler: ResultHandler?
    ) async throws {
        guard let recognizer = setupSpeechRecognizer(for: config) else { throw Dictation.ServiceError.missingSpeechRecognizer }
        guard let request = setupSpeechRecognizerRequest() else { throw Dictation.ServiceError.missingSpeechRecognitionRequest }
        self.resultHandler = resultHandler
        setupSpeechRecognizerTask(for: recognizer, and: request)
    }

    func stopDictation() async throws {
        speechRecognizerRequest?.endAudio()
        speechRecognizerRequest = nil
        speechRecognizerTask?.cancel()
        speechRecognizerTask = nil
    }

    func setupAudioEngineBuffer(_ buffer: AVAudioPCMBuffer) {
        speechRecognizerRequest?.append(buffer)
    }
}

private extension StandardSpeechRecognizer {

    func setupSpeechRecognizer(for config: Dictation.Configuration) -> SFSpeechRecognizer? {
        let locale = Locale(identifier: config.localeId)
        speechRecognizer = SFSpeechRecognizer(locale: locale)
        return speechRecognizer
    }

    func setupSpeechRecognizerRequest() -> SFSpeechAudioBufferRecognitionRequest? {
        speechRecognizerRequest = SFSpeechAudioBufferRecognitionRequest()
        speechRecognizerRequest?.shouldReportPartialResults = true
        return speechRecognizerRequest
    }

    func setupSpeechRecognizerTask(
        for recognizer: SFSpeechRecognizer,
        and request: SFSpeechRecognitionRequest
    ) {
        speechRecognizerTask = recognizer.recognitionTask(with: request) { [weak self] in
            self?.handleTaskResult($0, error: $1)
        }
    }

    func handleTaskResult(_ result: SFSpeechRecognitionResult?, error: Error?) {
        let result = Dictation.SpeechRecognizerResult(
            dictatedText: result?.bestTranscription.formattedString,
            error: error,
            isFinal: result?.isFinal ?? true)
        resultHandler?(result)
    }
}
