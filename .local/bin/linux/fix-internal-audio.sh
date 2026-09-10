#!/usr/bin/env bash
# Works around a PipeWire/ALSA-UCM bug on this ThinkPad's sof-hda-dsp card
# (tracked upstream: https://github.com/alsa-project/alsa-ucm-conf/issues/720).
#
# "Speaker" and "Headphones" are mutually-exclusive ALSA card profiles that
# share the same PCM device. The "Headphones" profile has a higher priority
# (10300 vs 10200) and gets auto-selected at boot even though its jack is
# unplugged, which makes the Speaker sink not exist at all (not just
# "unavailable") - so nothing can ever default to it. Also, because that
# profile's only port is jack-gated and never treated as properly "active",
# ALSA/UCM never runs its EnableSequence, leaving the Speaker/Headphone/
# Capture hardware switches muted from power-on.
#
# Run after wireplumber (re)starts: switch to the profile that includes the
# Speaker sink, make it the default, and unmute the hardware switches.

set -euo pipefail

CARD_ALSA="sofhdadsp"
CARD_PW="alsa_card.pci-0000_00_1f.3-platform-skl_hda_dsp_generic"
SPEAKER_PROFILE="HiFi (HDMI1, HDMI2, HDMI3, Mic1, Mic2, Speaker)"
SPEAKER_SINK="alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Speaker__sink"

for _ in $(seq 1 20); do
	amixer -c "$CARD_ALSA" scontrols &>/dev/null && break
	sleep 0.5
done

for _ in $(seq 1 20); do
	pactl list cards short 2>/dev/null | grep -q "$CARD_PW" && break
	sleep 0.5
done

pactl set-card-profile "$CARD_PW" "$SPEAKER_PROFILE"

for _ in $(seq 1 20); do
	pactl list short sinks 2>/dev/null | grep -q "$SPEAKER_SINK" && break
	sleep 0.5
done

pactl set-default-sink "$SPEAKER_SINK"

amixer -c "$CARD_ALSA" sset Speaker unmute
amixer -c "$CARD_ALSA" sset Headphone unmute
amixer -c "$CARD_ALSA" sset Capture cap
amixer -c "$CARD_ALSA" sset Dmic0 cap
amixer -c "$CARD_ALSA" sset 'Auto-Mute Mode' Enabled
