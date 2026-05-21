#!/bin/bash
# fal.ai gpt-image-1 image generator (queue + poll pattern).
# Args: <image_size> <prompt_file> <out_png>
#   image_size: square_hd | landscape_16_9 | portrait_16_9
set -euo pipefail

SIZE="$1"
PROMPT_FILE="$2"
OUT_PNG="$3"

FAL_KEY=$(secret get fal.api_key)

# Build JSON payload via python (clean escaping)
PAYLOAD_FILE=$(mktemp)
PROMPT_TEXT="$(cat "$PROMPT_FILE")" SIZE_VAL="$SIZE" python3 - <<'PY' > "$PAYLOAD_FILE"
import json, os
print(json.dumps({
    "prompt": os.environ["PROMPT_TEXT"],
    "image_size": os.environ["SIZE_VAL"],
    "num_images": 1,
    "output_format": "png",
    "quality": "high",
}))
PY

# Submit job
RESP=$(curl -sS -X POST "https://queue.fal.run/openai/gpt-image-2" \
  -H "Authorization: Key $FAL_KEY" \
  -H "Content-Type: application/json" \
  --data-binary @"$PAYLOAD_FILE")
rm -f "$PAYLOAD_FILE"

RID=$(echo "$RESP" | python3 -c "import sys,json; print(json.load(sys.stdin).get('request_id',''))" 2>/dev/null || echo "")
STATUS_URL=$(echo "$RESP" | python3 -c "import sys,json; print(json.load(sys.stdin).get('status_url',''))" 2>/dev/null || echo "")
RESULT_URL=$(echo "$RESP" | python3 -c "import sys,json; print(json.load(sys.stdin).get('response_url',''))" 2>/dev/null || echo "")
if [ -z "$RID" ] || [ -z "$STATUS_URL" ] || [ -z "$RESULT_URL" ]; then
    echo "[fal] submit failed: $RESP" >&2
    exit 1
fi
echo "[fal] queued $(basename "$OUT_PNG") request_id=$RID" >&2
for i in $(seq 1 80); do
    STATUS_JSON=$(curl -sS "$STATUS_URL" -H "Authorization: Key $FAL_KEY")
    STATUS=$(echo "$STATUS_JSON" | python3 -c "import sys,json; print(json.load(sys.stdin).get('status','UNKNOWN'))" 2>/dev/null || echo "UNKNOWN")
    if [ "$STATUS" = "COMPLETED" ]; then
        break
    elif [ "$STATUS" = "FAILED" ] || [ "$STATUS" = "ERROR" ]; then
        echo "[fal] $(basename "$OUT_PNG") FAILED status=$STATUS json=$STATUS_JSON" >&2
        exit 2
    fi
    sleep 3
done

# Fetch result
RESULT=$(curl -sS "$RESULT_URL" -H "Authorization: Key $FAL_KEY")
URL=$(echo "$RESULT" | python3 -c "import sys,json; r=json.load(sys.stdin); imgs=r.get('images') or []; print(imgs[0].get('url','') if imgs else '')" 2>/dev/null || echo "")
if [ -z "$URL" ]; then
    echo "[fal] no image URL in result: $RESULT" >&2
    exit 3
fi
curl -sSL "$URL" -o "$OUT_PNG"
SZ=$(stat -f %z "$OUT_PNG" 2>/dev/null || echo 0)
echo "[fal] wrote $OUT_PNG ($SZ bytes)"
