#!/bin/bash
orig_iso="$1"
image_volid="$1"

new_files="$orig_iso"_unpacked_and_modified
new_iso="$orig_iso"_modified.iso
mbr_template=isohdpfx.bin

# Extract MBR template file to disk
dd if="$orig_iso" bs=1 count=432 of="$mbr_template"

# Extract image

xorriso -osirrox on -indev "$orig_iso" -extract / "$new_files"

# Delete file "$new_iso" if it exists
test -e "$new_iso" && rm "$new_iso"

#----------edit-------------

delstrings="insmod play\nplay 960 440 1 0 4 440 1"

sed -i -z s/"$delstrings"//g "$new_files"/boot/grub/grub.cfg

#---------------------------


echo "Create the new ISO image"

# Create the new ISO image
xorriso \
   -outdev "$new_iso" \
   -volid "$image_volid" \
   -padding 0 \
   -compliance no_emul_toc \
   -map "$new_files" / \
   -chmod 0755 / -- \
   -boot_image isolinux dir=/isolinux \
   -boot_image isolinux system_area="$mbr_template" \
   -boot_image any next \
   -boot_image any efi_path=boot/grub/efi.img \
   -boot_image isolinux partition_entry=gpt_basdat \
   -stdio_sync off

sudo rm -r "$new_files"
rm "$mbr_template"
echo "Finished."
