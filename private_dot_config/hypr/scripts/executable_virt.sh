#!/bin/bash

ISO_PATH="$HOME/.qemu/windows10.iso"
DISK_PATH="$HOME/.qemu/windows10.qcow2"
DISK_SIZE="60G"
MEMORY="6G"
CPU="4"
VM_NAME="windows10"

# Funkcja do wyłączania wszystkich uruchomionych maszyn wirtualnych
shutdown_vms() {
  echo "Wyłączam wszystkie uruchomione maszyny wirtualne..."
  # Znajdowanie i zabijanie wszystkich procesów qemu-system-x86_64
  pgrep -f qemu-system-x86_64 | xargs -r kill
  exit 0 # Kończymy działanie skryptu
}

# Sprawdzenie, czy jakakolwiek maszyna wirtualna jest uruchomiona
if pgrep -f qemu-system-x86_64 >/dev/null; then
  shutdown_vms
fi

# Sprawdzenie, czy VM o nazwie windows10 już istnieje
if [ -f "$DISK_PATH" ]; then
  echo "Maszyna wirtualna $VM_NAME już istnieje. Uruchamiam..."

  # Uruchamianie istniejącej maszyny
  qemu-system-x86_64 \
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
    -display default,show-cursor=off \
    -device ich9-intel-hda -device hda-duplex

else
  echo "Maszyna wirtualna $VM_NAME nie istnieje. Tworzę nową..."

  # Tworzenie katalogu na dysk i ISO
  mkdir -p "$HOME/.qemu"

  # Sprawdzenie, czy ISO istnieje
  if [ ! -f "$ISO_PATH" ]; then
    echo "Brak pliku ISO. Otwieram stronę do pobrania Windows 10 w przeglądarce."
    xdg-open "https://www.microsoft.com/pl-pl/software-download/windows10" # Otwiera stronę pobierania
    exit 1                                                                 # Kończymy działanie skryptu, gdy ISO nie istnieje
  else
    echo "ISO Windows 10 już istnieje."
  fi

  # Tworzenie dynamicznego dysku w formacie qcow2
  echo "Tworzę dysk wirtualny o rozmiarze $DISK_SIZE..."
  qemu-img create -f qcow2 "$DISK_PATH" "$DISK_SIZE"

  # Tworzenie i uruchamianie maszyny wirtualnej po raz pierwszy z instalacją
  echo "Tworzę i uruchamiam maszynę wirtualną $VM_NAME po raz pierwszy..."

  qemu-system-x86_64 \
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
    -display default,show-cursor=on \
    -soundhw hda
fi
