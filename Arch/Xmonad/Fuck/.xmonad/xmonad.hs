import XMonad
import Control.Monad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import XMonad.Layout.Spacing
import XMonad.Layout.ResizableTile
import XMonad.Layout.SimpleFloat
import XMonad.Layout.NoBorders	  (noBorders)
import XMonad.Layout.PerWorkspace (onWorkspace)
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import qualified GHC.IO.Handle.Types as H

fro 	= "^i(/home/tiago/.xmonad/.icons/xbm8x8/fro_01.xbm)"

--------------------------------------------------------------------------
-- workspace --
--------------------------------------------------------------------------

myWorkspaces	:: [String]
myWorkspaces	= clickable $ [ "^i(/home/tiago/.xmonad/.icons/stlarch/grid.xbm)  Term "++fro++""
			      , "^i(/home/tiago/.xmonad/.icons/xbm8x8/cpu.xbm)  Web "++fro++""
			      , "^i(/home/tiago/.xmonad/.icons/xbm8x8/fox.xbm)  Code "++fro++""
			      , "^i(/home/tiago/.xmonad/.icons/xbm8x8/info_02.xbm)  Archive "++fro++""
			      , "^i(/home/tiago/.xmonad/.icons/xbm8x8/phones.xbm)  Docs "++fro++""
			      ]
		where clickable l 	= [ "^ca(1,xdotool key super+" ++ show (n) ++ ")" ++ ws ++ "^ca()" |
					    (i,ws) <- zip [1..] l,
					    let n = i ]

laycon		= "/home/tiago/.xmonad/.icons/stlarch/"

--------------------------------------------------------------------------
-- style --
--------------------------------------------------------------------------
myLogHook h = do
	dynamicLogWithPP $ tryPP h
tryPP :: Handle -> PP
tryPP h = defaultPP
	{ ppOutput		= hPutStrLn h
	, ppCurrent 		= dzenColor "#f8f8f8" "#151515" . pad
	, ppVisible		= dzenColor "#808080" "#151515" . pad
	, ppHidden		= dzenColor "#808080" "#151515" . pad
	, ppHiddenNoWindows	= dzenColor "#8f8f8f" "#151515" . pad
	, ppWsSep		= ""
	, ppSep			= " "
	, ppLayout		= dzenColor "#b3b3b3" "#151515" .
				  ( \x -> case x of
					"Spacing 20 ResizableTall"	-> "^ca(1,xdotool key super+space)^i("++laycon++"tile.xbm)^ca()"
					"Simple Float"			-> "^ca(1,xdotool key super+space)^i("++laycon++"float.xbm)^ca()"
					"Full"				-> "^ca(1,xdotool key super+space)^i("++laycon++"monocle2.xbm)^ca()"
					"ResizableTall"			-> "^ca(1,xdotool key super+space)^i("++laycon++"ntile.xbm)^ca()"
					"Mirror ResizableTall"		-> "^ca(1,xdotool key super+space)^i("++laycon++"nbstack.xbm)^ca()"
				  )
	}

dzenFont = "lime-11"

---------------------------------------------------------------------------
-- additional key --
---------------------------------------------------------------------------
myKeys = [ ((mod4Mask, xK_a), spawn "firefox")
        , ((mod4Mask, xK_p), spawn  "dmenu_run -x 3 -y 20 -w 180 -l 5 -h 16 -i -q -fn 'xft:FontAwesome:pixelsize=10' -nb '#1D1F21' -nf '#FAFAFA' -sb '#151515' -sf '#FEFEFE'")
        , ((0, xK_Print), spawn "scrot %Y-%m-%d-%T.png -e 'mv $f ~/Imagens'")
        , ((mod4Mask, xK_q), spawn "killall dzen2; xmonad --recompile; xmonad --restart")]



---------------------------------------------------------------------------
-- layout tiling --
---------------------------------------------------------------------------

myLayout = spacing 20 $ ResizableTall 2 (3/200) (7/13) []
tiled	 = ResizableTall 2 (2/300) (1/2) []

---------------------------------------------------------------------------
-- main code --
---------------------------------------------------------------------------

main = do
	bar <- spawnPipe dzenbar
	bar2 <- spawnPipe "sh /home/tiago/.xmonad/dzenbar.sh"
	xmonad $ defaultConfig
		{ manageHook = manageDocks <+> manageHook defaultConfig
		, layoutHook = avoidStruts $ myLayout ||| simpleFloat ||| Full ||| tiled ||| Mirror tiled 
		, borderWidth = 3
		, normalBorderColor = "#161616"
		, focusedBorderColor = "#161616"
		, terminal = "termite"
		, workspaces = myWorkspaces
		, modMask = mod4Mask
	    , startupHook =  startup <+> setWMName "LG3D"
      	, logHook = myLogHook bar
		} `additionalKeys` myKeys
		where dzenbar	= "dzen2 -p -ta l -e 'button3=' -fn '"
				  ++ dzenFont
				  ++ "' -h 17 -w 650"


startup :: X ()
startup = do
          spawn "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &"
          spawn "nitrogen --restore &"
          spawn "compton --config ~/.config/compton.conf &"

