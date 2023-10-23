# Use x86 VMs on Apple Silicon

**This tool is designed for Apple Silicon ARM CPUs to convert a provided OVA file into QCOW2 format for use with UTM. The output .qcow2 file will have the same base name as the input .ova file.**

## Usage

```bash
./convert_and_split.sh /path/to/your/file.ova
```

## Prerequisites
* The machine should have an Apple Silicon ARM CPU.

* Root privileges are required to run the script.

* The qemu-img utility must be installed. 

* UTM

## Where to Get UTM
UTM is an open-source virtualization solution for macOS, iOS, and iPadOS. You can download the latest version, find documentation, and access the source code from their official website or GitHub repository:

Official Website: <https://getutm.app/> 

GitHub Repository: <https://github.com/utmapp/UTM>

## Notes
1. The script checks if the provided OVA file exists and is readable.

2. Extracts the OVA file to retrieve the .vmdk files.

3. Converts the .vmdk files to .qcow2 format suitable for UTM. 

4. If there's more than one .vmdk file, they will be combined and converted into a single .qcow2 file with the same base name as the input .ova file.

## Settings to set in UTM
**If not shown on the screenshot, then please let the default values selected and continue with the setup.**

![Neue Virtuelle Maschine erstellen auswählen](<./images/CleanShot 2023-10-14 at 10.38.56@2x.png>)
![Emulate auswählen](<./images/CleanShot 2023-10-14 at 10.39.19@2x.png>)
![Andere auswählen](<./images/CleanShot 2023-10-14 at 10.40.00@2x.png>)
![Skip Iso Boot auswählen](<./images/CleanShot 2023-10-14 at 10.41.07@2x.png>)
![Zusammenfassung VM](<./images/CleanShot 2023-10-14 at 10.42.36@2x.png>)
![Edit Auswählen mit rechtsklick auf VM](<./images/CleanShot 2023-10-14 at 10.43.09@2x.png>)
![Passende CPU auswählen](<./images/CleanShot 2023-10-14 at 10.43.38@2x.png>)
### Liste von supporteten CPUs
Read more about the issue here: <https://github.com/utmapp/UTM/issues/4286>

List of supported CPUs: <https://www.qemu.org/docs/master/system/i386/cpu.html>

**Choose one that supports x86 Emulation!**
![Intel Core Processor Broadwell-v3 ausgewählt](<./images/CleanShot 2023-10-14 at 10.46.07@2x.png>)
![Disable UEFI Boot, leave others as is](<./images/CleanShot 2023-10-14 at 10.46.57@2x.png>)

### Import generated qcow2 file

![Choose New Drive](<./images/CleanShot 2023-10-14 at 10.48.05@2x.png>)
![Click on Import](<./images/CleanShot 2023-10-14 at 10.49.12@2x.png>)
![Choose your QCOW2 File](<./images/CleanShot 2023-10-14 at 10.50.00@2x.png>)
![Boot Order choose it by drag and drop, drag the one you created on top of the IDE Drive](<./images/CleanShot 2023-10-14 at 10.51.03@2x.png>)
![Click on Save](<./images/CleanShot 2023-10-14 at 10.52.26@2x.png>)

### Boot the VM afterwards
Congrats, now you have your x86 VM running on MacOS ARM.

**First Boot is slow. Just wait.**# run-x86-utm


### Enable Multicore

This is where it gets really good, but could end up being unstable.
![Alt text](<./images/CleanShot 2023-10-23 at 16.56.29@2x.png>)