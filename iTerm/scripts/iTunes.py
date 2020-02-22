import iterm2
import sys
import os
import locale

from subprocess import Popen, PIPE
from functools import partial


def get_preferred_input_encoding():
    if hasattr(locale, 'LC_MESSAGES'):
        return (
            locale.getlocale(locale.LC_MESSAGES)[1]
            or locale.getdefaultlocale()[1]
            or 'latin1'
        )
    return (
        locale.getdefaultlocale()[1]
        or 'latin1'
    )


def get_preferred_output_encoding():
    if hasattr(locale, 'LC_MESSAGES'):
        return (
            locale.getlocale(locale.LC_MESSAGES)[1]
            or locale.getdefaultlocale()[1]
            or 'ascii'
        )
    return (
        locale.getdefaultlocale()[1]
        or 'ascii'
    )


def _convert_seconds(seconds):
    return '{0:.0f}:{1:02.0f}'.format(*divmod(float(seconds), 60))


def _convert_state(state):
    state = state.lower()
    if 'play' in state:
        return '▶'
    if 'pause' in state:
        return '▮▮'
    if 'stop' in state:
        return '▮▮'
    return 'fallback'


def run_cmd(cmd, stdin=None, strip=True):
    try:
        p = Popen(cmd, shell=False, stdout=PIPE, stdin=PIPE)
    except OSError as e:
        return None
    else:
        stdout, err = p.communicate(
                stdin if stdin is None else stdin.encode(get_preferred_output_encoding()))
        stdout = stdout.decode(get_preferred_input_encoding())
    return stdout.strip() if strip else stdout


def asrun(ascript):
    return run_cmd(['osascript', '-'], ascript)


async def main(connection):
    component = iterm2.StatusBarComponent(
            short_description="iTunes",
            detailed_description="This Component shows itunes",
            knobs=[],
            exemplar="iTunes",
            update_cadence=1,
            identifier="com.iterm2.example.status-bar-demo")

    @iterm2.StatusBarRPC
    async def coro(
            knobs,
            rows=iterm2.Reference("rows"),
            cols=iterm2.Reference("columns")):
        status_delimiter = '-~`/='
        ascript = '''
            tell application "System Events"
                set process_list to (name of every process)
            end tell

            if process_list contains "Music" then
                tell application "Music"
                    set t_title to name of current track
                    set t_artist to artist of current track
                    set t_album to album of current track
                    set t_duration to duration of current track
                    set t_elapsed to player position
                    set t_state to player state
                    return t_title & "{0}" & t_artist & "{0}" & t_album & "{0}" & t_elapsed & "{0}" & t_duration & "{0}" & t_state
                    end tell
            end if
        '''.format(status_delimiter)
        now_playing = asrun(ascript)
        if not now_playing:
            return ""
        now_playing = now_playing.split(status_delimiter)
        if len(now_playing) != 6:
            return
        title, artist, album = now_playing[0], now_playing[1], now_playing[2]
        state = _convert_state(now_playing[5])
        total = _convert_seconds(now_playing[4].replace(',', '.'))
        elapsed = _convert_seconds(now_playing[3].replace(',', '.'))

        return "{} {} - {} {} {}".format(state, artist, title, elapsed, total)

    # Register the component.
    await component.async_register(connection, coro)

iterm2.run_forever(main)
