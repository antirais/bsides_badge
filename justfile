set shell := ["bash", "-c"]
set quiet

NAME := "BSides Tallin Badge"
DATE := "2026"
BADGE_VERSION := "2026"
DEVICE := "/dev/ttyACM0"

# this thing
help:
    #!/bin/bash
    echo -e "{{YELLOW}}[+] {{CYAN}}{{NAME}}{{YELLOW}} {{BLUE}}{{DATE}}{{NORMAL}}"
    echo -e "{{YELLOW}}[*] usage: {{GREEN}}just <target>{{NORMAL}}"
    just --list --list-heading "" --unsorted

# starts MicroPython shell
shell:
    #!/bin/bash
    uv run mpremote repl

# format MarkDown files
rumdl:
    #!/bin/bash
    uv run rumdl fmt

# install and checks dependencies
init:
    #!/bin/bash
    uv run scripts/badge.py init

# upload only application files
upload badge-version=BADGE_VERSION:
    #!/bin/bash
    uv run scripts/badge.py upload --badge-version {{badge-version}} --port {{DEVICE}}

# erase the chip, flash that image, and upload the application - restores previous settings
flash badge-version=BADGE_VERSION:
    #!/bin/bash
    uv run scripts/badge.py flash --badge-version {{badge-version}} --port {{DEVICE}}

# erase the chip, flash that image, and upload the application - does not restore previous settings
wipe badge-version=BADGE_VERSION:
    #!/bin/bash
    uv run scripts/badge.py flash --wipe --badge-version {{badge-version}} --port {{DEVICE}}

# set or change the holder's name
name name:
    #!/bin/bash
    uv run scripts/badge.py name {{name}} --port {{DEVICE}}

# delete every file from the MicroPython filesystem (not recoverable)
delete:
    #!/bin/bash
    uv run scripts/badge.py delete --port {{DEVICE}}

# reads badge.json on the badge filesystem
badge-config:
    #!/bin/bash
    uv run mpremote fs cat badge.json | yq -y
