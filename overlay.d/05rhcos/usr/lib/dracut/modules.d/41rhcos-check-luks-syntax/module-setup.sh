#!/bin/bash

install_unit() {
    local unit="$1"; shift
    local target="${1:-ignition-complete.target}"; shift
    local instantiated="${1:-$unit}"; shift
    inst_simple "$moddir/$unit" "$systemdsystemunitdir/$unit"
    mkdir -p "$initdir/$systemdsystemunitdir/$target.requires"
    ln_r "../$unit" "$systemdsystemunitdir/$target.requires/$instantiated"
}

install() {
    inst_script "$moddir/rhcos-fail-boot-for-legacy-luks-config" \
        "/usr/libexec/rhcos-fail-boot-for-legacy-luks-config"
    
    install_unit rhcos-fail-boot-for-legacy-luks-config.service
}
