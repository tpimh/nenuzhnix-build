if [ "$TRAVIS" = "true" ]; then
  export FOLD_START="travis_fold:start:fold"
  export FOLD_END="\ntravis_fold:end:fold\r"
fi
