# type: ignore
import glob
import os
import sys

import yaml
from qutebrowser.config.config import ConfigContainer  # noqa: F401
from qutebrowser.config.configfiles import ConfigAPI  # noqa: F401

# pylint: disable=C0111
config = config  # type: ConfigAPI # noqa: F821 pylint: disable=E0602,C0103
c = c  # type: ConfigContainer # noqa: F821 pylint: disable=E0602,C0103

# no autoconfig
config.load_autoconfig(False)

# aliases
aliases = {'bw': 'spawn --userscript qute-bitwarden',
           'json': 'spawn --userscript format_json',
           'code': 'spawn --userscript format_code',
           'mpv': 'spawn --userscript view_in_mpv',
           'gr': 'greasemonkey-reload',
           'w': 'session-save',
           'wq': 'quit --save',
           'wqa': 'quit --save',
           'q': 'close',
           'qa': 'quit'}
for k, v in aliases.items():
    c.aliases[k] = v

# enable session autosaving
c.auto_save.session = True

# custom keybinds
config.bind('ch', 'history-clear')
config.bind('gy', 'edit-text')
config.bind('yf', 'hint link yank')
config.bind(',n', 'open -t ;; messages')
config.bind(',m', 'mpv')

# completion settings
c.completion.cmd_history_max_items = 0
c.completion.web_history.max_items = 0

# wait for downloads when quitting
c.confirm_quit = ['downloads']

# configure adblocking
c.content.blocking.method = 'both'
c.content.blocking.adblock.lists = [
    'https://easylist.to/easylist/easylist.txt',
    'https://easylist.to/easylist/easyprivacy.txt',
    'https://raw.githubusercontent.com/anudeepND/blacklist/master/adservers.txt',
    'https://blocklistproject.github.io/Lists/ads.txt',
    'https://blocklistproject.github.io/Lists/phishing.txt',
    'https://blocklistproject.github.io/Lists/tracking.txt',
    'https://raw.githubusercontent.com/quenhus/uBlock-Origin-dev-filter/main/dist/google_duckduckgo/all.txt'
]

# content settings
# disable autoplay
c.content.autoplay = False
# disable canvas, webgl, clipboard access
c.content.canvas_reading = False
c.content.webgl = False
c.content.javascript.can_access_clipboard = False
# disable geolocation
c.content.geolocation = False
# set common accept header
c.content.headers.accept_language = 'en-US,en;q=0.5'
c.content.headers.custom = {
    'accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
}

# set user agent string
c.content.headers.user_agent = (
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) '
    'AppleWebKit/537.36 (KHTML, like Gecko) '
    'Chrome/97.0.4692.99 Safari/537.36'
)
# enable pdfjs
c.content.pdfjs = True
# set webrtc policy
c.content.webrtc_ip_handling_policy = "default-public-interface-only"
# reject 3rd party cookies
c.content.cookies.accept = "no-3rdparty"

# per-domain styles
user_styles_dir = os.path.join(config.configdir, 'styles', '*.user.css')
c.content.user_stylesheets = glob.glob(user_styles_dir)

# editor command
c.editor.command = ['alacritty', '-e', 'nvim',
                    '{file}', '-c', 'normal {file}G{column0}l']

# default fonts
c.fonts.default_family = ['JetBrains Mono Nerd Font', 'Iosevka',
                          'Inconsolata', 'Fira Code', 'DejaVu Sans Mono']
c.fonts.default_size = '11pt'

# file selector
c.fileselect.handler = 'external'
c.fileselect.single_file.command = [
    'alacritty', '-e', 'ranger', '--choosefile={}']
c.fileselect.multiple_files.command = [
    'alacritty', '-e', 'ranger', '--choosefiles={}']

# QT hidpi fix
c.qt.highdpi = True

# enable smooth scrolling
c.scrolling.smooth = True

# pinned tabs not frozen
c.tabs.pinned.frozen = False

# use DuckDuckGo as default start page
c.url.default_page = 'https://start.duckduckgo.com/'
c.url.start_pages = 'https://start.duckduckgo.com/'

# load search engines
c.url.searchengines['DEFAULT'] = 'https://duckduckgo.com/?q={}'
# load local searchengines file if exists
try:
    with (config.configdir / 'searchengines.yaml').open() as f:
        yaml_data = yaml.safe_load(f)

        for k, v in yaml_data.items():
            c.url.searchengines[k] = v
except IOError:
    pass

# register jmatrix
JMATRIX_LOADED = "JMATRIX_LOADED"
if JMATRIX_LOADED not in os.environ:
    os.environ[JMATRIX_LOADED] = "true"
    try:
        sys.path.append(os.path.join(sys.path[0], 'jmatrix'))
        config.source("jmatrix/jmatrix/integrations/qutebrowser.py")
    except ValueError:
        pass

# load theme
config.source('qutewal.py')

# load local config
local_config_file = "config.local.py"
try:
    with (config.configdir / local_config_file).open() as f:
        config.source(local_config_file)
except IOError:
    pass
