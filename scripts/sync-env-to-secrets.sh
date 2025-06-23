#!/bin/bash
set -e

# ENV_FILE=".env.serverless"
ENV_FILE="$(dirname "$0")/../.env.serverless"
PROJECT_ID=$(gcloud config get-value project)

echo "[INFO] Syncing secrets from $ENV_FILE to Secret Manager (project: $PROJECT_ID)"

while IFS='=' read -r key value; do
  if [[ "$key" =~ ^[A-Z_][A-Z0-9_]*$ && -n "$value" ]]; then
    echo "[INFO] Processing secret: $key = $value"

    if gcloud secrets describe "$key" --project="$PROJECT_ID" >/dev/null 2>&1; then
      echo -n "$value" | gcloud secrets versions add "$key" --data-file=- --project="$PROJECT_ID"
    else
      echo -n "$value" | gcloud secrets create "$key" \
        --replication-policy="automatic" \
        --data-file=- \
        --project="$PROJECT_ID"
    fi
  fi
done < "$ENV_FILE"

PROJECT_ID=$(gcloud config get-value project)
PROJECT_NUMBER=$(gcloud projects describe "$PROJECT_ID" --format="value(projectNumber)")
CLOUDBUILD_SA="$PROJECT_NUMBER@cloudbuild.gserviceaccount.com"

# gcloud projects add-iam-policy-binding "$PROJECT_ID" \
#   --member="serviceAccount:$CLOUDBUILD_SA" \
#   --role="roles/secretmanager.secretAccessor"

# gcloud projects add-iam-policy-binding "$PROJECT_ID" \
#   --member="serviceAccount:$CLOUDBUILD_SA" \
#   --role="roles/firebasehosting.admin"

# gcloud projects add-iam-policy-binding "$PROJECT_ID" \
#   --member="serviceAccount:$CLOUDBUILD_SA" \
#   --role="roles/serviceusage.serviceUsageConsumer"


echo "[INFO] Done uploading secrets."
