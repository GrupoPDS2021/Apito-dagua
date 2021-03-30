miniDSP micArray VF (PCB Rev0.6 or after)

1. Upgrade with micArray_vf_raw_v1.0_up.bin
	If fail, replug the USB to try again
	If success, you will see the 4x blue LEDs lights up
2. Replug the USB and upgrade with micArray_vf_spk_v1.2_up.bin
	If fail, and you see the LED rings light up in rotating color, redo step 1
	If success, you will see one of the blinking when there is voice
3. Reinstall the driver if you're using Windows OS



miniDSP USB Audio 2.0 Device Firmware Upgrade steps (For OSX)

3. Run miniDSP UAC2 DFU Tool
	miniDSP_UAC2_DFU_OSX/DFU Utility

3a. Click "Browse..." and choose file firmware_name.bin

3b. Click "Start" and wait for the progress bar to load, this will take 30 second to a minute

3c. If the stay in "Entering upgrade mode..." for more then 30 second, replug the USB cable


miniDSP USB Audio 2.0 Device Firmware Upgrade steps (For Windows)


1. Install the Windows UAC2 Driver

2. Connect the miniDSP UAC2 Device (USBStreamer / miniDSP 2x4n etc....)

3. Run miniDSP UAC2 DFU Tool
	miniDSP_UAC2_DFU_Win/miniDSPUAC2Dfu.exe

3a. Click "Browse..." and choose file firmware_name.bin

3b. Click "Start" and wait for the progress bar to load, this will take 30 second to a minute

3c. If the stay in "Entering upgrade mode..." for more then 30 second, replug the USB cable


--Change Log--

micArray_vf_spk_v1.2_up.bin
-Enable DOA
	HID interrupt format: 0x06 0x36 "status 0x00/0x01" "0~359 (2bytes)" "mic no" 

micArray_vf_spk_v1.1_up.bin
-Enable I2S Output on the header pin

