import sys
import os

# pylint: disable=C0111
c = c  # noqa: F821 pylint: disable=E0602,C0103
config = config  # noqa: F821 pylint: disable=E0602,C0103

# load autoconfig.yml
config.load_autoconfig()

# register jmatrix
sys.path.append(os.path.join(sys.path[0], 'jmatrix'))
config.source("jmatrix/jmatrix/integrations/qutebrowser.py")

# gruvbox theme
config.source("theme/gruvbox-dark-medium.py")
