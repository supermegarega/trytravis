#!/bin/bash
set -e

gcloud compute --project "infra-198011" instances create reddit-app \
  --zone "europe-west1-b" \
  --machine-type "g1-small" \
  --subnet "default" \
  --maintenance-policy "MIGRATE" \
  --min-cpu-platform "Automatic" \
  --tags "puma-server" \
  --image-family "reddit-full" \
  --image-project "infra-198011" \
  --boot-disk-size "10" \
  --boot-disk-type "pd-standard" \
  --boot-disk-device-name "reddit-app"


