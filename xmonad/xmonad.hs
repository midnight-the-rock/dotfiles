-- Reverie Xmonad Configs
-- Author: midnight-the-rock

import XMonad

import XMonad.Util.EZConfig(additionalKeysP)
import XMonad.Util.SpawnOnce 

import XMonad.Layout.Gaps
import XMonad.Layout.Spacing
import XMonad.Layout.ThreeColumns

import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.EwmhDesktops

screenControl :: [(String, X())]
screenControl = [ ("M-s",   spawn "scrot -u")
		, ("M-S-s", spawn "scrot -s")
		, ("M-r",   spawn "redshift -P -O 3500")
		, ("M-S-r", spawn "redshift -x")
		, ("M-<XF86AudioRaiseVolume>",  spawn "brightnessctl set 5%+")
		, ("M-<XF86AudioLowerVolume>",  spawn "brightnessctl set 5%-")
		]

audioControl :: [(String, X())]
audioControl = [ ("<XF86AudioNext>", spawn "playerctl next")
	       , ("<XF86AudioPrev>", spawn "playerctl previous")
	       , ("<XF86AudioPlay>", spawn "playerctl play-pause")
	       , ("<XF86AudioRaiseVolume>", spawn "amixer sset Master 5+")
	       , ("<XF86AudioLowerVolume>", spawn "amixer sset Master 5-")
	       ]

launchControl :: [(String, X())]
launchControl = [ ("M-<Return>", spawn "kitty")
		, ("M-S-<Return>", spawn "env XMODIFIERS= emacs")
		, ("M-p", spawn "rofi -show drun")
		, ("M-d", spawn "bash /home/midnight/.config/eww/scripts/dashboard.sh")
		]

myKeybinds :: [(String, X())]
myKeybinds = screenControl ++ audioControl ++ launchControl

myLayout =
  avoidStruts
  . gaps windowGaps
  . spacing windowSpacing
  $ layoutTall ||| layoutThreeCol ||| Full
  where
    windowGaps     = [(U, 8), (D, 8), (R,10), (L, 10)]
    layoutTall     = Tall 1 (3/100) (1/2)
    layoutThreeCol = ThreeCol 1 (3/100) (1/2)
    windowSpacing  = 5

myStartup :: X()
myStartup = do
  spawnOnce "setxkbmap -layout es,apl -option grp:win_switch -option ctrl:nocaps"
  spawnOnce "eww open status_bar"

mySetup = def
  { borderWidth        = 2
  , normalBorderColor  = "#262026"
  , focusedBorderColor = "#b1a7a8"
  , manageHook         = manageHook def <+> manageDocks
  , layoutHook         = myLayout
  , startupHook        = myStartup
  } `additionalKeysP` myKeybinds

main :: IO()
main = xmonad $ ewmh $ ewmhFullscreen $ mySetup
