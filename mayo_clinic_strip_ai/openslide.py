from abcli import *
from abcli import file
from abcli import string
import matplotlib.pyplot as plt
from openslide import OpenSlide
from pprint import pprint
from abcli.logging import crash_report
from abcli import logging
import logging

logger = logging.getLogger(__name__)


def read_region(
    filename,
    region=(0, 0),
    level=0,
    size=(5000, 5000),
    log_level=log_level,
    plot_level=plot_level,
):
    try:
        slide = OpenSlide(filename)
    except:
        crash_report(f"-mcsai: openslide: read_region: {filename}.")
        return False, None

    logger.info(
        "mcsai.openslide.read_region({}): {}, {} level(s), {} level dimension(s) - {}".format(
            filename,
            slide.dimensions,
            slide.level_count,
            slide.level_dimensions,
            string.pretty_bytes(file.size(filename)),
        )
    )

    if log_level > LOG_ON:
        pprint(dict(slide.properties))

    try:
        image = slide.read_region(region, level, size)
    except:
        crash_report(f"-mcsai: openslide: read_region: {filename}.")
        return False, None

    if plot_level > PLOT_ON:
        plt.figure(figsize=(10, 10))
        plt.imshow(image)
        plt.axis("off")
        plt.show()

    return True, image
