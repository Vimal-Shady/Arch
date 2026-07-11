# Add local binaries to PATH (if installed there)
fish_add_path ~/.local/bin
function fish_greeting
end
# Initialize Oh My Posh
oh-my-posh init fish --config ~/.config/ohmyposh/themes/shady-minimal.omp.json | source