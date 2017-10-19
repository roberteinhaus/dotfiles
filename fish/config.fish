set fish_greeting ''
fish_vi_key_bindings
set theme_color_scheme gruvbox
command -qs tmux
if test $status -eq 0; and test -z "$TMUX"
    if test "$SSH_CONNECTION" != ""
        tmux -2 attach-session -t ssh; or tmux -2 new-session -s ssh; and exit
    else
        tmux -2 new-session; and exit
    end
else
    source ~/.sh_customvars
end
