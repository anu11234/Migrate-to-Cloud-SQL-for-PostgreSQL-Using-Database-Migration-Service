
#!/bin/bash
set -e

# Prompt for the OAuth2 token generated from OAuth 2.0 Playground
read -p "Enter your OAuth2 Access Token: " OAUTH2_TOKEN
export OAUTH2_TOKEN

# Get current Project ID
export PROJECT_ID=$(gcloud config get-value project)
export BUCKET_NAME="${PROJECT_ID}-bucket"

echo "==> Setting up environment for Project: $PROJECT_ID"

# 1. Create values.json configuration
cat <<EOF > values.json
{
  "name": "${BUCKET_NAME}",
  "location": "us",
  "storageClass": "multi_regional"
}
EOF

# 2. Create Cloud Storage Bucket via REST API
echo "==> Creating Cloud Storage Bucket..."
curl -s -X POST --data-binary @values.json \
    -H "Authorization: Bearer $OAUTH2_TOKEN" \
    -H "Content-Type: application/json" \
    "https://www.googleapis.com/storage/v1/b?project=$PROJECT_ID"

echo -e "\n"

# 3. Create a demo image locally
echo "==> Generating demo image..."
echo "demo image content" > demo-image.png
export OBJECT=$(realpath demo-image.png)

# 4. Upload file to Cloud Storage Bucket via REST API
echo "==> Uploading demo-image.png to $BUCKET_NAME..."
curl -s -X POST --data-binary @$OBJECT \
    -H "Authorization: Bearer $OAUTH2_TOKEN" \
    -H "Content-Type: image/png" \
    "https://www.googleapis.com/upload/storage/v1/b/$BUCKET_NAME/o?uploadType=media&name=demo-image"

echo -e "\n\n==> Tasks completed! You can now click 'Check my progress' on the lab page."
insert into distribution_centers values(-80.1918, 25.7617, 'Miami FL', 11);
\q
```
