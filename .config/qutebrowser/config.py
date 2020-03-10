import sys
import os
import pathlib
import urllib.request

# pylint: disable=C0111
c = c  # noqa: F821 pylint: disable=E0602,C0103
config = config  # noqa: F821 pylint: disable=E0602,C0103

# download greasemonkey scripts
try:
    src_path = os.path.dirname(os.path.abspath(__file__))
    greasemonkey_path = os.path.join(src_path, "greasemonkey")
    pathlib.Path(greasemonkey_path).mkdir(parents=True, exist_ok=True)
    with open(os.path.join(src_path, "greasemonkey-list")) as f:
        script_urls = [line.rstrip('\n') for line in f]
    for url in script_urls:
        split = url.split(",", 1)

        print(split)
        url = split[0].strip()
        filename = split[1].strip()
        file = pathlib.Path(os.path.join(greasemonkey_path, filename))
        if file.is_file() is False:
            with urllib.request.urlopen(url) as response, \
                    open(file, 'wb') as out_file:
                data = response.read()
                out_file.write(data)
except Exception:
    pass

# load autoconfig.yml
config.load_autoconfig()

# register jmatrix
sys.path.append(os.path.join(sys.path[0], 'jmatrix'))
config.source("jmatrix/jmatrix/integrations/qutebrowser.py")

# gruvbox theme
config.source("theme/gruvbox-dark-medium.py")
