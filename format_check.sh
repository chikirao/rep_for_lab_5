#!/bin/bash
set -e

bad=0

files=$(find . -type f -name "*.txt" -not -path "./.git/*")

for f in $files; do
  # 1) Проверка: есть ли хотя бы одна буква "Z" (латиница, заглавная)
  if ! grep -q "Z" "$f"; then
    echo "ERROR: In file $f there is no кириллическая буква 'Z'"
    bad=1
  fi

  # 2) Проверка: есть ли слово "Кимпинтяу" без учета регистра
  # -i: ignore case
  # -w: match whole word
  if ! grep -qi -w "Кимпинтяу" "$f"; then
    echo "ERROR: In file $f there is no word 'Кимпинтяу' (case-insensitive)"
    bad=1
  fi
done

if [ "$bad" -ne 0 ]; then
  echo "Check failed. Fix .txt files and try commit again."
  exit 1
fi

echo "Check OK."
exit 0
