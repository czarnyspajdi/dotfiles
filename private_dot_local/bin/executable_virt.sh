#!/bin/bash

ISO_PATH="$HOME/.qemu/windows10.iso"
DISK_PATH="$HOME/.qemu/windows10.qcow2"
DISK_SIZE="60G"
MEMORY="$(($(grep MemTotal /proc/meminfo | awk '{print $2}') / 2048))"
CPU="$((($(nproc) + 1) / 2))"
VM_NAME="windows10"

# Funkcja wyłączania uruchomionych maszyn wirtualnych
shutdown_vms() {
  notify-send "Maszyna wirtualna" "Wyłączanie wszystkich maszyn..."
  pkill -SIGTERM -f qemu-system-x86_64 || echo "Brak uruchomionych maszyn."
  exit 0
}

# Sprawdzenie uruchomionych maszyn
if pgrep -f qemu-system-x86_64 >/dev/null; then
  shutdown_vms
fi

# Uruchomienie istniejącej maszyny
if [ -f "$DISK_PATH" ]; then
  notify-send "Maszyna wirtualna" "Uruchamianie $VM_NAME..."
  exec qemu-system-x86_64 \
    -name "$VM_NAME" \
    -m "$MEMORY" \
    -smp "$CPU" \
    -hda "$DISK_PATH" \
    -vga virtio \
    -boot order=c \
    -usb -device usb-tablet \
    -display sdl,gl=on \
    -enable-kvm \
    -cpu host \
    -device ich9-intel-hda -device hda-duplex
fi

# Tworzenie maszyny, jeśli nie istnieje
mkdir -p "$HOME/.qemu"

if [ ! -f "$ISO_PATH" ]; then
  notify-send "Maszyna wirtualna" "Pobierz ISO Windows 10 i zapisz jako $ISO_PATH"
  xdg-open "https://www.microsoft.com/pl-pl/software-download/windows10"
  exit 1
fi

notify-send "Maszyna wirtualna" "Tworzenie dysku $DISK_SIZE dla $VM_NAME..."
qemu-img create -f qcow2 "$DISK_PATH" "$DISK_SIZE"

notify-send "Maszyna wirtualna" "Uruchamianie instalatora Windows..."
exec qemu-system-x86_64 \
  -name "$VM_NAME" \
  -m "$MEMORY" \
  -smp "$CPU" \
  -hda "$DISK_PATH" \
  -cdrom "$ISO_PATH" \
  -boot order=d \
  -device virtio-net,netdev=net0 \
  -netdev user,id=net0 \
  -vga virtio \
  -enable-kvm \
  -cpu host \
  -soundhw hda \
  -display sdl,gl=on
