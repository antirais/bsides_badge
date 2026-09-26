set shell := ["bash", "-c"]
set quiet

NAME := "BSides Tallin Badge"
DATE := "2026"
BADGE_VERSION := "2026"
PORT := "/dev/ttyACM0"

# this thing
help:
    #!/bin/bash
    echo -e "{{YELLOW}}[+] {{CYAN}}{{NAME}}{{YELLOW}} {{BLUE}}{{DATE}}{{NORMAL}}"
    echo -e "{{YELLOW}}[*] usage: {{GREEN}}just <target>{{NORMAL}}"
    just --list --list-heading "" --unsorted

# install and checks dependencies
init:
    #!/bin/bash
    uv run scripts/badge.py init

# upload only application files
upload badge-version=BADGE_VERSION:
    #!/bin/bash
    uv run scripts/badge.py upload --badge-version {{badge-version}} --port {{PORT}}

# erase the chip, flash that image, and upload the application
flash badge-version=BADGE_VERSION:
    #!/bin/bash
    uv run scripts/badge.py flash --badge-version {{badge-version}} --port {{PORT}}

# erase the chip, flash that image, and upload the application
wipe badge-version=BADGE_VERSION:
    #!/bin/bash
    uv run scripts/badge.py flash --wipe --badge-version {{badge-version}} --port {{PORT}}

# set or change the holder's name
name name:
    #!/bin/bash
    uv run scripts/badge.py name {{name}} --port {{PORT}}

# delete every file from the MicroPython filesystem (not recoverable)
delete:
    #!/bin/bash
    uv run scripts/badge.py delete --port {{PORT}}
