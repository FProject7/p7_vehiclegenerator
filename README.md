# Project 7 Vehicle Generator
A simple script that converts your cars from meta to usable formats for qb-core and qbx-core.
## Support
If you need any help with our script, join our discord and open a ticket. [https://discord.gg/mRfn9xXDbh](https://discord.gg/mRfn9xXDbh)

## How to Setup

### Step 1: Download the script
Press the "Code" Button and Download as Zip.

### Step 3: Drop it into your `resources` folder
You can drop it anywhere, it will allways find the resources folder

### Step 4: Configure 
You have to make sure it uses your vehicles folder, you have to do relative pathing from the resources folder (or you can leave it, not recommended tho will use a bit more as it runs thru all folders in the server)

### You are done! You can now stop the script, and your vehicles.lua is in your folder where your server.cfg is located.

## IMPORTANT!
If you are using a folder, and not a resource you do not need to add resources/ to the ResourceName, only the folder path from the resources.

By example lets say i have this:

Myfolder > Resources
  - p7_vehiclegenerator
  - [vehicles]
    -- [car]
has to be just [vehicles]/[car]. and not resources/[vehicles]/[car]
