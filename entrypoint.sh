ipfs init
for f in /etc/ipfs/*; do
  cat "$f" | sh
done
ipfs daemon "$DAEMON_ARGS"
