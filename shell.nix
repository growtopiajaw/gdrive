{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell { buildInputs = with pkgs; [ direnv go_1_18 gopls gotools git ]; }
