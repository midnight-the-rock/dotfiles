-- Reverie Xmonad Configs
-- Author: midnight-the-rock

import XMonad

import XMonad.Util.EZConfig(additionalKeysP)
import XMonad.Util.SpawnOnce 

import XMonad.Layout.Gaps
import XMonad.Layout.Grid
import XMonad.Layout.Spacing

import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.EwmhDesktops

reverieKeybinds :: [(String, X())]
reverieKeybinds =  [ ("M-s",   spawn "scrot -u")
		   , ("M-S-s", spawn "scrot -s")
		   , ("M-p",   spawn "rofi -show drun")
		   , ("M-r",   spawn "redshift -P -O 3500")
		   , ("M-S-r", spawn "redshift -x")
		   , ("<XF86AudioNext>", spawn "playerctl next")
		   , ("<XF86AudioPrev>", spawn "playerctl previous")
		   , ("<XF86AudioPlay>", spawn "playerctl play-pause")
		   , ("<XF86AudioRaiseVolume>",    spawn "amixer sset Master 5+")
		   , ("<XF86AudioLowerVolume>",    spawn "amixer sset Master 5-")
		   , ("M-<XF86AudioRaiseVolume>",  spawn "brightnessctl set 5%+")
		   , ("M-<XF86AudioLowerVolume>",  spawn "brightnessctl set 5%-")
		   , ("M-d", spawn "bash /home/midnight/.config/eww/scripts/dashboard.sh")
		   ]

reverieLayout =
  avoidStruts
  . spacing windowSpacing
  . gaps    windowGaps
  $ windowTall ||| Grid ||| Full
  where
    windowSpacing = 5
    windowGaps    = [(U, 8), (D, 8), (R,10), (L, 10)]
    windowTall    = Tall 1 (3/100) (1/2)

reverieStartup :: X()
reverieStartup = do
  spawnOnce "setxkbmap -layout es,apl -option grp:win_switch -option ctrl:nocaps"
  spawnOnce "eww open status_bar"

reverieSetup = def
  { terminal           = "env XMODIFIERS= emacs"
  , borderWidth        = 4
  , normalBorderColor  = "#262026"
  , focusedBorderColor = "#dbd7d2"
  , manageHook         = manageHook def <+> manageDocks
  , layoutHook         = reverieLayout
  , startupHook        = reverieStartup
  } `additionalKeysP`    reverieKeybinds

main :: IO()
main = xmonad $ ewmh $ ewmhFullscreen $ reverieSetup
