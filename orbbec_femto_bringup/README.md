# orbbec_femto_bringup

Launch files for Orbbec Femto Bolt cameras

## Usage


### Using Multiple Cameras

#### 1. Increase usbfs_memory_mb Value (CRITICAL STEP)

**IMPORTANT: This step is crucial for multi-camera setups. Without increasing the usbfs_memory_mb value, you may not receive any data from your cameras.**

For multi-camera setups, it's essential to increase the `usbfs_memory_mb` value. Set it to 128MB (adjustable based on your system's needs) by running:

```bash
echo 128 | sudo tee /sys/module/usbcore/parameters/usbfs_memory_mb
```

To increase the buffer size permanently, add the kernel parameter `usbcore.usbfs_memory_mb=128` to the bootloader configuration.
How to do this depends on the bootloader on your system.

For GRUB2 (most common):

1. Open `/etc/default/grub`. Replace: `GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"` (or other contents within the quotation marks depending on your system) with:
`GRUB_CMDLINE_LINUX_DEFAULT="quiet splash usbcore.usbfs_memory_mb=128"`
2. Update grub

   ```bash
    sudo update-grub
   ```

3. reboot your system and check

```bash
cat /sys/module/usbcore/parameters/usbfs_memory_mb
```

Other bootloaders: configure additional kernel parameters of other bootloaders, please see the manual of your bootloader.

If you skip this step or set the value too low, your cameras may not function properly or may not provide any data at all.

#### 2. Identifying Camera Serial Numbers

To set properly the `serial_number` parameter for each node, you can use the convenience script `list_ob_devices.sh` in the `utils` folder to list all connected Orbbec devices with their USB ports and serial numbers.
