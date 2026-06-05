#!/bin/bash
TO_EMAIL="$NOTIFICATION_EMAIL"
SUBJECT="Pipeline Status: $JOB_NAME - Build #$BUILD_NUMBER"
BODY="Pipeline finished with status: $JOB_STATUS. See artifacts at $BUILD_URL"

# 1. Cria um arquivo de texto com o esqueleto do e-mail
cat <<EOF > email.txt
From: jenkins@projetos07.com
To: $TO_EMAIL
Subject: $SUBJECT

$BODY
EOF

# 2. Usa o curl para injetar o e-mail direto na porta 1025 do MailHog
curl smtp://mailhog:1025 --mail-from "jenkins@projetos07.com" --mail-rcpt "$TO_EMAIL" --upload-file email.txt

echo "Notificação processada via cURL!"
