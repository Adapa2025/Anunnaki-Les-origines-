#!/usr/bin/env python3
import sys
try:
    import whisper
    model = whisper.load_model("base", device="cpu")
    result = model.transcribe(sys.argv[1], language="fr", verbose=False)
    with open(sys.argv[1].replace('.wav', '.txt'), 'w', encoding='utf-8') as f:
        f.write(result['text'])
    print(f"✓ Transcription saved to {sys.argv[1].replace('.wav', '.txt')}")
except Exception as e:
    print(f"Error: {e}", file=sys.stderr)
    sys.exit(1)
