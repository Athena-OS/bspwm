#!/usr/bin/env bash
#  ███╗   ███╗███████╗██╗     ██╗███████╗███████╗ █████╗     ██████╗ ██╗ ██████╗███████╗
#  ████╗ ████║██╔════╝██║     ██║██╔════╝██╔════╝██╔══██╗    ██╔══██╗██║██╔════╝██╔════╝
#  ██╔████╔██║█████╗  ██║     ██║███████╗███████╗███████║    ██████╔╝██║██║     █████╗
#  ██║╚██╔╝██║██╔══╝  ██║     ██║╚════██║╚════██║██╔══██║    ██╔══██╗██║██║     ██╔══╝
#  ██║ ╚═╝ ██║███████╗███████╗██║███████║███████║██║  ██║    ██║  ██║██║╚██████╗███████╗
#  ╚═╝     ╚═╝╚══════╝╚══════╝╚═╝╚══════╝╚══════╝╚═╝  ╚═╝    ╚═╝  ╚═╝╚═╝ ╚═════╝╚══════╝
#  About   :  This file will configure and launch the rice.
#

# Set bspwm configuration for Melissa
set_bspwm_config() {
		bspc config border_width 0
		bspc config top_padding 42
		bspc config bottom_padding 40
		bspc config normal_border_color "#e5e9f0"
		bspc config active_border_color "#e5e9f0"
		bspc config focused_border_color "#4c566a"
		bspc config presel_feedback_color "#bf616a"
		bspc config left_padding 2
		bspc config right_padding 2
		bspc config window_gap 6
}

# Reload terminal colors
set_term_config() {
		sed -i "$HOME"/.config/alacritty/fonts.yml \
		-e "s/family: .*/family: JetBrainsMono Nerd Font/g" \
		-e "s/size: .*/size: 10/g"

		cat > "$HOME"/.config/alacritty/colors.yml <<- _EOF_
				colors:
				  primary:
				    background: '#2e3440'
				    foreground: '#d8dee9'

				  normal:
				    black:   '#2d2b36'
				    red:     '#e7034a'
				    green:   '#61b33e'
				    yellow:  '#ffb964'
				    blue:    '#5884d4'
				    magenta: '#7a44e3'
				    cyan:    '#7df0f0'
				    white:   '#faf7ff'

				  bright:
				    black:   '#373542'
				    red:     '#e71c5b'
				    green:   '#6fb352'
				    yellow:  '#ffb964'
				    blue:    '#5f90ea'
				    magenta: '#8656e3'
				    cyan:    '#97f0f0'
				    white:   '#fdfcff'

				  cursor:
				     cursor: '#8656e3'
				     text:	'#0b0b12'
_EOF_
}

# Set compositor configuration
set_picom_config() {
		sed -i "$HOME"/.config/bspwm/picom.conf \
			-e "s/normal = .*/normal =  { fade = true; shadow = true; }/g" \
			-e "s/shadow-color = .*/shadow-color = \"#000000\"/g" \
			-e "s/corner-radius = .*/corner-radius = 6/g" \
			-e "s/\".*:class_g = 'Alacritty'\"/\"98:class_g = 'Alacritty'\"/g" \
			-e "s/\".*:class_g = 'FloaTerm'\"/\"98:class_g = 'FloaTerm'\"/g"
}

# Set dunst notification daemon config
set_dunst_config() {
		sed -i "$HOME"/.config/bspwm/dunstrc \
		-e "s/transparency = .*/transparency = 4/g" \
		-e "s/frame_color = .*/frame_color = \"#2e3440\"/g" \
		-e "s/separator_color = .*/separator_color = \"#a3be8c\"/g" \
		-e "s/font = .*/font = JetBrainsMono Nerd Font Medium 9/g" \
		-e "s/foreground='.*'/foreground='#81a1c1'/g"

		sed -i '/urgency_low/Q' "$HOME"/.config/bspwm/dunstrc
		cat >> "$HOME"/.config/bspwm/dunstrc <<- _EOF_
				[urgency_low]
				timeout = 3
				background = "#2e3440"
				foreground = "#d8dee9"

				[urgency_normal]
				timeout = 6
				background = "#2e3440"
				foreground = "#d8dee9"

				[urgency_critical]
				timeout = 0
				background = "#2e3440"
				foreground = "#d8dee9"
_EOF_
}

# Launch the bar
launch_bars() {
    active_interface=$(ip route get 8.8.8.8 | awk '/dev/ { print $5; exit }')
    sed -i "s/\(interface\s*=\s*\).*/\1$active_interface/" ${rice_dir}/modules.ini
		polybar -q mel-bar -c ${rice_dir}/config.ini &
		polybar -q mel2-bar -c ${rice_dir}/config.ini &
}


# change rofi theme to catppuccinred
rofi_nordblue(){
    $HOME/.config/rofi/Themes/colors nordblue
}


network_config(){
  interface_type=$(ip route get 8.8.8.8 2>/dev/null | awk '/dev/ { print $5; exit }')

  function using_interface(){
  if [[ $interface_type = w* ]]; then
      echo "wireless"
  else
      echo "wired"
  fi
  }
using_interface
sed -i "s/\(interface-type\s*=\s*\).*/\1`using_interface`/" ${rice_dir}/modules.ini
}

### ---------- Apply Configurations ---------- ###

set_bspwm_config
set_term_config
set_picom_config
set_dunst_config
launch_bars
rofi_nordblue
network_config
