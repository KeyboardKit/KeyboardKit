//
//  StandardSpeechRecognizer.swift
//  Demo
//
//  Created by Daniel Saidi on 2023-12-12.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import Speech
import KeyboardKitPro

import KeyboardKitPro
import Speech

public extension DictationSpeechRecognizer where Self == StandardSpeechRecognizer {

    static var standard: Self { .init() }
}

/// This class is copied from the online documentation.
public class StandardSpeechRecognizer: DictationSpeechRecognizer {

    public init() {}

    private var recognizer: SFSpeechRecognizer?
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var speechRecognizerTask: SFSpeechRecognitionTask?

    private typealias Err = Dictation.ServiceError

    public var authorizationStatus: Dictation.AuthorizationStatus {
        SFSpeechRecognizer.authorizationStatus().keyboardDictationStatus
    }

    public var supportedLocales: [Locale] {
        Array(SFSpeechRecognizer.supportedLocales())
    }

    public func requestDictationAuthorization() async throws -> Dictation.AuthorizationStatus {
        await withCheckedContinuation { continuation in
            SFSpeechRecognizer.requestAuthorization { status in
                continuation.resume(returning: status.keyboardDictationStatus)
            }
        }
    }

    public func resetDictationResult() async throws {}

    public func startDictation(
        with locale: Locale
    ) async throws {
        try await startDictation(
            with: locale,
            resultHandler: nil
        )
    }

    public func startDictation(
        with locale: Locale,
        resultHandler: ((Dictation.SpeechRecognizerResult) -> Void)?
    ) async throws {
        recognizer = SFSpeechRecognizer(locale: locale)
        guard let recognizer else { throw Err.missingSpeechRecognizer }
        request = SFSpeechAudioBufferRecognitionRequest()
        request?.shouldReportPartialResults = true
        guard let request else { throw Err.missingSpeechRecognitionRequest }
        speechRecognizerTask = recognizer.recognitionTask(with: request) {
            let result = Dictation.SpeechRecognizerResult(
                dictatedText: $0?.bestTranscription.formattedString,
                error: $1,
                isFinal: $0?.isFinal ?? true)
            resultHandler?(result)
        }
    }

    public func stopDictation() async throws {
        request?.endAudio()
        request = nil
        speechRecognizerTask?.cancel()
        speechRecognizerTask = nil
    }

    public func setupAudioEngineBuffer(_ buffer: AVAudioPCMBuffer) {
        request?.append(buffer)
    }
}
