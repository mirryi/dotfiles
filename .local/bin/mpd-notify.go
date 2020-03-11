#!/usr/bin/gorun

package main

import (
	"fmt"
	"html"
	"log"
	"os"
	"os/exec"
	"path/filepath"
	"strconv"
	"time"

	"github.com/fhs/gompd/mpd"
)

func main() {
	mpdClient, err := mpd.DialAuthenticated("tcp", ":6600", "")
	if err != nil {
		log.Fatal("Could not connect to MPD: ", err)
		os.Exit(1)
	}

	service := &MPDNotify{mpdClient, "/home/dophin2009/files/music/library", nil, nil}

	if len(os.Args) > 1 && os.Args[1] == "-n" {
		service.NotifyState()
	} else {
		service.Start()
	}
}

type NotificationUrgency int

const (
	UrgencyLow = iota
	UrgencyNormal
	UrgencyCritical
)

func (nu NotificationUrgency) String() string {
	switch nu {
	case UrgencyLow:
		return "low"
	case UrgencyNormal:
		return "normal"
	case UrgencyCritical:
		return "critical"
	default:
		return "normal"
	}
}

type MPDNotify struct {
	client      *mpd.Client
	libraryPath string

	song   map[string]string
	status map[string]string
}

func (n *MPDNotify) Start() {
	song, err := n.client.CurrentSong()
	if err == nil {
		n.song = song
	}

	for {
		n.NotifyState()
		time.Sleep(1000 * time.Millisecond)
	}
}

func (n *MPDNotify) NotifyState() {
	status, err := n.client.Status()
	if err != nil {
		return
	}

	state, ok := status["state"]
	if !ok {
		return
	}

	song, err := n.client.CurrentSong()
	if err != nil {
		return
	}

	id, ok := song["Id"]
	if !ok {
		return
	}

	if (n.status == nil || state != n.status["state"]) ||
		(n.song == nil || id != n.song["Id"]) {

		title, ok := song["Title"]
		if !ok {
			title = "Title?"
		}
		title = html.EscapeString(title)

		album, ok := song["Album"]
		if !ok {
			album = "Album?"
		}
		album = html.EscapeString(album)

		duration, ok := song["duration"]
		if !ok {
			duration = "0.0"
		}
		duration = secondsToTimeString(duration)

		iconPath := ""
		if path, ok := song["file"]; ok {
			dir := filepath.Dir(filepath.Join(n.libraryPath, path))
			for _, cover := range []string{"cover.jpg", "cover.png"} {
				coverPath := filepath.Join(dir, cover)
				if _, err := os.Stat(coverPath); !os.IsNotExist(err) {
					iconPath = coverPath
					break
				}
			}
		}

		if (n.song == nil || id != n.song["Id"]) &&
			!(n.status == nil || state != n.status["state"]) {
			n.song = song

			n.Notify(title, fmt.Sprintf("<i>%s</i>\n%s", album, duration), UrgencyNormal, iconPath)
		} else {
			n.song = song
		}

		if n.status == nil || state != n.status["state"] {
			n.status = status

			elapsed, ok := status["elapsed"]
			if !ok {
				elapsed = "??:??"
			} else {
				elapsed = secondsToTimeString(elapsed)
			}

			if state == "play" {
				mode := ""
				if repeat, ok := status["repeat"]; ok && repeat == "1" {
					mode += "r"
				}
				if random, ok := status["random"]; ok && random == "1" {
					mode += "z"
				}
				if single, ok := status["single"]; ok && single == "1" {
					mode += "s"
				}

				n.Notify(fmt.Sprintf("Playing [%s] - %s", mode, title),
					fmt.Sprintf("<i>%s</i>\n%s / %s", album, elapsed, duration),
					UrgencyNormal, iconPath)
			}

			if state == "pause" {
				n.Notify(fmt.Sprintf("Paused - %s", title),
					fmt.Sprintf("<i>%s</i>\n%s / %s", album, elapsed, duration),
					UrgencyNormal, iconPath)
			}
		}
	}
}

func (n *MPDNotify) Notify(summary string, details string, urgency NotificationUrgency, iconPath string) {
	args := []string{summary, details, "-u", urgency.String(), "-i", iconPath, "-a", "mpd"}
	exec.Command("notify-send", args...).Run()
}

func secondsToTimeString(seconds string) string {
	duration, err := strconv.ParseFloat(seconds, 64)
	if err != nil {
		seconds = "00:00"
	}
	return fmtDuration(time.Duration(duration) * time.Second)
}

func fmtDuration(d time.Duration) string {
	d = d.Round(time.Second)
	return fmt.Sprintf("%02d:%02d", int(d.Minutes()), int(d.Seconds())%60)
}
