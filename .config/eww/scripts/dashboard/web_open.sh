#!/bin/bash
cmd="firefox --new-tab"

case "$1" in
--gh) $cmd "https://github.com" ;;
--ig) $cmd "https://instagram.com" ;;
--wa) $cmd "https://whatsapp.com/" ;;
--mail) $cmd "https://mail.google.com" ;;
--inc) firefox --private-window ;;
esac
