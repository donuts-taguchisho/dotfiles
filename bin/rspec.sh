#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title rspec
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "File Name" }

# Documentation:
# @raycast.author tgc282278
# @raycast.authorURL https://raycast.com/tgc282278

cd ~/dev/jbc_id && docker compose exec app bin/rspec $1
