#!/bin/env bash 

paru -S $(cat dependencies.txt)

ln -sf $(pwd)/terminal/zshrc ~/.zshrc 
ln -sf $(pwd)/terminal/kitty ~/.config/kitty 
ln -sf $(pwd)/terminal/starship.toml ~/.config/starship.toml
