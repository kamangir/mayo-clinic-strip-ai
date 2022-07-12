import argparse
from . import *
from abcli.logging import crash_report
from abcli import logging
import logging

logger = logging.getLogger(__name__)

parser = argparse.ArgumentParser(name, description=f"{name}-{version}")
parser.add_argument(
    "task",
    type=str,
    help="validate",
)
args = parser.parse_args()

success = False
if args.task == "validate":
    success = True
    try:
        from openslide import OpenSlide
        import openslide

        logger.info(f"openslide-{openslide.__version__}")
    except:
        crash_report()
        success = False
else:
    logger.error(f"-{name}: {args.task}: command not found.")

if not success:
    logger.error(f"-{name}: {args.task}: failed.")
