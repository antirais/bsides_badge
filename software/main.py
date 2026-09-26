import time

import machine

from badge_config import hardware_for
from badge_config import load_badge_config


time.sleep(0.1)
hardware = hardware_for(load_badge_config()["badge_version"])
if machine.RTC().memory() == b"wifi_fetch":
    import wifi_fetch  # noqa: F401
elif machine.Pin(hardware["select_pin"], machine.Pin.IN).value() == 0:
    print("Not starting main application")
else:
    import bsides  # noqa: F401
