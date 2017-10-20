function fish_greeting; end

fish_vi_key_bindings

#     set -g theme_display_git no
#     set -g theme_display_git_untracked no
#     set -g theme_display_git_ahead_verbose yes
#     set -g theme_git_worktree_support yes
set -g theme_display_vagrant no
#     set -g theme_display_docker_machine no
set -g theme_display_hg no
#     set -g theme_display_virtualenv no
#     set -g theme_display_ruby no
set -g theme_display_user no
#     set -g theme_display_vi no
#     set -g theme_avoid_ambiguous_glyphs yes
#     set -g theme_powerline_fonts no
#     set -g theme_nerd_fonts yes
#     set -g theme_show_exit_status yes
set -g default_user nobody
set -g theme_color_scheme gruvbox
#     set -g fish_prompt_pwd_dir_length 0
#     set -g theme_project_dir_length 1
set -g theme_newline_cursor yes

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
